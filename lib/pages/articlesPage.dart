import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/pages/articlesBottom.dart';
import 'package:kopli/utils/appTheme.dart';
import 'package:kopli/utils/colorTheme.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:provider/provider.dart';

class ArticlesPage extends StatefulWidget {
  final loadArticle;
  final newArticle;
  final Article activeArticle;
  final bool isEdit;

  const ArticlesPage(
      {Key key,
      this.loadArticle,
      this.newArticle,
      this.activeArticle,
      this.isEdit})
      : super(key: key);
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  double isShow = 0.0;
  bool isList = false;
  Icon isListIcon = Icon(FontAwesomeIcons.listUl);
  String leftTitle = "文档";

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    void _mouseEnter(PointerEvent details) {
      setState(() {
        isShow = 1.0;
      });
    }

    void _mouseExit(PointerEvent details) {
      setState(() {
        isShow = 0.0;
      });
    }

    return MouseRegion(
        onEnter: _mouseEnter,
        onExit: _mouseExit,
        child: Container(
          width: 270,
          color: ColorTheme.leftBackColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Opacity(
                          opacity: isShow,
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
                                    leftTitle = "文档";
                                  });
                                } else {
                                  setState(() {
                                    isListIcon = Icon(FontAwesomeIcons.stream);
                                    isList = true;
                                    leftTitle = "大纲";
                                  });
                                }
                              },
                            ),
                          )),
                      Text(leftTitle, style: AppTheme.pagefont),
                      Opacity(
                        opacity: isShow,
                        child: IconButton(
                          icon: Icon(FontAwesomeIcons.search),
                          iconSize: 14,
                          color: ColorTheme.greylighter,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )),
              Consumer<ProviderData>(builder: (context, providerdata, child) {
                List<Article> tempList = providerdata.articleList;
                return Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  height: height - 60,
                  child: (tempList != null && tempList.length > 0)
                      ? ListView.separated(
                          itemCount: tempList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var article = tempList[index];
                            return Container(
                              color: widget.activeArticle.id == article.id
                                  ? ColorTheme.greytriplelighter
                                  : ColorTheme.leftBackColor,
                              padding: EdgeInsets.all(10),
                              child: InkWell(
                                  onTap: () {
                                    widget.loadArticle(article);
                                    setState(() {
                                      print("click index=$index");
                                    });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.title,
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        article.outline,
                                        textAlign: TextAlign.left,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: ColorTheme.greylighter),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        article.editDate,
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: ColorTheme.mainColor),
                                      ),
                                      // SizedBox(
                                      //   height: 10,
                                      // )
                                    ],
                                  )),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              color: ColorTheme.greydoublelighter,
                              height: 2,
                            );
                          },
                        )
                      : Text(""),
                );
              }),
              !isList
                  ? Opacity(
                      opacity: isShow,
                      child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: ColorTheme.greydoublelighter,
                                    width: 0.5)),
                          ),
                          child:
                              ArticlesBottom(newArticle: () => _newArticle())))
                  : Container()
            ],
          ),
        ));
  }

  _newArticle() {
    widget.newArticle();
  }
}
