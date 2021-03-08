import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kopli/commonWidgets/newSorts.dart';
import 'package:kopli/utils/appTheme.dart';
import 'package:kopli/utils/colorTheme.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/commonWidgets/myBottom.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:provider/provider.dart';

class SaveArticles extends StatefulWidget {
  final saveArticle;

  const SaveArticles({Key key, this.saveArticle}) : super(key: key);
  @override
  _SaveArticlesState createState() => _SaveArticlesState();
}

class _SaveArticlesState extends State<SaveArticles> {
  TextEditingController _filecontroller = new TextEditingController();
  TextEditingController _outlinecontroller = new TextEditingController();
  TextEditingController _dateTimecontroller = new TextEditingController();
  String itemValue = "default";

  @override
  void initState() {
    super.initState();

    setState(() {
      _filecontroller.text = "未命名.md";
      _outlinecontroller.text = "";
      _dateTimecontroller.text =
          DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    });
  }

  @override
  void dispose() {
    _filecontroller.dispose();
    _outlinecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
            width: 400,
            height: 300,
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Container(
                    width: 400,
                    child: Text("保存文章",
                        style: AppTheme.titleFont, textAlign: TextAlign.start)),
                TextField(
                  autofocus: true,
                  controller: _filecontroller,
                  style: AppTheme.pagefont,
                  inputFormatters: [LengthLimitingTextInputFormatter(28)],
                  decoration: InputDecoration(
                    labelText: '保存为',
                    fillColor: ColorTheme.leftBackColor,
                    labelStyle: AppTheme.dateFont,
                  ),
                ),
                TextField(
                  autofocus: true,
                  controller: _outlinecontroller,
                  maxLines: 2,
                  style: AppTheme.pagefont,
                  inputFormatters: [LengthLimitingTextInputFormatter(50)],
                  decoration: InputDecoration(
                    labelText: '摘要（为空则自动选取内容前50字）',
                    fillColor: ColorTheme.leftBackColor,
                    labelStyle: AppTheme.dateFont,
                  ),
                ),
                TextField(
                  autofocus: true,
                  controller: _dateTimecontroller,
                  maxLines: 2,
                  style: AppTheme.pagefont,
                  onTap: () async {},
                  decoration: InputDecoration(
                    labelText: '文章发布时间',
                    fillColor: ColorTheme.leftBackColor,
                    labelStyle: AppTheme.dateFont,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyBottom(
                      onPress: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return NewSorts();
                            });
                      },
                      title: "新建分类",
                    ),
                    Row(
                      children: [
                        Text("请选择分类", style: AppTheme.dateFont),
                        Consumer<ProviderData>(
                            builder: (context, providerdata, child) {
                          List<Sorts> sortslist = providerdata.sortsList;
                          List<DropdownMenuItem> sorts = [];
                          sortslist.forEach((element) {
                            sorts.add(DropdownMenuItem(
                                value: element.sortsCode,
                                child: Text(element.sortsName,
                                    style: AppTheme.pagefont)));
                          });

                          return Container(
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.center,
                            child: DropdownButton(
                              items: sorts,
                              value: itemValue,
                              iconSize: 12,
                              style: AppTheme.titleFont,
                              underline: Container(height: 0),
                              elevation: 1,
                              onChanged: (value) {
                                setState(() {
                                  itemValue = value;
                                });
                              },
                            ),
                          );
                        })
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // MyBottom(
                    //   title: "新建标签",
                    //   onPress: () {},
                    // ),
                    Container(),
                    Row(
                      children: [
                        MyBottom(
                          title: "取消",
                          type: "cancel",
                          onPress: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MyBottom(
                          title: "保存",
                          type: "confirm",
                          onPress: () {
                            Article article = Article();
                            article.fileName = _filecontroller.text;
                            article.sort = itemValue;
                            article.outline = _outlinecontroller.text;
                            widget.saveArticle(article);
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    )
                  ],
                )
              ],
            )));
  }
}
