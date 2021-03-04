import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kopli/colorTheme.dart';

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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    void _mouseEnter(PointerEvent details) {
      setState(() {
        //leftColor = ColorTheme.mainGreen;
        isShow = 1.0;
      });
    }

    void _mouseExit(PointerEvent details) {
      setState(() {
        //leftColor = ColorTheme.background;
        isShow = 0.0;
      });
    }

    return Scaffold(
      appBar: (width / height > 1)
          ? null
          : AppBar(
              title: Text(widget.title),
            ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MouseRegion(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Opacity(
                                opacity: isShow,
                                child: IconButton(
                                  icon: Icon(FontAwesomeIcons.listUl),
                                  iconSize: 14,
                                  color: ColorTheme.greylighter,
                                  onPressed: () {},
                                ),
                              ),
                              Text("文档"),
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
                        color: ColorTheme.cantaloupe,
                        child: Text("data"),
                      ),
                      Opacity(
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
                    ],
                  ),
                )),
            Container(width: width - 270, color: ColorTheme.mainRed),
          ],
        ),
      ),
    );
  }
}
