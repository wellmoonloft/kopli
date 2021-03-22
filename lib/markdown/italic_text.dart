import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ItalicText extends SpecialText {
  ItalicText(TextStyle textStyle, SpecialTextGestureTapCallback onTap,
      {this.start})
      : super(flag, flag, textStyle, onTap: onTap);
  static const String flag = '\*';
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
        style: textStyle?.copyWith(fontStyle: FontStyle.italic),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            if (onTap != null) {
              onTap(toString());
            }
          });
  }
}
