import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kopli/utils/appTheme.dart';
import 'package:kopli/utils/colorTheme.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:provider/provider.dart';

class EditorPage extends StatefulWidget {
  final TextEditingController controller;
  final double offset;
  final scrollOffset;

  const EditorPage({Key key, this.controller, this.offset, this.scrollOffset})
      : super(key: key);
  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  ScrollController _controllerScroll = ScrollController();
  @override
  void initState() {
    super.initState();

    _controllerScroll.addListener(() {
      widget.scrollOffset(_controllerScroll.offset);
    });
  }

  @override
  void dispose() {
    _controllerScroll.dispose();
    super.dispose();
  }

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
            child:
                Consumer<ProviderData>(builder: (context, providerdata, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: providerdata.activeArticle != null
                        ? Text(
                            providerdata.activeArticle.fileName == null
                                ? "未命名"
                                : providerdata.activeArticle.fileName,
                            style: AppTheme.dateFont)
                        : Container(),
                  ),
                  Container(
                      child: providerdata.isEdit
                          ? Text("-已编辑", style: AppTheme.dateFont)
                          : Container()),
                ],
              );
            })),
        Container(
          width: (width / height > 1) ? (width - 270) / 2 : 0,
          height: height - 30,
          decoration: BoxDecoration(
            color: ColorTheme.white,
            border: Border(
                left: BorderSide(
                    color: ColorTheme.greydoublelighter, width: 0.5)),
          ),
          padding: EdgeInsets.only(left: 10, right: 10),
          child:
              Consumer<ProviderData>(builder: (context, providerdata, child) {
            return TextField(
              autofocus: true,
              controller: providerdata.controller,
              scrollController: _controllerScroll,
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
            );
          }),
        )
      ],
    );
  }
}
