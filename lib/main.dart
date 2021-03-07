import 'package:flutter/material.dart';
import 'package:kopli/homePage.dart';
import 'package:kopli/utils/providerData.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProviderData(),
        child: MaterialApp(
          title: 'Kopli',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(),
        ));
  }
}
