import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kopli/colorTheme.dart';
import 'package:kopli/left_frame.dart';
import 'package:kopli/mid_frame.dart';
import 'package:kopli/right_frame.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kopli',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color leftColor = ColorTheme.background;
  double isShow = 0.0;
  bool isList = false;
  Icon isListIcon = Icon(FontAwesomeIcons.listUl);
  String leftTitle = "文档";
  String neirong = "";
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        neirong = _controller.text;
      });

      //print(currentStr);
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

    void _mouseEnter(PointerEvent details) {
      setState(() {
        isShow = 1.0;
      });
    }

    void _mouseExit(PointerEvent details) {
      setState(() {
        isShow = 0.0;
      });
    }

    return Scaffold(
        appBar: (width / height > 1)
            ? null
            : AppBar(
                title: Text(widget.title),
              ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (width / height > 1)
                ? MouseRegion(
                    onEnter: _mouseEnter,
                    onExit: _mouseExit,
                    child: Container(
                      width: 270,
                      color: leftColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Opacity(
                                    opacity: isShow,
                                    child: IconButton(
                                      icon: isListIcon,
                                      iconSize: 14,
                                      color: ColorTheme.greylighter,
                                      onPressed: () {
                                        if (isList) {
                                          setState(() {
                                            isListIcon =
                                                Icon(FontAwesomeIcons.listUl);
                                            isList = false;
                                            leftTitle = "文档";
                                          });
                                        } else {
                                          setState(() {
                                            isListIcon =
                                                Icon(FontAwesomeIcons.stream);
                                            isList = true;
                                            leftTitle = "大纲";
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  Text(leftTitle),
                                  Opacity(
                                    opacity: isShow,
                                    child: IconButton(
                                      icon: Icon(FontAwesomeIcons.search),
                                      iconSize: 14,
                                      color: ColorTheme.greylighter,
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                            height: height - 100,
                            child: LeftFrame(isList: isList),
                          ),
                          isList
                              ? Opacity(
                                  opacity: isShow,
                                  child: Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: ColorTheme.greylighter,
                                                width: 0.3)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(),
                                          Text(
                                            "打开文件夹...",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: ColorTheme.greylighter),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              FontAwesomeIcons.ellipsisV,
                                              color: ColorTheme.greylighter,
                                            ),
                                            iconSize: 12,
                                            onPressed: () {},
                                          )
                                        ],
                                      )))
                              : Container()
                        ],
                      ),
                    ))
                : Container(),
            Container(
              width: (width / height > 1) ? (width - 270) / 2 : 0,
              height: height,
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.multiline,
                maxLines: 100,
                minLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              width: (width / height > 1) ? (width - 270) / 2 : width,
              color: ColorTheme.mainRed,
              child: Markdown(data: neirong),
            )
          ],
        ));
  }
}
