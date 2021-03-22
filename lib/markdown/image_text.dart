import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';

class ImageText extends SpecialText {
  ImageText(TextStyle textStyle,
      {this.start, SpecialTextGestureTapCallback onTap})
      : super(
          ImageText.flag,
          ')',
          textStyle,
          onTap: onTap,
        );

  static const String flag = '(';
  final int start;
  //String _imageUrl;
  //String get imageUrl => _imageUrl;
  @override
  InlineSpan finishText() {
    ///content already has endflag '/'
    final String text = getContent();

    final String url = text;
    //_imageUrl = url;

    const BoxFit fit = BoxFit.cover;

    return ExtendedWidgetSpan(
        start: start,
        actualText: text,
        child: GestureDetector(
            onTap: () {
              onTap?.call(url);
            },
            child: Image.network(
              url,
              fit: fit,
            )));
  }
}
