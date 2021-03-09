import 'dart:io';
import 'package:kopli/commonWidgets/myDialog.dart';
import 'package:kopli/utils/dbHelper.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kopli/commonWidgets/newSorts.dart';
import 'package:kopli/utils/appTheme.dart';
import 'package:kopli/utils/calendar_popup_view.dart';
import 'package:kopli/utils/colorTheme.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/commonWidgets/myBottom.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:provider/provider.dart';

class SaveArticles extends StatefulWidget {
  final saveArticle;
  final String dir;
  final String stringData;

  const SaveArticles({Key key, this.saveArticle, this.dir, this.stringData})
      : super(key: key);
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
            height: 350,
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Container(
                    width: 400,
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: ColorTheme.white,
                        border: Border(
                            bottom: BorderSide(
                                color: ColorTheme.greydoublelighter,
                                width: 0.5))),
                    child: Text("保存文章",
                        style: AppTheme.titleFont, textAlign: TextAlign.start)),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: TextField(
                    autofocus: true,
                    controller: _filecontroller,
                    style: AppTheme.pagefont,
                    inputFormatters: [LengthLimitingTextInputFormatter(28)],
                    decoration: InputDecoration(
                      labelText: '保存为',
                      isDense: true,
                      fillColor: ColorTheme.leftBackColor,
                      labelStyle: AppTheme.dateFont,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: TextField(
                    autofocus: true,
                    controller: _outlinecontroller,
                    maxLines: 2,
                    style: AppTheme.pagefont,
                    inputFormatters: [LengthLimitingTextInputFormatter(50)],
                    decoration: InputDecoration(
                      labelText: '摘要（为空则自动选取内容前50字）',
                      isDense: true,
                      fillColor: ColorTheme.leftBackColor,
                      labelStyle: AppTheme.dateFont,
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: TextField(
                      autofocus: true,
                      controller: _dateTimecontroller,
                      style: AppTheme.pagefont,
                      onTap: () async {
                        showCalendar(context: context);
                      },
                      decoration: InputDecoration(
                        labelText: '文章发布时间',
                        isDense: true,
                        fillColor: ColorTheme.leftBackColor,
                        labelStyle: AppTheme.dateFont,
                      ),
                    )),
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
                SizedBox(
                  height: 20,
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
                          onPress: () async {
                            File file = new File(
                                p.join(widget.dir, _filecontroller.text));
                            await file.exists().then((value) async {
                              if (value) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return MyDialog(
                                        title: "无法保存",
                                        content: "存在同名的文章，请更改文章名字",
                                        isAlert: true,
                                        onPress: () {
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    });
                              } else {
                                Article article = Article();
                                article.fileName = _filecontroller.text;
                                article.title = _filecontroller.text;
                                article.sort = itemValue;
                                article.filePath = widget.dir;
                                article.createDate = _dateTimecontroller.text;
                                article.editDate = _dateTimecontroller.text;
                                if (_outlinecontroller.text == "") {
                                  if (widget.stringData.length > 50) {
                                    article.outline =
                                        widget.stringData.substring(0, 50);
                                  } else {
                                    article.outline = widget.stringData
                                        .substring(0, widget.stringData.length);
                                  }
                                } else {
                                  article.outline = _outlinecontroller.text;
                                }

                                await DBHelper()
                                    .updateArticle(article)
                                    .then((value) {
                                  article.id = value;
                                  File file = new File(
                                      p.join(widget.dir, article.fileName));
                                  file
                                      .writeAsString(widget.stringData)
                                      .whenComplete(() => {
                                            widget.saveArticle(article),
                                            print("保存成功" +
                                                p
                                                    .join(widget.dir,
                                                        article.fileName)
                                                    .toString())
                                          });
                                });

                                var providerData = Provider.of<ProviderData>(
                                    context,
                                    listen: false);
                                providerData.getArticle();
                                Navigator.of(context).pop();
                              }
                            });

                            //widget.saveArticle(article);
                          },
                        )
                      ],
                    )
                  ],
                )
              ],
            )));
  }

  void showCalendar({BuildContext context}) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        isSingleDate: true,
        //minimumDate: DateTime.now(),
        //maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        //initialEndDate: endDate,
        initialStartDate: DateTime.now(),
        onApplyClick:
            (DateTime startData, DateTime endData, DateTime month, int mark) {
          setState(() {
            _dateTimecontroller.text =
                DateFormat("yyyy-MM-dd HH:mm:ss").format(startData);
          });
        },
        onCancelClick: () {},
      ),
    );
  }
}
