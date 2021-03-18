import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/pages/articles/mobileArticlesList.dart';
import 'package:kopli/pages/sorts/sortsPage.dart';
import 'package:kopli/commonWidgets/appTheme.dart';
import 'package:kopli/commonWidgets/colorTheme.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:provider/provider.dart';

class MobileHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorTheme.leftBackColor,
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.folderPlus,
                  color: ColorTheme.appleBlue,
                ),
                iconSize: 16,
                tooltip: '新建分类',
                onPressed: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => SortsPage()));
                }),
          ],
        ),
        body: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "分类文件夹",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: ColorTheme.mainColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  //autofocus: true,
                  //controller: controller,

                  style: AppTheme.titleFont,
                  keyboardType: TextInputType.text,
                  onEditingComplete: () {
                    print("object");
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  inputFormatters: [LengthLimitingTextInputFormatter(20)],
                  decoration: InputDecoration(
                      hintText: "搜索",
                      hintStyle: AppTheme.mobileTitleFont,
                      prefixIcon: Icon(
                        FontAwesomeIcons.search,
                        color: ColorTheme.grey,
                        size: 18,
                      ),
                      isDense: true,
                      filled: true,
                      contentPadding: EdgeInsets.all(0.0),
                      fillColor: ColorTheme.greydoublelighter,
                      labelStyle: AppTheme.dateFont,
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
                Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("本地存储", style: AppTheme.mobileTitleFont),
                        IconButton(
                            icon: (Icon(
                              FontAwesomeIcons.angleDown,
                              color: ColorTheme.appleBlue,
                              size: 18,
                            )),
                            onPressed: () {})
                      ],
                    )),
                Consumer<ProviderData>(builder: (context, providerdata, child) {
                  List<Sorts> sortsList = providerdata.sortsList;
                  return sortsList == null
                      ? Container()
                      : Container(
                          padding: EdgeInsets.all(10),
                          decoration: AppTheme.boxDecoration,
                          width: MediaQuery.of(context).size.width,
                          height: 50 * sortsList.length.toDouble(),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: sortsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              Sorts sort = sortsList[index];

                              return Container(
                                  padding: EdgeInsets.all(10),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  MobileArticlesList(
                                                    sorts: sort,
                                                  )));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.folder,
                                              color: ColorTheme.appleBlue,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(sort.sortsName,
                                                style: AppTheme.mobileTitleFont)
                                          ],
                                        ),
                                        Icon(
                                          FontAwesomeIcons.angleRight,
                                          color: ColorTheme.greylighter,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                color: ColorTheme.greydoublelighter,
                                height: 2,
                              );
                            },
                          ),
                        );
                })
              ],
            )));
  }
}
