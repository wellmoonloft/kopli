import 'package:kopli/model/dataModels.dart';
import 'package:kopli/utils/fileActions.dart';
import 'package:kopli/utils/hotKey.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kopli/pages/editorPage.dart';
import 'package:kopli/pages/previewPage.dart';
import 'package:kopli/pages/articlesPage.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:kopli/utils/textUndo.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double offset = 0.0;
  FileActions _fileActions = FileActions();
  final _stack = TextChangeStack(maxSize: 20, init: "");

  @override
  void initState() {
    super.initState();

    _fileActions.initFiles(context);
    var providerData = Provider.of<ProviderData>(context, listen: false);
    providerData.controller.addListener(() {
      if (providerData.activeData != providerData.controller.text) {
        providerData.setActveData(providerData.controller.text);
        providerData.setIsEdit(true);
        _stack.add(providerData.controller.text);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loadArticle(Article _article) {
    _fileActions.loadArticle(context, _article);
  }

  _newArticle() {
    _fileActions.newArticle(context);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        //Ensure that the pop-up keyboard UI is good
        resizeToAvoidBottomInset: true,
        appBar: (width / height > 1)
            ? null
            : AppBar(
                title: Text("Kopli"),
              ),
        body: RawKeyboardListener(
            focusNode: FocusNode(),
            autofocus: true,
            onKey: (RawKeyEvent event) async {
              HotKey hotKey = HotKey();
              hotKey.setHotKey(context, event, _stack);
            },
            child: Row(
              children: <Widget>[
                (width / height > 1)
                    ? ArticlesPage(
                        newArticle: () => _newArticle(),
                        loadArticle: (_article) => _loadArticle(_article))
                    : Container(),
                EditorPage(
                  scrollOffset: (_offset) => _scrollOffset(_offset),
                ),
                PreviewPage(
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
