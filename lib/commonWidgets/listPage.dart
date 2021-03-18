import 'package:flutter/material.dart';
import 'package:kopli/commonWidgets/appTheme.dart';

class ListPage extends StatelessWidget {
  final bool isList;

  const ListPage({Key key, this.isList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: isList
          ? Text(
              "大纲内容为空",
              style: AppTheme.pagefont,
            )
          : Text(
              "文档列表为空",
              style: AppTheme.pagefont,
            ),
    );
  }
}
