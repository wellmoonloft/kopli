import 'package:flutter/material.dart';
import 'package:kopli/utils/colorTheme.dart';

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
        height: 25,
        child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(backColor),
            ),
            onPressed: () {
              onPress();
            },
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    color: textColor,
                  )),
            )));
  }
}
