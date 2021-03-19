import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kopli/commonWidgets/colorTheme.dart';

class Heading1Text extends SpecialText {
  Heading1Text(TextStyle textStyle, SpecialTextGestureTapCallback onTap,
      {this.start})
      : super(flag, ' ', textStyle, onTap: onTap);
  static const String flag = '#';
  final int start;
  @override
  InlineSpan finishText() {
    final String text = getContent();

    return SpecialTextSpan(
        text: text,
        actualText: toString(),
        start: start,

        ///caret can move into special text
        deleteAll: true,
        style: textStyle?.copyWith(
            color: ColorTheme.mainBlack,
            fontSize: 20,
            fontWeight: FontWeight.w800),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            if (onTap != null) {
              onTap(toString());
            }
          });
  }
}

class Heading2Text extends SpecialText {
  Heading2Text(TextStyle textStyle, SpecialTextGestureTapCallback onTap,
      {this.start})
      : super(flag, ' ', textStyle, onTap: onTap);
  static const String flag = '\##';
  final int start;
  @override
  InlineSpan finishText() {
    final String text = getContent();

    return SpecialTextSpan(
        text: text,
        actualText: toString(),
        start: start,

        ///caret can move into special text
        deleteAll: true,
        style: textStyle?.copyWith(
            color: ColorTheme.mainBlack,
            fontSize: 20,
            fontWeight: FontWeight.w800),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            if (onTap != null) {
              onTap(toString());
            }
          });
  }
}
