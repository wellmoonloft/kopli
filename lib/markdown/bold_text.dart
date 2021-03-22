import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BoldText extends SpecialText {
  BoldText(TextStyle textStyle, SpecialTextGestureTapCallback onTap,
      {this.start})
      : super(flag, flag, textStyle, onTap: onTap);
  static const String flag = '\*\*';
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
        style: textStyle?.copyWith(fontWeight: FontWeight.w600),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            if (onTap != null) {
              onTap(toString());
            }
          });
  }
}

List<String> dollarList = <String>[
  '\$Dota2\$',
  '\$Dota2 Ti9\$',
  '\$CN dota best dota\$',
  '\$Flutter\$',
  '\$CN dev best dev\$',
  '\$UWP\$',
  '\$Nevermore\$',
  '\$FlutterCandies\$',
  '\$ExtendedImage\$',
  '\$ExtendedText\$',
];
