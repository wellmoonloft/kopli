import 'package:flutter/material.dart';
import 'package:kopli/utils/appTheme.dart';
import 'package:kopli/utils/colorTheme.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/utils/dbHelper.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:provider/provider.dart';

class NewSorts extends StatefulWidget {
  @override
  _NewSortsState createState() => _NewSortsState();
}

class _NewSortsState extends State<NewSorts> {
  Sorts sorts = Sorts();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _codeController = new TextEditingController();
  bool isSave = true;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      width: 520,
      height: 500,
      child: Row(
        children: [
          Container(
            width: 200,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                    width: 200,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: ColorTheme.white,
                        border: Border(
                            bottom: BorderSide(
                                color: ColorTheme.greydoublelighter,
                                width: 0.5))),
                    child: Text("添加分类", textAlign: TextAlign.start)),
                TextField(
                  autofocus: true,
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "标签名称",
                    fillColor: ColorTheme.leftBackColor,
                    labelStyle: TextStyle(
                      color: ColorTheme.mainColor,
                      fontSize: 12,
                    ),
                    //border: InputBorder.none,
                  ),
                ),
                TextField(
                  autofocus: true,
                  controller: _codeController,
                  decoration: InputDecoration(
                    labelText: "标签代码（最好为英文）",
                    fillColor: ColorTheme.leftBackColor,
                    labelStyle: TextStyle(
                      color: ColorTheme.mainColor,
                      fontSize: 12,
                    ),
                    //border: InputBorder.none,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text('退出', style: AppTheme.pagefont),
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
                      onPressed: () async {
                        if (_nameController.text == "") {
                          print("name空");
                        } else if (_codeController.text == "") {
                          print("code空");
                        } else {
                          print("save");

                          sorts.sortsName = _nameController.text;
                          sorts.sortsCode = _codeController.text;
                          await DBHelper().updateSorts(sorts).then((value) {
                            var providerData = Provider.of<ProviderData>(
                                context,
                                listen: false);

                            providerData.getSorts();
                            _nameController.text = "";
                            _codeController.text = "";
                            sorts.id = null;
                            setState(() {
                              isSave = true;
                            });
                          });
                        }
                      },
                      child: Text(isSave ? "保存" : "更新",
                          style: AppTheme.pagefontwhite),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorTheme.white,
              border: Border(
                  left: BorderSide(
                      color: ColorTheme.greydoublelighter, width: 0.5)),
            ),
            child: Column(
              children: [
                Container(
                    width: 290,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: ColorTheme.white,
                        border: Border(
                            bottom: BorderSide(
                                color: ColorTheme.greydoublelighter,
                                width: 0.5))),
                    child: Text("分类列表", textAlign: TextAlign.start)),
                Consumer<ProviderData>(builder: (context, providerdata, child) {
                  List<Sorts> sortsList = providerdata.sortsList;
                  return Container(
                      padding: EdgeInsets.all(10),
                      //height: 200,
                      width: 280,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: sortsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var sort = sortsList[index];

                          return Container(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(sort.sortsName),
                                  Text(sort.sortsCode),
                                  Row(
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            _nameController.text =
                                                sort.sortsName;
                                            _codeController.text =
                                                sort.sortsCode;
                                            sorts.id = sort.id;
                                            setState(() {
                                              isSave = false;
                                            });
                                          },
                                          child: Text("编辑")),
                                      TextButton(
                                          onPressed: () async {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    content: Text("是否确认删除分类"),
                                                    title: Center(
                                                        child: Text(
                                                      "删除分类",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                    actions: <Widget>[
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            //Navigator.of(context).pop();
                                                          },
                                                          child: Text('取消')),
                                                      TextButton(
                                                          onPressed: () async {
                                                            await DBHelper()
                                                                .deleteSorts(
                                                                    sort)
                                                                .then((value) {
                                                              var providerData =
                                                                  Provider.of<
                                                                          ProviderData>(
                                                                      context,
                                                                      listen:
                                                                          false);

                                                              providerData
                                                                  .getSorts();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            });
                                                          },
                                                          child: Text('确定')),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: Text("删除"))
                                    ],
                                  )
                                ],
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: ColorTheme.greydoublelighter,
                            height: 2,
                          );
                        },
                      ));
                }),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
