import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/pages/sorts/addSorts.dart';
import 'package:kopli/pages/sorts/sortsList.dart';
import 'package:kopli/commonWidgets/appTheme.dart';
import 'package:kopli/commonWidgets/colorTheme.dart';
import 'package:kopli/utils/getPlatform.dart';

class SortsPage extends StatefulWidget {
  @override
  _SortsPageState createState() => _SortsPageState();
}

class _SortsPageState extends State<SortsPage> {
  Sorts _sorts = Sorts();
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
    return GetPlatform().getIsMobile()
        ? Dialog(
            child: Container(
              width: 520,
              height: 500,
              child: Row(
                children: [
                  AddSortsPage(
                    sorts: _sorts,
                    nameController: _nameController,
                    codeController: _codeController,
                  ),
                  SortsListPage(
                    sorts: _sorts,
                    nameController: _nameController,
                    codeController: _codeController,
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            //Ensure that the pop-up keyboard UI is good
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text("添加分类", style: AppTheme.mobileTitleFont),
              backgroundColor: ColorTheme.leftBackColor,
              elevation: 0,
              leading: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: ColorTheme.appleBlue,
                  ),
                  iconSize: 16,
                  tooltip: '新建文章',
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
            body: Column(
              children: [
                AddSortsPage(
                  sorts: _sorts,
                  nameController: _nameController,
                  codeController: _codeController,
                ),
                SortsListPage(
                  sorts: _sorts,
                  nameController: _nameController,
                  codeController: _codeController,
                )
              ],
            ),
          );
  }
}
