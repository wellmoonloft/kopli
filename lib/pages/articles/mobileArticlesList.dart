import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/pages/editor/mobileEditorPage.dart';
import 'package:kopli/pages/preview/mobilePreview.dart';
import 'package:kopli/commonWidgets/appTheme.dart';
import 'package:kopli/commonWidgets/colorTheme.dart';
import 'package:kopli/utils/fileActions.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:provider/provider.dart';

class MobileArticlesList extends StatefulWidget {
  final Sorts sorts;

  const MobileArticlesList({Key key, this.sorts}) : super(key: key);
  @override
  _MobileArticlesListState createState() => _MobileArticlesListState();
}

class _MobileArticlesListState extends State<MobileArticlesList> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sorts.sortsName, style: AppTheme.mobileTitleFont),
        backgroundColor: ColorTheme.leftBackColor,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.angleLeft,
              color: ColorTheme.appleBlue,
            ),
            iconSize: 16,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.plus,
                color: ColorTheme.appleBlue,
              ),
              iconSize: 16,
              tooltip: '新建文章',
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => MobileEditorPage(
                          isNew: true,
                        )));
              }),
        ],
      ),
      body: Container(child: Consumer<ProviderData>(
        builder: (context, providerdata, child) {
          List<Article> tempList = providerdata.articleList;
          List<Article> articleList = [];
          if (tempList != null) {
            tempList.forEach((element) {
              if (element.sort == widget.sorts.sortsCode) {
                articleList.add(element);
              }
            });
          }

          return Container(
            padding: EdgeInsets.all(10),
            child: articleList.length > 0
                ? ListView.builder(
                    itemCount: articleList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var article = articleList[index];

                      return Container(
                        color: ColorTheme.leftBackColor,
                        padding: EdgeInsets.all(10),
                        child: InkWell(
                            onTap: () {
                              FileActions _fileActions = FileActions();
                              _fileActions.loadArticle(context, article);
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) => MobilePreview(
                                        article: article,
                                      )));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                      );
                    })
                : Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) => MobileEditorPage()));
                        },
                        child: Text("新建文章",
                            style: AppTheme.mobileBorderbottomfont)),
                  ),
          );
        },
      )),
    );
  }
}
