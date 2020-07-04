import 'package:flutter/material.dart';

import 'presentation/approaches_page/approaches_page.dart';
import 'presentation/common/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          buttonTheme: ButtonThemeData(),
          iconTheme: IconThemeData(
            color: Constants.accent,
          ),
          // accentColor: Constants.accent,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Constants.accent,
          ),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Noto Sans',
          scaffoldBackgroundColor: Constants.background,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Constants.mainTextColor,
                displayColor: Colors.blue,
              ),
          cardTheme: CardTheme(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          )

          // primaryColor: Constants.background,
          ),
      home: HomePage(),
    );
  }
}
