import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kopli/utils/appTheme.dart';
import 'package:kopli/utils/colorTheme.dart';

class PreviewPage extends StatelessWidget {
  final String data;

  const PreviewPage({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

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
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text("字数：" + data.length.toString(),
                    style: AppTheme.pagefont),
              ),
              // Container(
              //   padding: EdgeInsets.only(left: 10, right: 10),
              //   child: Text("紫薯"),
              // ),
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
            data: data,
            padding: EdgeInsets.only(left: 10, right: 10),
          ),
        )
      ],
    );
  }
}
