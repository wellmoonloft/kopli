import 'dart:io';
import 'package:intl/intl.dart';
import 'package:kopli/commonWidgets/myDialog.dart';
import 'package:kopli/commonWidgets/saveArticles.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/utils/dbHelper.dart';
import 'package:kopli/utils/hotKey.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:kopli/utils/textUndo.dart';
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

  final _stack = TextChangeStack(maxSize: 20, init: "");

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
        _stack.add(_controller.text);
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
            autofocus: true,
            onKey: (RawKeyEvent event) async {
              HotKey hotKey = HotKey();
              int mark = hotKey.save(event);

              if (mark == 0) {
                if (activeArticle.id != null) {
                  _saveArticle(activeArticle);
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SaveArticles(
                            dir: dir,
                            stringData: stringData,
                            saveArticle: (_article) => _saveArticle(_article));
                      });
                }
              }
              if (mark == 1) {
                insertContent(stringData, "# ");
              }
              if (mark == 2) {
                insertContent(stringData, "## ");
              }
              if (mark == 3) {
                insertContent(stringData, "### ");
              }
              if (mark == 4) {
                insertContent(stringData, "#### ");
              }
              if (mark == 5) {
                insertContent(stringData, "#### ");
              }
              if (mark == 6) {
                var undo = _stack.undo();
                if (undo != null) {
                  setState(() {
                    stringData = undo;
                    _controller.text = undo;
                  });
                }
              }
              if (mark == 7) {
                var redo = _stack.redo();
                if (redo != null) {
                  setState(() {
                    stringData = redo;
                    _controller.text = redo;
                  });
                }
              }
            },
            child: Row(
              children: <Widget>[
                (width / height > 1)
                    ? ArticlesPage(
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

  insertContent(String stringData, String insert) {
    int end = _controller.selection.baseOffset;
    int start = _controller.selection.extentOffset;
    TextSelection makeLast = TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream, offset: end + insert.length + 1));
    if (start == end) {
      if (end == stringData.length) {
        setState(() {
          _controller.text = stringData + "\n" + insert;
          stringData = stringData + "\n" + insert;
          _controller.selection = makeLast;
        });
      } else {
        String frontSub = stringData.substring(0, end);
        String endSub = stringData.substring(end, stringData.length);
        setState(() {
          stringData = frontSub + "\n" + insert + endSub;
          _controller.text = frontSub + "\n" + insert + endSub;
          _controller.selection = makeLast;
        });
      }
    } else {
      if (start > end) {
        int temp = start;
        start = end;
        end = temp;
      }
      if (end == stringData.length) {
        String frontSub = stringData.substring(0, start);
        String endSub = stringData.substring(start, stringData.length);
        endSub = "\n" + insert + endSub;

        setState(() {
          _controller.text = frontSub + endSub;
          stringData = frontSub + endSub;
          _controller.selection = makeLast;
        });
      } else {
        String frontSub = stringData.substring(0, start);
        String midSub = stringData.substring(start, end);
        String endSub = stringData.substring(end, stringData.length);
        setState(() {
          _controller.text = frontSub + "\n" + insert + midSub + "\n" + endSub;
          stringData = frontSub + "\n" + insert + midSub + "\n" + endSub;
          _controller.selection = makeLast;
        });
      }
    }
  }
}
