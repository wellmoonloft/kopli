import 'package:kopli/pages/home/desktopHome.dart';
import 'package:kopli/pages/home/mobileHome.dart';
import 'package:kopli/utils/fileActions.dart';
import 'package:kopli/utils/getPlatform.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FileActions _fileActions = FileActions();

  @override
  void initState() {
    super.initState();

    _fileActions.initFiles(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetPlatform().getIsMobile() ? DesktopHome() : MobileHome();
  }
}
