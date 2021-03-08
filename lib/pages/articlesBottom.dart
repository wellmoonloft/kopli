import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kopli/dialogs/newSorts.dart';
import 'package:kopli/utils/appTheme.dart';
import 'package:kopli/utils/colorTheme.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:provider/provider.dart';
import 'package:kopli/model/dataModels.dart';

class ArticlesBottom extends StatefulWidget {
  final newArticle;
  final changeSorts;

  const ArticlesBottom({Key key, this.newArticle, this.changeSorts})
      : super(key: key);
  @override
  _ArticlesBottomState createState() => _ArticlesBottomState();
}

class _ArticlesBottomState extends State<ArticlesBottom> {
  String itemValue = "default";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Tooltip(
          message: "新建文章",
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.plus,
              color: ColorTheme.greylighter,
            ),
            iconSize: 14,
            onPressed: () {
              widget.newArticle();
            },
          ),
        ),
        Tooltip(
          message: "切换分类",
          child: Container(
              width: 190,
              child: Consumer<ProviderData>(
                  builder: (context, providerdata, child) {
                List<Sorts> sortslist = providerdata.sortsList;
                List<DropdownMenuItem> sorts = [];
                if (sortslist != null) {
                  sortslist.forEach((element) {
                    sorts.add(DropdownMenuItem(
                      value: element.sortsCode,
                      child: Text(element.sortsName, style: AppTheme.titleFont),
                    ));
                  });
                } else {
                  sorts.add(DropdownMenuItem(
                    value: "default",
                    child: Text("默认", style: AppTheme.titleFont),
                  ));
                }

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
                      widget.changeSorts(value);
                    },
                  ),
                );
              })),
        ),
        Tooltip(
          message: "新建分类",
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.folderPlus,
              color: ColorTheme.greylighter,
            ),
            iconSize: 14,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NewSorts();
                  });
            },
          ),
        )
      ],
    );
  }
}
