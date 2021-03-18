import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/commonWidgets/appTheme.dart';
import 'package:kopli/commonWidgets/colorTheme.dart';
import 'package:kopli/pages/editor/mobileEditorPage.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:provider/provider.dart';

class MobilePreview extends StatelessWidget {
  final Article article;

  const MobilePreview({Key key, this.article}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: ColorTheme.leftBackColor,
            elevation: 0,
            title: Text(article.fileName, style: AppTheme.mobileTitleFont),
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
              Container(
                child: Consumer<ProviderData>(
                    builder: (context, providerdata, child) {
                  return Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                        "字数：" + providerdata.activeData.length.toString(),
                        textAlign: TextAlign.end,
                        style: AppTheme.dateFont),
                  );
                }),
              ),
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.edit,
                    color: ColorTheme.appleBlue,
                  ),
                  iconSize: 16,
                  tooltip: '编辑文章',
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => MobileEditorPage(
                              isNew: false,
                              article: article,
                            )));
                  }),
            ]),
        body: Container(
          width: width,
          height: height - 130,
          child:
              Consumer<ProviderData>(builder: (context, providerdata, child) {
            return Markdown(
              //controller: _controller,
              data: providerdata.activeData,
              padding: EdgeInsets.only(left: 16, right: 16),
            );
          }),
        ));
  }
}
