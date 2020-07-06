import 'package:cold_app/core/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:cold_app/locator.dart';
import 'package:flutter/material.dart';

import 'presentation/approaches_page/approaches_page.dart';
import 'presentation/common/constants.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    USE_TEST_IMPLEMENTATION = false;

    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('pt', ''), // Hebrew, no country code
        // ... other locales the app supports
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
      //
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.borderRadiusCards)),
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: Constants.accent2,
          inactiveTrackColor: Constants.accent2.withOpacity(0.2),
          // trackShape: RectangularSliderTrackShape(),
          trackHeight: 4,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
          thumbColor: Constants.accent2,
          overlayColor: Constants.accent2.withOpacity(0.4),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
          activeTickMarkColor: Constants.accent2,
          inactiveTickMarkColor: Constants.accent2.withOpacity(0.2),
          overlappingShapeStrokeColor: Colors.red,
        ),
      ),
      home: HomePage(),
    );
  }
}
