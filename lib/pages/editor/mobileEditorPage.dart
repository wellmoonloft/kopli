import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:kopli/commonWidgets/appTheme.dart';
import 'package:kopli/commonWidgets/colorTheme.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/utils/fileActions.dart';
import 'package:kopli/utils/hotKey.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:provider/provider.dart';

class MobileEditorPage extends StatefulWidget {
  final bool isNew;
  final Article article;

  const MobileEditorPage({Key key, this.isNew, this.article}) : super(key: key);
  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<MobileEditorPage> {
  final _focusSample = FocusNode();

  @override
  void initState() {
    super.initState();
    var providerData = Provider.of<ProviderData>(context, listen: false);
    FileActions _fileActions = FileActions();
    if (widget.isNew) {
      _fileActions.initFiles(context);
    }
    providerData.controller.addListener(() {
      if (providerData.activeData != providerData.controller.text) {
        providerData.setActveData(providerData.controller.text);
        providerData.setIsEdit(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Consumer<ProviderData>(builder: (context, providerdata, child) {
            return Text(
                providerdata.activeArticle.fileName == null
                    ? "新建文章"
                    : providerdata.activeArticle.fileName,
                style: AppTheme.mobileTitleFont);
          }),
          backgroundColor: ColorTheme.leftBackColor,
          elevation: 0,
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
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      providerdata.isEdit
                          ? Icon(
                              FontAwesomeIcons.minusCircle,
                              color: ColorTheme.darkred,
                              size: 12,
                            )
                          : Container(),
                      SizedBox(
                        width: 10,
                      ),
                      Text("字数：" + providerdata.activeData.length.toString(),
                          textAlign: TextAlign.end, style: AppTheme.dateFont)
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: ColorTheme.white,
            border: Border(
                left: BorderSide(
                    color: ColorTheme.greydoublelighter, width: 0.5)),
          ),
          padding: EdgeInsets.only(left: 10, right: 10),
          child:
              Consumer<ProviderData>(builder: (context, providerdata, child) {
            return KeyboardActions(
                tapOutsideToDismiss: true,
                config: KeyboardActionsConfig(
                  keyboardSeparatorColor: Colors.purple,
                  actions: [
                    KeyboardActionsItem(
                      focusNode: _focusSample,
                      displayArrows: false,
                      displayActionBar: false,
                      footerBuilder: (context) {
                        return MyCustomBarWidget(
                          node: _focusSample,
                          controller: providerdata.controller,
                        );
                      },
                    ),
                  ],
                ),
                child: TextField(
                  autofocus: true,
                  focusNode: _focusSample,
                  controller: providerdata.controller,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorTheme.mainColor,
                  ),
                  maxLines: 500,
                  minLines: 1,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                    border: InputBorder.none,
                  ),
                ));
          }),
        ));
  }
}

class MyCustomBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final FocusNode node;
  final TextEditingController controller;

  const MyCustomBarWidget({
    Key key,
    this.node,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () => HotKey().mobileShortcut(context, "h1"),
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text("H1", style: AppTheme.mobileTextbottomfont))),
            InkWell(
                onTap: () => HotKey().mobileShortcut(context, "h2"),
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text("H2", style: AppTheme.mobileTextbottomfont))),
            InkWell(
                onTap: () => HotKey().mobileShortcut(context, "h3"),
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text("H3", style: AppTheme.mobileTextbottomfont))),
            InkWell(
                onTap: () => HotKey().mobileShortcut(context, "l"),
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text("L", style: AppTheme.mobileTextbottomfont))),
            InkWell(
                onTap: () => HotKey().mobileShortcut(context, "b"),
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text("B", style: AppTheme.mobileTextbottomfont))),
            InkWell(
                onTap: () => HotKey().mobileShortcut(context, "i"),
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text("I", style: AppTheme.mobileTextbottomfont))),
            InkWell(
                onTap: () => HotKey().mobileShortcut(context, "c"),
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text("C", style: AppTheme.mobileTextbottomfont))),
            InkWell(
                onTap: () => HotKey().mobileShortcut(context, "q"),
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text("Q", style: AppTheme.mobileTextbottomfont))),
            InkWell(
                onTap: () {
                  HotKey().mobileShortcut(context, "save");
                  node.unfocus();
                },
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text("保存", style: AppTheme.mobileTextbottomfont))),
          ],
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
