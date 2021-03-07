import 'dart:io';
import 'package:intl/intl.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/utils/appTheme.dart';
import 'package:kopli/utils/colorTheme.dart';
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
  TextEditingController _filecontroller = new TextEditingController();
  String dir = "";
  bool isEdit = false;
  Article activeArticle = Article();
  String title = "Kopli";

  @override
  void initState() {
    super.initState();

    _getDocumentPath();
    _controller.addListener(() {
      if (stringData != _controller.text) {
        setState(() {
          title = _filecontroller.text;
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
        _filecontroller.text = "未命名.md";
        _controller.text = "";
        stringData = "";
        isEdit = false;
      });
    });

    var providerData = Provider.of<ProviderData>(context, listen: false);
    providerData.getArticle();
  }

  _saveArticle() async {
    DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm:ss");
    if (activeArticle.id == null) {
      activeArticle.createDate = formatter.format(DateTime.now());
      activeArticle.editDate = formatter.format(DateTime.now());
      activeArticle.fileName = _filecontroller.text;
      activeArticle.filePath = dir;
      activeArticle.outline = stringData.substring(0, stringData.length);
      activeArticle.sort = "";
      activeArticle.title = _filecontroller.text;

      await DBHelper().updateArticle(activeArticle).then((value) {
        activeArticle.id = value;
        File file = new File(p.join(dir, activeArticle.fileName));
        file.writeAsString(stringData).whenComplete(() =>
            {print("保存成功" + p.join(dir, activeArticle.fileName).toString())});
      });

      var providerData = Provider.of<ProviderData>(context, listen: false);
      providerData.getArticle();
    } else {
      activeArticle.editDate = formatter.format(DateTime.now());
      activeArticle.outline = stringData.substring(0, stringData.length);

      DBHelper().updateArticle(activeArticle).then((value) {
        File file = new File(p.join(dir, activeArticle.fileName));
        file.writeAsString(stringData).whenComplete(() =>
            {print("保存成功" + p.join(dir, activeArticle.fileName).toString())});
      });
    }
    setState(() {
      isEdit = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    showSavingDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: Container(
                  width: 500,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 200,
                          child: TextField(
                            autofocus: true,
                            controller: _filecontroller,
                            decoration: InputDecoration(
                              labelText: '保存为',
                              filled: true,
                              fillColor: ColorTheme.leftBackColor,
                              labelStyle: TextStyle(
                                color: ColorTheme.mainColor,
                                fontSize: 12,
                              ),
                              border: InputBorder.none,
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  ColorTheme.greydoublelighter),
                            ),
                            onPressed: () {},
                            child: Text("新建标签", style: AppTheme.pagefont),
                          ),
                          Row(
                            children: [
                              TextButton(
                                child: Text('取消', style: AppTheme.pagefont),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          ColorTheme.greydoublelighter),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          ColorTheme.appleBlue),
                                ),
                                onPressed: () {
                                  _saveArticle();
                                  Navigator.of(context).pop();
                                },
                                child:
                                    Text("保存", style: AppTheme.pagefontwhite),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  )));
        },
      );
    }

    return Scaffold(
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
                    _saveArticle();
                  } else {
                    showSavingDialog();
                  }
                }
              }
            },
            autofocus: true,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
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
                    isEdit: isEdit),
                PreviewPage(data: stringData)
              ],
            )));
  }

  _loadArticle(Article _article) async {
    if (isEdit) {
      showDeleteConfirmDialog1("load", _article);
    } else {
      File file = new File(p.join(_article.filePath, _article.fileName));
      await file.readAsString().then((value) {
        setState(() {
          activeArticle = _article;
          dir = _article.filePath;
          title = _article.fileName;
          _controller.text = value;
          stringData = value;
          _filecontroller.text = _article.fileName;
          isEdit = false;
        });
      });
    }
  }

  _newArticle() {
    if (isEdit) {
      showDeleteConfirmDialog1("new", null);
    } else {
      print("新建文章");
      _getDocumentPath();
    }
  }

  // 弹出对话框
  Future<bool> showDeleteConfirmDialog1(String isNewLoad, Article _article) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("当前有尚未保存的内容，是否确定放弃?",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: ColorTheme.mainColor,
              )),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("取消",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: ColorTheme.mainColor,
                  )),
            ),
            TextButton(
              onPressed: () async {
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
                      _filecontroller.text = _article.fileName;
                      isEdit = false;
                    });
                  });
                }

                Navigator.of(context).pop();
              },
              child: Text("确定",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: ColorTheme.darkred,
                  )),
            ),
          ],
        );
      },
    );
  }
}
