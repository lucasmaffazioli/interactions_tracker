import 'package:cold_app/presentation/approaches_page.dart';
import 'package:cold_app/presentation/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Noto Sans',
        scaffoldBackgroundColor: Constants.background,
        // primaryColor: Constants.background,
      ),
      home: HomePage(),
    );
  }
}
