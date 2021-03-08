import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kopli/utils/appTheme.dart';
import 'package:kopli/utils/colorTheme.dart';

class PreviewPage extends StatefulWidget {
  final String data;
  final double offset;
  final scrollOffset;

  const PreviewPage({Key key, this.data, this.offset, this.scrollOffset})
      : super(key: key);
  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
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
    if (widget.offset != 0.0) {
      _controller.jumpTo(widget.offset);
    }

    return Column(
      children: [
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
              Container(),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text("字数：" + widget.data.length.toString(),
                    style: AppTheme.dateFont),
              ),
            ],
          ),
        ),
        Container(
          width: (width / height > 1) ? (width - 270) / 2 : 0,
          decoration: BoxDecoration(
            color: ColorTheme.white,
            border: Border(
                left: BorderSide(
                    color: ColorTheme.greydoublelighter, width: 0.5)),
          ),
          height: height - 30,
          child: Markdown(
            controller: _controller,
            data: widget.data,
            padding: EdgeInsets.only(left: 10, right: 10),
          ),
        )
      ],
    );
  }
}
