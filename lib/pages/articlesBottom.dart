import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kopli/utils/appTheme.dart';
import 'package:kopli/utils/colorTheme.dart';

class ArticlesBottom extends StatelessWidget {
  final newArticle;

  const ArticlesBottom({Key key, this.newArticle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            FontAwesomeIcons.plus,
            color: ColorTheme.greylighter,
          ),
          iconSize: 12,
          onPressed: () {
            newArticle();
          },
        ),
        Container(
          width: 190,
          child: TextButton(
              onPressed: () {},
              child: Text("打开文件夹...", style: AppTheme.pagefont)),
        ),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.ellipsisV,
            color: ColorTheme.greylighter,
          ),
          iconSize: 12,
          onPressed: () {},
        ),
      ],
    );
  }
}
