import 'package:flutter/material.dart';
import 'package:kopli/commonWidgets/colorTheme.dart';
import 'package:kopli/utils/getPlatform.dart';

class MyBottom extends StatelessWidget {
  final onPress;
  final String title;
  final String type;

  const MyBottom({Key key, this.onPress, this.title, this.type})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color textColor = ColorTheme.mainColor;
    Color backColor = ColorTheme.greydoublelighter;
    if (type == "confirm") {
      textColor = ColorTheme.white;
      backColor = ColorTheme.appleBlue;
    }
    return Container(
        height: GetPlatform().getIsMobile() ? 25 : 34,
        child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(backColor),
            ),
            onPressed: () {
              onPress();
            },
            child: Container(
              padding: EdgeInsets.only(
                  left: GetPlatform().getIsMobile() ? 20 : 10,
                  right: GetPlatform().getIsMobile() ? 20 : 10),
              child: Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    color: textColor,
                  )),
            )));
  }
}
