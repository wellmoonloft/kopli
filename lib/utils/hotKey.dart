import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kopli/pages/saveArticles.dart';
import 'package:kopli/utils/fileActions.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:kopli/utils/textUndo.dart';
import 'package:provider/provider.dart';

class HotKey {
  void setHotKey(
      BuildContext context, RawKeyEvent event, TextChangeStack _stack) {
    var providerData = Provider.of<ProviderData>(context, listen: false);
    FileActions _fileActions = FileActions();

    //save
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.keyS)) {
      if (providerData.activeArticle.id != null) {
        _fileActions.saveArticle(context, providerData.activeArticle);
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Consumer<ProviderData>(
                  builder: (context, providerdata, child) {
                return SaveArticles(
                    saveArticle: (_article) =>
                        _fileActions.saveArticle(context, _article));
              });
            });
      }
    }
    //Level 1 heading
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.digit1)) {
      _fileActions.replaceContent(context, "# ", "");
    }
    //Level 2 heading
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.digit2)) {
      _fileActions.replaceContent(context, "## ", "");
    }
    //Level 3 heading
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.digit3)) {
      _fileActions.replaceContent(context, "### ", "");
    }
    //Level 4 heading
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.digit4)) {
      _fileActions.replaceContent(context, "#### ", "");
    }
    //Level 5 heading
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.digit5)) {
      _fileActions.replaceContent(context, "##### ", "");
    }
    //Bold
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.keyB)) {
      _fileActions.replaceContent(context, "**", "**");
    }
    //Italic
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.keyI)) {
      _fileActions.replaceContent(context, "*", "*");
    }
    //undo
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.keyZ)) {
      print("object");
      var undo = _stack.undo();
      if (undo != null) {
        providerData.setActveData(undo);
        providerData.setController(undo);
      }
    }
    //redo
    if (event.isMetaPressed &&
        event.isShiftPressed &&
        event.isKeyPressed(LogicalKeyboardKey.keyZ)) {
      print("object");
      var redo = _stack.redo();
      if (redo != null) {
        providerData.setActveData(redo);
        providerData.setController(redo);
      }
    }
  }
}
