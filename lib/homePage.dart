import 'dart:io';
import 'package:intl/intl.dart';
import 'package:kopli/commonWidgets/myDialog.dart';
import 'package:kopli/commonWidgets/saveArticles.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/utils/dbHelper.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kopli/pages/editorPage.dart';
import 'package:kopli/pages/previewPage.dart';
import 'package:kopli/pages/articlesPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String stringData = "";
  TextEditingController _controller = new TextEditingController();
  String dir = "";
  bool isEdit = false;
  Article activeArticle = Article();
  String title = "Kopli";
  String itemValue = "default";
  double offset = 0.0;

  @override
  void initState() {
    super.initState();

    _getDocumentPath();
    var providerData = Provider.of<ProviderData>(context, listen: false);
    providerData.getArticle();
    providerData.getSorts();
    _controller.addListener(() {
      if (stringData != _controller.text) {
        setState(() {
          stringData = _controller.text;
          isEdit = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _getDocumentPath() async {
    await getApplicationDocumentsDirectory().then((value) {
      Directory directory = new Directory('${value.path}/articles');
      if (!directory.existsSync()) {
        directory.createSync();
        print('文档初始化成功，文件保存路径为 ${directory.path}');
      }

      setState(() {
        activeArticle = Article();
        dir = directory.path;
        title = "未命名";
        _controller.text = "";
        stringData = "";
        isEdit = false;
      });
    });
  }

  _saveArticle(Article _article) async {
    setState(() {
      activeArticle = _article;
    });

    DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm:ss");
    activeArticle.editDate = formatter.format(DateTime.now());

    DBHelper().updateArticle(activeArticle).then((value) {
      File file = new File(p.join(dir, activeArticle.fileName));
      file.writeAsString(stringData).whenComplete(() =>
          {print("保存成功" + p.join(dir, activeArticle.fileName).toString())});
      setState(() {
        isEdit = false;
      });
    });
  }

  _loadArticle(Article _article) async {
    if (isEdit) {
      _showNewAndLoadDialog("load", _article);
    } else {
      File file = new File(p.join(_article.filePath, _article.fileName));
      await file.readAsString().then((value) {
        setState(() {
          activeArticle = _article;
          dir = _article.filePath;
          title = _article.fileName;
          _controller.text = value;
          stringData = value;
          isEdit = false;
        });
      });
    }
  }

  _newArticle() {
    if (isEdit) {
      _showNewAndLoadDialog("new", null);
    } else {
      _getDocumentPath();
    }
  }

  _showNewAndLoadDialog(String isNewLoad, Article _article) {
    return showDialog(
      context: context,
      builder: (context) {
        return MyDialog(
          title: "请注意",
          content: "当前有尚未保存的内容，是否确定放弃？",
          onPress: () async {
            if (isNewLoad == "new") {
              _getDocumentPath();
            }
            if (isNewLoad == "load") {
              File file =
                  new File(p.join(_article.filePath, _article.fileName));
              await file.readAsString().then((value) {
                setState(() {
                  activeArticle = _article;
                  dir = _article.filePath;
                  title = _article.fileName;
                  _controller.text = value;
                  stringData = value;
                  isEdit = false;
                });
              });
            }
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        //弹出键盘不错位
        resizeToAvoidBottomInset: true,
        appBar: (width / height > 1)
            ? null
            : AppBar(
                title: Text(title),
              ),
        body: RawKeyboardListener(
            focusNode: FocusNode(),
            onKey: (RawKeyEvent event) async {
              if (event.isKeyPressed(LogicalKeyboardKey.metaLeft) ||
                  event.isKeyPressed(LogicalKeyboardKey.metaRight)) {
                if (event.isKeyPressed(LogicalKeyboardKey.keyS)) {
                  if (activeArticle.id != null) {
                    _saveArticle(activeArticle);
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SaveArticles(
                              dir: dir,
                              stringData: stringData,
                              saveArticle: (_article) =>
                                  _saveArticle(_article));
                        });
                  }
                }
              }
            },
            autofocus: true,
            child: Row(
              children: <Widget>[
                (width / height > 1)
                    ? ArticlesPage(
                        isEdit: isEdit,
                        activeArticle: activeArticle,
                        newArticle: () => _newArticle(),
                        loadArticle: (_article) => _loadArticle(_article))
                    : Container(),
                EditorPage(
                  activeArticle: activeArticle,
                  controller: _controller,
                  isEdit: isEdit,
                  scrollOffset: (_offset) => _scrollOffset(_offset),
                ),
                PreviewPage(
                  data: stringData,
                  offset: offset,
                )
              ],
            )));
  }

  _scrollOffset(double _offset) {
    setState(() {
      offset = _offset;
    });
  }
}
