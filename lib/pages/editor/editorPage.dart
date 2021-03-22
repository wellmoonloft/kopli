import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kopli/commonWidgets/appTheme.dart';
import 'package:kopli/commonWidgets/colorTheme.dart';
import 'package:kopli/markdown/my_extended_text_selection_controls.dart';
import 'package:kopli/markdown/my_special_text_span_builder.dart';
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

  TextEditingController controller = TextEditingController();
  final MyTextSelectionControls _myExtendedMaterialTextSelectionControls =
      MyTextSelectionControls();
  final MySpecialTextSpanBuilder _mySpecialTextSpanBuilder =
      MySpecialTextSpanBuilder();

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
            width: (width - 270) / 2,
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
          width: (width - 270) / 2,
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
                  child:
                      //     ExtendedTextField(
                      //   autofocus: true,
                      //   controller: providerdata.controller,
                      //   selectionControls: _myExtendedMaterialTextSelectionControls,
                      //   specialTextSpanBuilder: _mySpecialTextSpanBuilder,
                      //   scrollController: _controllerScroll,
                      //   keyboardType: TextInputType.multiline,
                      //   maxLines: null,
                      //   decoration: InputDecoration(
                      //     isDense: true,
                      //     contentPadding: EdgeInsets.symmetric(vertical: 4),
                      //     border: InputBorder.none,
                      //   ),
                      // )

                      TextField(
                    autofocus: true,
                    controller: providerdata.controller,
                    scrollController: _controllerScroll,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      fontSize: 14,
                      //color: ColorTheme.transparent,
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
                // Positioned(
                //     // left: 0,
                //     // top: 0,
                //     child: Container(
                //         color: ColorTheme.greenlighter,
                //         child: ExtendedTextField(
                //           selectionControls:
                //               _myExtendedMaterialTextSelectionControls,
                //           specialTextSpanBuilder: _mySpecialTextSpanBuilder,
                //           controller: controller,
                //           maxLines: null,
                //           decoration: InputDecoration(
                //             isDense: true,
                //             contentPadding: EdgeInsets.symmetric(vertical: 4),
                //             border: InputBorder.none,
                //           ),
                //         ))

                //     //     child: IgnorePointer(
                //     //         child: Container(
                //     //             // width: 200,
                //     //             // height: 200,
                //     //             //color: ColorTheme.redlighter,
                //     //             child: Markdown(
                //     //   // controller: _controllerScroll,
                //     //   data: providerdata.activeData,
                //     //   padding: EdgeInsets.only(left: 10, right: 10),
                //     // )))
                //     ),
              ],
            );
          }),
        )
      ],
    );
  }
}
