import 'package:flutter/material.dart';
import 'package:kopli/commonWidgets/myDialog.dart';
import 'package:kopli/utils/appTheme.dart';
import 'package:kopli/utils/colorTheme.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/utils/dbHelper.dart';
import 'package:kopli/commonWidgets/myBottom.dart';
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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    super.dispose();
  }

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
                    child: Text("添加分类",
                        style: AppTheme.titleFont, textAlign: TextAlign.start)),
                TextField(
                  autofocus: true,
                  controller: _nameController,
                  style: AppTheme.titleFont,
                  decoration: InputDecoration(
                      labelText: "标签名称",
                      fillColor: ColorTheme.leftBackColor,
                      labelStyle: AppTheme.dateFont),
                ),
                TextField(
                  autofocus: true,
                  controller: _codeController,
                  style: AppTheme.titleFont,
                  decoration: InputDecoration(
                      labelText: "标签代码（最好为英文）",
                      fillColor: ColorTheme.leftBackColor,
                      labelStyle: AppTheme.dateFont),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyBottom(
                      title: "退出",
                      type: "cancel",
                      onPress: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MyBottom(
                      title: isSave ? "保存" : "更新",
                      type: "confirm",
                      onPress: () async {
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
                    child: Text("分类列表",
                        style: AppTheme.titleFont, textAlign: TextAlign.start)),
                Consumer<ProviderData>(builder: (context, providerdata, child) {
                  List<Sorts> sortsList = providerdata.sortsList;
                  return Container(
                      padding: EdgeInsets.all(10),
                      height: 420,
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
                                  Text(sort.sortsName,
                                      style: AppTheme.titleFont),
                                  Text(sort.sortsCode,
                                      style: AppTheme.titleFont),
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
                                          child: Text("编辑",
                                              style:
                                                  AppTheme.borderbottomfont)),
                                      TextButton(
                                          onPressed: () async {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return MyDialog(
                                                    title: "删除分类",
                                                    content: "是否确认删除分类",
                                                    onPress: () async {
                                                      await DBHelper()
                                                          .deleteSorts(sort)
                                                          .then((value) {
                                                        var providerData =
                                                            Provider.of<
                                                                    ProviderData>(
                                                                context,
                                                                listen: false);

                                                        providerData.getSorts();
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    },
                                                  );
                                                });
                                          },
                                          child: Text("删除",
                                              style: AppTheme.borderbottomfont))
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
