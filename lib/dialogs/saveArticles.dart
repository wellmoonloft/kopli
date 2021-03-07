import 'package:flutter/material.dart';
import 'package:kopli/utils/appTheme.dart';
import 'package:kopli/utils/colorTheme.dart';
import 'package:kopli/model/dataModels.dart';
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
  String itemValue = "default";

  @override
  void initState() {
    super.initState();

    setState(() {
      _filecontroller.text = "未命名.md";
    });
  }

  @override
  void dispose() {
    _filecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
            width: 500,
            height: 500,
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                    width: 200,
                    child: TextField(
                      autofocus: true,
                      controller: _filecontroller,
                      decoration: InputDecoration(
                        labelText: '保存为',
                        filled: true,
                        fillColor: ColorTheme.leftBackColor,
                        labelStyle: TextStyle(
                          color: ColorTheme.mainColor,
                          fontSize: 12,
                        ),
                        border: InputBorder.none,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("请选择分类", style: AppTheme.pagefont),
                    Consumer<ProviderData>(
                        builder: (context, providerdata, child) {
                      List<Sorts> sortslist = providerdata.sortsList;
                      List<DropdownMenuItem> sorts = [];
                      sortslist.forEach((element) {
                        sorts.add(DropdownMenuItem(
                          value: element.sortsCode,
                          child: Text(element.sortsName),
                        ));
                      });

                      return Container(
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.center,
                        child: DropdownButton(
                          items: sorts,
                          value: itemValue,
                          iconSize: 12,
                          style: AppTheme.pagefont,
                          underline: Container(height: 0),
                          elevation: 1,
                          onChanged: (value) {
                            //下拉菜单item点击之后的回调
                            setState(() {
                              itemValue = value;
                            });
                          },
                        ),
                      );
                    })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ColorTheme.greydoublelighter),
                      ),
                      onPressed: () {},
                      child: Text("新建标签", style: AppTheme.pagefont),
                    ),
                    Row(
                      children: [
                        TextButton(
                          child: Text('取消', style: AppTheme.pagefont),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ColorTheme.greydoublelighter),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ColorTheme.appleBlue),
                          ),
                          onPressed: () {
                            Article article = Article();
                            article.fileName = _filecontroller.text;
                            article.sort = itemValue;
                            widget.saveArticle(article);
                            Navigator.of(context).pop();
                          },
                          child: Text("保存", style: AppTheme.pagefontwhite),
                        )
                      ],
                    )
                  ],
                )
              ],
            )));
  }
}
