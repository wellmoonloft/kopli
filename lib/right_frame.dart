import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class RightFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Markdown(data: "**或者有人会说**"));
  }
}
