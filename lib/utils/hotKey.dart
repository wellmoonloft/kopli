import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HotKey {
  save(RawKeyEvent event) {
    int back = -1;
    //保存
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.keyS)) {
      back = 0;
    }
    //一级标题
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.digit1)) {
      back = 1;
      print(back);
    }
    //二级标题
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.digit2)) {
      back = 2;
      print(back);
    }
    //三级标题
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.digit3)) {
      back = 3;
      print(back);
    }
    //四级标题
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.digit4)) {
      back = 4;
      print(back);
    }
    //五级标题
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.digit5)) {
      back = 5;
      print(back);
    }
    //撤回
    if (event.isMetaPressed && event.isKeyPressed(LogicalKeyboardKey.keyZ)) {
      back = 6;
      print(back);
    }
    //回滚
    if (event.isMetaPressed &&
        event.isShiftPressed &&
        event.isKeyPressed(LogicalKeyboardKey.keyZ)) {
      back = 7;
      print(back);
    }
    return back;
  }
}
