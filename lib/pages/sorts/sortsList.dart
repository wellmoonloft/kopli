import 'package:flutter/material.dart';
import 'package:kopli/commonWidgets/myDialog.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/commonWidgets/appTheme.dart';
import 'package:kopli/commonWidgets/colorTheme.dart';
import 'package:kopli/utils/dbHelper.dart';
import 'package:kopli/utils/getPlatform.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:provider/provider.dart';

class SortsListPage extends StatefulWidget {
  final Sorts sorts;
  final TextEditingController nameController;
  final TextEditingController codeController;

  const SortsListPage(
      {Key key, this.sorts, this.nameController, this.codeController})
      : super(key: key);
  @override
  _SortsPageState createState() => _SortsPageState();
}

class _SortsPageState extends State<SortsListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: GetPlatform().getIsMobile() ? 10 : 20,
          right: GetPlatform().getIsMobile() ? 10 : 20),
      decoration: BoxDecoration(
        color: GetPlatform().getIsMobile()
            ? ColorTheme.white
            : ColorTheme.leftBackColor,
        border: Border(
            left: BorderSide(color: ColorTheme.greydoublelighter, width: 0.5)),
      ),
      child: Column(
        children: [
          GetPlatform().getIsMobile()
              ? Container(
                  width: 290,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: GetPlatform().getIsMobile()
                          ? ColorTheme.white
                          : ColorTheme.leftBackColor,
                      border: Border(
                          bottom: BorderSide(
                              color: ColorTheme.greydoublelighter,
                              width: 0.5))),
                  child: Text("分类列表",
                      style: AppTheme.titleFont, textAlign: TextAlign.start))
              : Container(),
          Consumer<ProviderData>(builder: (context, providerdata, child) {
            List<Sorts> sortsList = providerdata.sortsList;
            return Container(
                padding: EdgeInsets.all(10),
                height: GetPlatform().getIsMobile()
                    ? 420
                    : MediaQuery.of(context).size.height - 300,
                width: GetPlatform().getIsMobile()
                    ? 280
                    : MediaQuery.of(context).size.width,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: sortsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var sort = sortsList[index];

                    return Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(sort.sortsName,
                                style: GetPlatform().getIsMobile()
                                    ? AppTheme.titleFont
                                    : AppTheme.mobileTitleFont),
                            Text(sort.sortsCode,
                                style: GetPlatform().getIsMobile()
                                    ? AppTheme.titleFont
                                    : AppTheme.mobileTitleFont),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      widget.nameController.text =
                                          sort.sortsName;
                                      widget.codeController.text =
                                          sort.sortsCode;
                                      widget.sorts.id = sort.id;
                                    },
                                    child: Text("编辑",
                                        style: GetPlatform().getIsMobile()
                                            ? AppTheme.borderbottomfont
                                            : AppTheme.mobileBorderbottomfont)),
                                TextButton(
                                    onPressed: () async {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return MyDialog(
                                              title: "删除分类",
                                              content: "是否确认删除分类",
                                              onPress: () async {
                                                await DBHelper()
                                                    .deleteSorts(sort)
                                                    .then((value) {
                                                  var providerData =
                                                      Provider.of<ProviderData>(
                                                          context,
                                                          listen: false);

                                                  if (value == -1) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return MyDialog(
                                                            isAlert: true,
                                                            title: "删除错误",
                                                            content:
                                                                "当前分类下仍有文章，请先删除文章",
                                                            onPress: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          );
                                                        });
                                                  } else {
                                                    providerData.getSorts();
                                                    Navigator.of(context).pop();
                                                  }
                                                });
                                              },
                                            );
                                          });
                                    },
                                    child: Text("删除",
                                        style: GetPlatform().getIsMobile()
                                            ? AppTheme.borderbottomfont
                                            : AppTheme.mobileBorderbottomfont))
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
    );
  }
}
