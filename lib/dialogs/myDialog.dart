import 'package:flutter/material.dart';
import 'package:kopli/utils/appTheme.dart';
import 'package:kopli/utils/myBottom.dart';

class MyDialog extends StatelessWidget {
  final onPress;
  final String title;
  final String content;
  final bool isAlert;

  const MyDialog(
      {Key key, this.onPress, this.content, this.title, this.isAlert})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(content, style: AppTheme.titleFont),
      title: Center(child: Text(title, style: AppTheme.titleFont)),
      actionsPadding: EdgeInsets.only(bottom: 10, right: 8),
      actions: <Widget>[
        isAlert == null
            ? MyBottom(
                title: "取消",
                onPress: () {
                  Navigator.of(context).pop();
                },
              )
            : Container(),
        MyBottom(
          title: "确定",
          type: "confirm",
          onPress: () {
            onPress();
          },
        ),
      ],
    );
  }
}
