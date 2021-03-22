import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kopli/markdown/bold_text.dart';
import 'package:kopli/markdown/heading.dart';
import 'package:kopli/markdown/image_text.dart';
import 'package:kopli/markdown/italic_text.dart';

import 'at_text.dart';
import 'dollar_text.dart';
import 'emoji_text.dart';

class MySpecialTextSpanBuilder extends SpecialTextSpanBuilder {
  MySpecialTextSpanBuilder({this.showAtBackground = false});

  /// whether show background for @somebody
  final bool showAtBackground;
  @override
  TextSpan build(String data,
      {TextStyle textStyle, SpecialTextGestureTapCallback onTap}) {
    if (kIsWeb) {
      return TextSpan(text: data, style: textStyle);
    }

    return super.build(data, textStyle: textStyle, onTap: onTap);
  }

  @override
  SpecialText createSpecialText(String flag,
      {TextStyle textStyle, SpecialTextGestureTapCallback onTap, int index}) {
    if (flag == null || flag == '') {
      return null;
    }

    ///index is end index of start flag, so text start index should be index-(flag.length-1)
    if (isStart(flag, EmojiText.flag)) {
      return EmojiText(textStyle, start: index - (EmojiText.flag.length - 1));
    } else if (isStart(flag, ImageText.flag)) {
      return ImageText(textStyle,
          start: index - (ImageText.flag.length - 1), onTap: onTap);
    } else if (isStart(flag, AtText.flag)) {
      return AtText(
        textStyle,
        onTap,
        start: index - (AtText.flag.length - 1),
        showAtBackground: showAtBackground,
      );
    } else if (isStart(flag, EmojiText.flag)) {
      return EmojiText(textStyle, start: index - (EmojiText.flag.length - 1));
    } else if (isStart(flag, DollarText.flag)) {
      return DollarText(textStyle, onTap,
          start: index - (DollarText.flag.length - 1));
    } else if (isStart(flag, BoldText.flag)) {
      return BoldText(textStyle, onTap,
          start: index - (BoldText.flag.length - 1));
    } else if (isStart(flag, ItalicText.flag)) {
      return ItalicText(textStyle, onTap,
          start: index - (ItalicText.flag.length - 1));
    } else if (isStart(flag, Heading5Text.flag)) {
      return Heading5Text(textStyle, onTap,
          start: index - (Heading5Text.flag.length - 1));
    } else if (isStart(flag, Heading4Text.flag)) {
      return Heading4Text(textStyle, onTap,
          start: index - (Heading4Text.flag.length - 1));
    } else if (isStart(flag, Heading3Text.flag)) {
      return Heading3Text(textStyle, onTap,
          start: index - (Heading3Text.flag.length - 1));
    } else if (isStart(flag, Heading2Text.flag)) {
      return Heading2Text(textStyle, onTap,
          start: index - (Heading2Text.flag.length - 1));
    } else if (isStart(flag, Heading1Text.flag)) {
      return Heading1Text(textStyle, onTap,
          start: index - (Heading1Text.flag.length - 1));
    }
    return null;
  }
}
