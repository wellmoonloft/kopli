import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kopli/commonWidgets/appTheme.dart';
import 'package:kopli/commonWidgets/colorTheme.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String laberText;
  final int lengthLimit;
  final int maxLies;
  final onTap;

  const MyTextField(
      {Key key,
      this.controller,
      this.laberText,
      this.lengthLimit = -1,
      this.maxLies = 1,
      this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: new ThemeData(
            primaryColor: ColorTheme.appleBlue,
            hintColor: ColorTheme.greylighter),
        child: TextField(
          autofocus: true,
          controller: controller,
          maxLines: maxLies,
          style: AppTheme.pagefont,
          onTap: () {
            if (onTap != null) {
              onTap();
            }
          },
          inputFormatters: [LengthLimitingTextInputFormatter(lengthLimit)],
          decoration: InputDecoration(
              labelText: laberText,
              isDense: true,
              filled: true,
              contentPadding: EdgeInsets.all(12.0),
              fillColor: ColorTheme.leftBackColor,
              labelStyle: AppTheme.dateFont,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )),
        ));
  }
}
