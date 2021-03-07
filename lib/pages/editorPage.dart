import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kopli/model/dataModels.dart';
import 'package:kopli/utils/appTheme.dart';
import 'package:kopli/utils/colorTheme.dart';

class EditorPage extends StatefulWidget {
  final TextEditingController controller;
  final bool isEdit;
  final Article activeArticle;
  final double offset;
  final scrollOffset;

  const EditorPage(
      {Key key,
      this.controller,
      this.isEdit,
      this.activeArticle,
      this.offset,
      this.scrollOffset})
      : super(key: key);
  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      widget.scrollOffset(_controller.offset);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                    widget.activeArticle.fileName == null
                        ? "未保存"
                        : widget.activeArticle.fileName,
                    style: AppTheme.pagefont),
              ),
              Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: widget.isEdit
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
          child: TextField(
            autofocus: true,
            controller: widget.controller,
            scrollController: _controller,
            keyboardType: TextInputType.multiline,
            maxLines: 500,
            maxLengthEnforcement:
                MaxLengthEnforcement.truncateAfterCompositionEnds,
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
