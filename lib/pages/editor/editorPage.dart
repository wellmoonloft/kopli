import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kopli/commonWidgets/appTheme.dart';
import 'package:kopli/commonWidgets/colorTheme.dart';
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
                      padding: EdgeInsets.only(left: 10),
                      child: providerdata.isEdit
                          ? Icon(
                              FontAwesomeIcons.minusCircle,
                              color: ColorTheme.darkred,
                              size: 12,
                            )
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
            return Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  //sdfsdcolor: ColorTheme.greenlighter,
                  child: TextField(
                    autofocus: true,
                    controller: providerdata.controller,
                    scrollController: _controllerScroll,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorTheme.transparent,
                    ),
                    maxLines: 500,
                    minLines: 1,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 4),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Positioned(
                    // left: 0,
                    // top: 0,
                    child: IgnorePointer(
                        child: Container(
                            // width: 200,
                            // height: 200,
                            //color: ColorTheme.redlighter,
                            child: Markdown(
                  // controller: _controllerScroll,
                  data: providerdata.activeData,
                  padding: EdgeInsets.only(left: 10, right: 10),
                )))),
              ],
            );
          }),
        )
      ],
    );
  }
}
