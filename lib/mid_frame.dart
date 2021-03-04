import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MidFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 100,
              minLines: 1,
              decoration: const InputDecoration(
                hintText: '输入',
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                isDense: true,
                // border: const OutlineInputBorder(
                //   gapPadding: 0,
                //   borderRadius: const BorderRadius.all(Radius.circular(4)),
                //   borderSide: BorderSide(
                //     width: 1,
                //     style: BorderStyle.none,
                //   ),
                // ),
              )))
    ]);
  }
}
