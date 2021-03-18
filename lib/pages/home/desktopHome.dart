import 'package:flutter/material.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/pages/articles/articlesPage.dart';
import 'package:kopli/pages/editor/editorPage.dart';
import 'package:kopli/pages/preview/previewPage.dart';
import 'package:kopli/utils/fileActions.dart';
import 'package:kopli/utils/hotKey.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:kopli/utils/textUndo.dart';
import 'package:provider/provider.dart';

class DesktopHome extends StatefulWidget {
  @override
  _DesktopHomeState createState() => _DesktopHomeState();
}

class _DesktopHomeState extends State<DesktopHome> {
  double offset = 0.0;
  FileActions _fileActions = FileActions();
  final _stack = TextChangeStack(maxSize: 20, init: "");

  @override
  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Ensure that the pop-up keyboard UI is good
        resizeToAvoidBottomInset: true,
        body: RawKeyboardListener(
            focusNode: FocusNode(),
            autofocus: true,
            onKey: (RawKeyEvent event) async {
              HotKey().setHotKey(context, event, _stack);
            },
            child: Row(
              children: <Widget>[
                ArticlesPage(
                    newArticle: () => _newArticle(),
                    loadArticle: (_article) => _loadArticle(_article)),
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

  _loadArticle(Article _article) {
    _fileActions.loadArticle(context, _article);
  }

  _newArticle() {
    _fileActions.newArticle(context);
  }
}
