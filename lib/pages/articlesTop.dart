import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kopli/utils/appTheme.dart';
import 'package:kopli/utils/colorTheme.dart';

class ArticlesTop extends StatefulWidget {
  final double isShow;
  final isListAction;

  const ArticlesTop({Key key, this.isShow, this.isListAction})
      : super(key: key);
  @override
  _ArticlesTopState createState() => _ArticlesTopState();
}

class _ArticlesTopState extends State<ArticlesTop> {
  double articlesFrameHeight = 85;
  bool isList = false;
  String title = "文档";
  Icon isListIcon = Icon(FontAwesomeIcons.listUl);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Opacity(
                opacity: widget.isShow,
                child: Tooltip(
                  message: isList ? "切换到文档视图" : "切换到大纲视图",
                  child: IconButton(
                    icon: isListIcon,
                    iconSize: 14,
                    color: ColorTheme.greylighter,
                    onPressed: () {
                      if (isList) {
                        setState(() {
                          isListIcon = Icon(FontAwesomeIcons.listUl);
                          isList = false;
                          title = "文档";
                        });
                      } else {
                        setState(() {
                          isListIcon = Icon(FontAwesomeIcons.stream);
                          isList = true;
                          title = "大纲";
                        });
                      }
                      widget.isListAction(isList);
                    },
                  ),
                )),
            Text(title, style: AppTheme.titleFont),
            Opacity(
              opacity: widget.isShow,
              child: Tooltip(
                  message: "搜索文章",
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.search),
                    iconSize: 14,
                    color: ColorTheme.greylighter,
                    onPressed: () {},
                  )),
            ),
          ],
        ));
  }
}
