import 'package:flutter/material.dart';

class LeftFrame extends StatelessWidget {
  final bool isList;

  const LeftFrame({Key key, this.isList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: isList ? Text("大纲内容为空") : Text("文档列表为空"),
    );
  }
}
