import 'package:kopli/utils/fileActions.dart';
import 'package:flutter/material.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/pages/articles/articlesBottom.dart';
import 'package:kopli/pages/articles/articlesTop.dart';
import 'package:kopli/pages/saveArticles.dart';
import 'package:kopli/commonWidgets/appTheme.dart';
import 'package:kopli/commonWidgets/colorTheme.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:provider/provider.dart';

class ArticlesPage extends StatefulWidget {
  final loadArticle;
  final newArticle;
  final RawKeyEvent event;

  const ArticlesPage({Key key, this.loadArticle, this.newArticle, this.event})
      : super(key: key);
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  double isShow = 0.0;
  bool isList = false;
  String sortsCode = "default";
  double articlesFrameHeight = 85;
  FileActions _fileActions = FileActions();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
          padding: EdgeInsets.only(top: 25),
          width: 270,
          color: ColorTheme.leftBackColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ArticlesTop(
                isShow: isShow,
                isListAction: (_isList) => _isListAction(_isList),
              ),
              Consumer<ProviderData>(builder: (context, providerdata, child) {
                List<Article> tempList = providerdata.articleList;
                return Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  height: height - articlesFrameHeight,
                  child: (tempList != null && tempList.length > 0)
                      ? ListView.builder(
                          itemCount: tempList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var article = tempList[index];
                            return sortsCode == article.sort
                                ? Container(
                                    color: providerdata.activeArticle.id ==
                                            article.id
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
                                        onLongPress: () {
                                          print("object");
                                          widget.loadArticle(article);
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SaveArticles(
                                                    saveArticle: (_article) =>
                                                        _fileActions
                                                            .saveArticle(
                                                                context,
                                                                _article));
                                              });
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(article.title,
                                                textAlign: TextAlign.left,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTheme.subTitleFont),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(article.outline,
                                                textAlign: TextAlign.left,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTheme.contentFont),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(article.editDate,
                                                textAlign: TextAlign.left,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTheme.dateFont)
                                          ],
                                        )),
                                  )
                                : Container();
                          })
                      : Text(isList ? "文档视图" : "大纲视图"),
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
                          child: ArticlesBottom(
                            newArticle: () => _newArticle(),
                            changeSorts: (_sortsCode) =>
                                _changeSorts(_sortsCode),
                          )))
                  : Container()
            ],
          ),
        ));
  }

  _isListAction(bool _isList) {
    if (_isList) {
      setState(() {
        isList = false;
        articlesFrameHeight = 85;
      });
    } else {
      setState(() {
        isList = true;
        articlesFrameHeight = 55;
      });
    }
  }

  _newArticle() {
    widget.newArticle();
  }

  _changeSorts(String _sortsCode) {
    setState(() {
      sortsCode = _sortsCode;
    });
  }
}
