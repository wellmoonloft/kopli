import 'package:flutter/material.dart';
import 'package:kopli/commonWidgets/myBottom.dart';
import 'package:kopli/commonWidgets/myTextField.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/commonWidgets/appTheme.dart';
import 'package:kopli/commonWidgets/colorTheme.dart';
import 'package:kopli/utils/dbHelper.dart';
import 'package:kopli/utils/getPlatform.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:provider/provider.dart';

class AddSortsPage extends StatefulWidget {
  final Sorts sorts;
  final TextEditingController nameController;
  final TextEditingController codeController;

  const AddSortsPage(
      {Key key, this.sorts, this.nameController, this.codeController})
      : super(key: key);
  @override
  _AddSortsPageState createState() => _AddSortsPageState();
}

class _AddSortsPageState extends State<AddSortsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:
          GetPlatform().getIsMobile() ? 200 : MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
          left: GetPlatform().getIsMobile() ? 10 : 20,
          right: GetPlatform().getIsMobile() ? 10 : 20),
      child: Column(
        children: [
          GetPlatform().getIsMobile()
              ? Container(
                  width: 200,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: ColorTheme.white,
                      border: Border(
                          bottom: BorderSide(
                              color: ColorTheme.greydoublelighter,
                              width: 0.5))),
                  child: Text("添加分类",
                      style: AppTheme.titleFont, textAlign: TextAlign.start))
              : Container(),
          Container(
              padding: EdgeInsets.only(top: 16),
              child: MyTextField(
                controller: widget.nameController,
                laberText: "标签名称",
                lengthLimit: 12,
              )),
          Container(
              padding: EdgeInsets.only(top: 16, bottom: 20),
              child: MyTextField(
                controller: widget.codeController,
                laberText: "标签代码（最好为英文）",
                lengthLimit: 12,
              )),
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
                title: "保存",
                type: "confirm",
                onPress: () async {
                  if (widget.nameController.text == "") {
                    print("name空");
                  } else if (widget.codeController.text == "") {
                    print("code空");
                  } else {
                    print("save");

                    widget.sorts.sortsName = widget.nameController.text;
                    widget.sorts.sortsCode = widget.codeController.text;
                    await DBHelper().updateSorts(widget.sorts).then((value) {
                      var providerData =
                          Provider.of<ProviderData>(context, listen: false);

                      providerData.getSorts();
                      widget.nameController.text = "";
                      widget.codeController.text = "";
                      widget.sorts.id = null;
                    });
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
