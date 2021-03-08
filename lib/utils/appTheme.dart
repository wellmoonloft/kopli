import 'package:flutter/material.dart';
import 'package:kopli/utils/colorTheme.dart';

class AppTheme {
  AppTheme._();
  static const double maxNumber = 1000000.00;
  static const outboxpadding =
      EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 30);
  static const inboxpadding = EdgeInsets.all(16);

  static const mainNumbers = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 30,
    color: ColorTheme.mainBlack,
  );

  static const titleFont = TextStyle(
    //fontWeight: FontWeight.w300,
    fontSize: 13,
    color: ColorTheme.mainColor,
  );

  static const subTitleFont = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 13,
    color: ColorTheme.greydoubledarker,
  );

  static const contentFont = TextStyle(
    fontWeight: FontWeight.w200,
    fontSize: 13,
    color: ColorTheme.mainColor,
  );

  static const dateFont = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 12,
    color: ColorTheme.greylighter,
  );

  static const pagefont = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 12,
    color: ColorTheme.mainColor,
  );

  static const bottomfont = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 12,
    color: ColorTheme.mainColor,
  );

  static const borderbottomfont = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 12,
    color: ColorTheme.appleBlue,
  );

  static const bottomfontwhite = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 12,
    color: ColorTheme.white,
  );

  static const normalBorderRadius = BorderRadius.all(Radius.circular(8.0));
  static const smallBorderRadius = BorderRadius.all(Radius.circular(6.0));
  static const normalBoxShadow = BoxShadow(
      color: ColorTheme.grey, offset: Offset(1.1, 1.1), blurRadius: 5.0);
  static const boxDecoration = BoxDecoration(
    color: ColorTheme.white,
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    boxShadow: <BoxShadow>[
      BoxShadow(
          color: ColorTheme.greydoublelighter,
          offset: Offset(1.1, 1.1),
          blurRadius: 8.0),
    ],
  );
  static const boxDecorationBottle = BoxDecoration(
    color: ColorTheme.bgColor,
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    boxShadow: <BoxShadow>[
      BoxShadow(
          color: ColorTheme.greydoublelighter,
          offset: Offset(1.1, 1.1),
          blurRadius: 8.0),
    ],
  );
  static const boxDecorationBlack = BoxDecoration(
    color: ColorTheme.mainBlack,
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    boxShadow: <BoxShadow>[
      BoxShadow(
          color: ColorTheme.greydoublelighter,
          offset: Offset(1.1, 1.1),
          blurRadius: 8.0),
    ],
  );
}
