import 'dart:io';
import 'package:kopli/commonWidgets/myDialog.dart';
import 'package:kopli/commonWidgets/myTextField.dart';
import 'package:kopli/utils/dbHelper.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kopli/commonWidgets/newSorts.dart';
import 'package:kopli/utils/appTheme.dart';
import 'package:kopli/utils/calendar_popup_view.dart';
import 'package:kopli/utils/colorTheme.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/commonWidgets/myBottom.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:provider/provider.dart';
import 'package:textfield_tags/textfield_tags.dart';

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
            height: 420,
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
                    padding: EdgeInsets.only(top: 16),
                    child: MyTextField(
                      controller: _filecontroller,
                      laberText: "保存为",
                      lengthLimit: 28,
                    )),
                Container(
                    padding: EdgeInsets.only(top: 16),
                    child: MyTextField(
                      controller: _outlinecontroller,
                      laberText: "摘要（为空则自动选取内容前50字）",
                      maxLies: 2,
                      lengthLimit: 50,
                    )),
                Container(
                    padding: EdgeInsets.only(top: 16, bottom: 6),
                    child: InkWell(
                        onTap: () {
                          showCalendar(context: context);
                        },
                        child: MyTextField(
                          controller: _dateTimecontroller,
                          laberText: "文章发布时间",
                          onTap: () => {showCalendar(context: context)},
                        ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyBottom(
                      type: "confirm",
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
                TextFieldTags(
                    //initialTags: ['university', 'college', 'music', 'math'],
                    tagsStyler: TagsStyler(
                        tagTextStyle: AppTheme.bottomfontwhite,
                        tagDecoration: BoxDecoration(
                          color: ColorTheme.appleBlue,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        tagCancelIcon: Icon(Icons.cancel,
                            size: 12.0, color: ColorTheme.white),
                        tagPadding: const EdgeInsets.all(6.0)),
                    textFieldStyler: TextFieldStyler(
                        helperText: null,
                        hintText: "请输入标签",
                        hintStyle: AppTheme.dateFont),
                    onTag: (tag) {},
                    onDelete: (tag) {}),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
