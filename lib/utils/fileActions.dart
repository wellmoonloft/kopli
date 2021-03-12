import 'dart:io';
import 'package:kopli/commonWidgets/myDialog.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/utils/dbHelper.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class FileActions {
  initFiles(BuildContext context) async {
    await getApplicationDocumentsDirectory().then((value) {
      Directory directory = new Directory('${value.path}/articles');
      if (!directory.existsSync()) {
        directory.createSync();
        print('文档初始化成功，文件保存路径为 ${directory.path}');
      }
      var providerData = Provider.of<ProviderData>(context, listen: false);
      providerData.setDir(directory.path);
      providerData.setActiveArticle(Article());
      providerData.setActveData("");
      providerData.setIsEdit(false);
      providerData.setController("");

      providerData.getArticle();
      providerData.getSorts();
    });
  }

  saveArticle(BuildContext context, Article _article) async {
    var providerData = Provider.of<ProviderData>(context, listen: false);
    providerData.setActiveArticle(_article);
    DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm:ss");
    providerData.activeArticle.editDate = formatter.format(DateTime.now());

    DBHelper().updateArticle(providerData.activeArticle).then((value) {
      File file = new File(
          p.join(providerData.dir, providerData.activeArticle.fileName));
      file.writeAsString(providerData.activeData).whenComplete(() => {
            print("保存成功" +
                p
                    .join(providerData.dir, providerData.activeArticle.fileName)
                    .toString())
          });
      providerData.setIsEdit(false);
    });
  }

  newArticle(BuildContext context) {
    var providerData = Provider.of<ProviderData>(context, listen: false);
    if (providerData.isEdit) {
      _showNewAndLoadDialog(context, "new", null);
    } else {
      initFiles(context);
    }
  }

  loadArticle(BuildContext context, Article _article) async {
    var providerData = Provider.of<ProviderData>(context, listen: false);
    if (providerData.isEdit) {
      _showNewAndLoadDialog(context, "load", _article);
    } else {
      File file = new File(p.join(_article.filePath, _article.fileName));
      var providerData = Provider.of<ProviderData>(context, listen: false);
      providerData.setDir(_article.filePath);
      providerData.setActiveArticle(_article);
      await file.readAsString().then((value) {
        providerData.setActveData(value);
        providerData.setIsEdit(false);
        providerData.setController(value);
      });
    }
  }

  _showNewAndLoadDialog(
      BuildContext context, String isNewLoad, Article _article) {
    return showDialog(
      context: context,
      builder: (context) {
        return MyDialog(
          title: "请注意",
          content: "当前有尚未保存的内容，是否确定放弃？",
          onPress: () async {
            if (isNewLoad == "new") {
              initFiles(context);
            }
            if (isNewLoad == "load") {
              File file =
                  new File(p.join(_article.filePath, _article.fileName));
              var providerData =
                  Provider.of<ProviderData>(context, listen: false);
              providerData.setDir(_article.filePath);
              providerData.setActiveArticle(_article);
              await file.readAsString().then((value) {
                providerData.setActveData(value);
                providerData.setIsEdit(false);
                providerData.setController(value);
              });
            }
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  replaceContent(BuildContext context, String insert1, String insert2) {
    var providerData = Provider.of<ProviderData>(context, listen: false);
    int end = providerData.controller.selection.baseOffset;
    int start = providerData.controller.selection.extentOffset;
    int offset = end + insert1.length + insert2.length + 1;

    TextSelection makeLast = TextSelection.fromPosition(
        TextPosition(affinity: TextAffinity.downstream, offset: offset));
    if (start == end) {
      if (end == providerData.activeData.length) {
        providerData
            .setController(providerData.activeData + "\n" + insert1 + insert2);
        providerData.activeData =
            providerData.activeData + "\n" + insert1 + insert2;
        providerData.controller.selection = makeLast;
      } else {
        String frontSub = providerData.activeData.substring(0, end);
        String endSub = providerData.activeData
            .substring(end, providerData.activeData.length);
        providerData
            .setController(frontSub + "\n" + insert1 + insert2 + "\n" + endSub);
        providerData.activeData =
            frontSub + "\n" + insert1 + insert2 + "\n" + endSub;
        providerData.controller.selection = makeLast;
      }
    } else {
      if (start > end) {
        int temp = start;
        start = end;
        end = temp;
      }
      if (end == providerData.activeData.length) {
        String frontSub = providerData.activeData.substring(0, start);
        String endSub = providerData.activeData
            .substring(start, providerData.activeData.length);
        endSub = "\n" + insert1 + endSub + insert2;
        providerData.setController(frontSub + endSub);
        providerData.activeData = frontSub + endSub;
        providerData.controller.selection = makeLast;
      } else {
        String frontSub = providerData.activeData.substring(0, start);
        String midSub = providerData.activeData.substring(start, end);
        String endSub = providerData.activeData
            .substring(end, providerData.activeData.length);
        providerData.setController(
            frontSub + "\n" + insert1 + midSub + insert2 + "\n" + endSub);
        providerData.activeData =
            frontSub + "\n" + insert1 + midSub + insert2 + "\n" + endSub;
        providerData.controller.selection = makeLast;
      }
    }
  }
}
