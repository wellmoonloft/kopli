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
              return SaveArticles(
                  saveArticle: (_article) =>
                      _fileActions.saveArticle(context, _article));
            });
      }
    }
    //Level 1 heading
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.digit1)) {
      _replaceContent(context, "# ", "");
    }
    //Level 2 heading
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.digit2)) {
      _replaceContent(context, "## ", "");
    }
    //Level 3 heading
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.digit3)) {
      _replaceContent(context, "### ", "");
    }
    //Level 4 heading
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.digit4)) {
      _replaceContent(context, "#### ", "");
    }
    //Level 5 heading
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.digit5)) {
      _replaceContent(context, "##### ", "");
    }
    //Bold
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.keyB)) {
      _replaceContent(context, "**", "**");
    }
    //Italic
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.keyI)) {
      _replaceContent(context, "*", "*");
    }
    //Quote
    if (event.isControlPressed && event.isKeyPressed(LogicalKeyboardKey.keyQ)) {
      _replaceContent(context, ">", "");
    }
    //Code
    if (event.isControlPressed && event.isKeyPressed(LogicalKeyboardKey.keyC)) {
      _replaceContent(context, "`", "`");
    }
    //Code Block
    if (event.isControlPressed && event.isKeyPressed(LogicalKeyboardKey.keyB)) {
      _replaceContent(context, "```", "```");
    }
    //Link
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.keyL)) {
      Clipboard.getData(Clipboard.kTextPlain).then((value) {
        _replaceContent(context, "[", "](" + value.text + ")");
      });
    }
    //Graph
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.keyG)) {
      Clipboard.getData(Clipboard.kTextPlain).then((value) {
        _replaceContent(context, "![", "](" + value.text + ")");
      });
    }
    //undo
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.keyZ)) {
      print("object");

      var undo = _stack.undo();
      if (undo != null) {
        TextSelection makeLast = TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: undo.length));
        providerData.setActveData(undo);
        providerData.setController(undo, makeLast);
      }
    }
    //redo
    if (event.isMetaPressed &&
        event.isShiftPressed &&
        event.isKeyPressed(LogicalKeyboardKey.keyZ)) {
      print("object");
      var redo = _stack.redo();
      if (redo != null) {
        TextSelection makeLast = TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: redo.length));
        providerData.setActveData(redo);
        providerData.setController(redo, makeLast);
      }
    }
  }

  mobileShortcut(BuildContext context, String action) {
    var providerData = Provider.of<ProviderData>(context, listen: false);
    FileActions _fileActions = FileActions();

    switch (action) {
      case "h1":
        {
          _replaceContent(context, "# ", "");
        }
        break;
      case "h2":
        {
          _replaceContent(context, "## ", "");
        }
        break;
      case "h3":
        {
          _replaceContent(context, "### ", "");
        }
        break;
      case "l":
        {
          Clipboard.getData(Clipboard.kTextPlain).then((value) {
            _replaceContent(context, "[", "](" + value.text + ")");
          });
        }
        break;
      case "b":
        {
          _replaceContent(context, "**", "**");
        }
        break;
      case "i":
        {
          _replaceContent(context, "*", "*");
        }
        break;
      case "c":
        {
          _replaceContent(context, "`", "`");
        }
        break;
      case "q":
        {
          _replaceContent(context, ">", "");
        }
        break;
      default:
        {
          if (providerData.activeArticle.id != null) {
            _fileActions.saveArticle(context, providerData.activeArticle);
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SaveArticles(
                      saveArticle: (_article) =>
                          _fileActions.saveArticle(context, _article));
                });
          } //statements;
        }
        break;
    }
  }

  _replaceContent(BuildContext context, String insert1, String insert2) {
    var providerData = Provider.of<ProviderData>(context, listen: false);
    int end = providerData.controller.selection.baseOffset;
    int start = providerData.controller.selection.extentOffset;
    int offset;
    if (insert2 == "") {
      offset = end + insert1.length + insert2.length + 1;
    } else {
      offset = end + insert1.length + 1;
    }

    TextSelection makeLast = TextSelection.fromPosition(
        TextPosition(affinity: TextAffinity.downstream, offset: offset));
    if (start == end) {
      if (end == providerData.activeData.length) {
        providerData.setController(
            providerData.activeData + "\n" + insert1 + insert2, makeLast);
        providerData.activeData =
            providerData.activeData + "\n" + insert1 + insert2;
      } else {
        String frontSub = providerData.activeData.substring(0, end);
        String endSub = providerData.activeData
            .substring(end, providerData.activeData.length);
        providerData.setController(
            frontSub + "\n" + insert1 + insert2 + "\n" + endSub, makeLast);
        providerData.activeData =
            frontSub + "\n" + insert1 + insert2 + "\n" + endSub;
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
        providerData.setController(frontSub + endSub, makeLast);
        providerData.activeData = frontSub + endSub;
      } else {
        String frontSub = providerData.activeData.substring(0, start);
        String midSub = providerData.activeData.substring(start, end);
        String endSub = providerData.activeData
            .substring(end, providerData.activeData.length);
        providerData.setController(
            frontSub + "\n" + insert1 + midSub + insert2 + "\n" + endSub,
            makeLast);
        providerData.activeData =
            frontSub + "\n" + insert1 + midSub + insert2 + "\n" + endSub;
      }
    }
  }
}
