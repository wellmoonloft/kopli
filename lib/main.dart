import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kopli/homePage.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:provider/provider.dart';

void main() {
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    print('桌面系统');
  } else if (Platform.isAndroid || Platform.isIOS) {
    print('移动系统');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProviderData(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Kopli',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(),
        ));
  }
}
