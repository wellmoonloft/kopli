import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/utils/appTheme.dart';
import 'package:kopli/utils/colorTheme.dart';

class EditorPage extends StatelessWidget {
  final TextEditingController controller;
  final bool isEdit;
  final Article activeArticle;

  const EditorPage({Key key, this.controller, this.isEdit, this.activeArticle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        Container(
          height: 30,
          width: (width / height > 1) ? (width - 270) / 2 : 0,
          decoration: BoxDecoration(
            color: ColorTheme.white,
            border: Border(
                left: BorderSide(
                    color: ColorTheme.greydoublelighter, width: 0.5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                    activeArticle.fileName == null
                        ? "未保存"
                        : activeArticle.fileName,
                    style: AppTheme.pagefont),
              ),
              Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: isEdit
                      ? Text("已编辑", style: AppTheme.pagefont)
                      : Container()),
            ],
          ),
        ),
        Container(
          width: (width / height > 1) ? (width - 270) / 2 : 0,
          height: height - 30,
          decoration: BoxDecoration(
            color: ColorTheme.white,
            border: Border(
                left: BorderSide(
                    color: ColorTheme.greydoublelighter, width: 0.5)),
          ),
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: 100,
            minLines: 1,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }
}
