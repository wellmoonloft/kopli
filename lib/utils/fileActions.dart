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
      TextSelection makeLast = TextSelection.fromPosition(
          TextPosition(affinity: TextAffinity.downstream, offset: 0));
      var providerData = Provider.of<ProviderData>(context, listen: false);
      providerData.setDir(directory.path);
      providerData.setActiveArticle(Article());
      providerData.setActveData("");
      providerData.setIsEdit(false);
      providerData.setController("", makeLast);

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
      _showNewDialog(context);
    } else {
      initFiles(context);
    }
  }

  loadArticle(BuildContext context, Article _article) async {
    var providerData = Provider.of<ProviderData>(context, listen: false);
    if (providerData.isEdit) {
      _showLoadDialog(context, _article);
    } else {
      File file = new File(p.join(_article.filePath, _article.fileName));
      var providerData = Provider.of<ProviderData>(context, listen: false);
      providerData.setDir(_article.filePath);
      providerData.setActiveArticle(_article);
      await file.readAsString().then((value) {
        TextSelection makeLast = TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: value.length));
        providerData.setActveData(value);
        providerData.setIsEdit(false);
        providerData.setController(value, makeLast);
      });
    }
  }

  _showLoadDialog(BuildContext context, Article _article) {
    return showDialog(
      context: context,
      builder: (context) {
        return MyDialog(
          title: "请注意",
          content: "当前有尚未保存的内容，是否确定放弃？",
          onPress: () async {
            File file = new File(p.join(_article.filePath, _article.fileName));
            var providerData =
                Provider.of<ProviderData>(context, listen: false);
            providerData.setDir(_article.filePath);
            providerData.setActiveArticle(_article);
            await file.readAsString().then((value) {
              TextSelection makeLast = TextSelection.fromPosition(TextPosition(
                  affinity: TextAffinity.downstream, offset: value.length));
              providerData.setActveData(value);
              providerData.setIsEdit(false);
              providerData.setController(value, makeLast);
            });

            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  _showNewDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return MyDialog(
          title: "请注意",
          content: "当前有尚未保存的内容，是否确定放弃？",
          onPress: () async {
            initFiles(context);

            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
