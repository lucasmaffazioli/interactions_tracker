import 'package:cold_app/core/app_localizations.dart';
import 'package:cold_app/presentation/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:cold_app/locator.dart';
import 'package:flutter/material.dart';

import 'presentation/common/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // USE_TEST_IMPLEMENTATION = false;

    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('pt', ''), // PT
        // ... other locales the app supports
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        // print('language ' + locale.toString());
        // print('languages ' + supportedLocales.toString());
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode
              //  && supportedLocale.countryCode == locale.countryCode
              ) {
            return supportedLocale;
          }
        }
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
          trackShape: _CustomTrackShape(),
        ),
      ),
      home: HomePage(),
    );
  }
}

class _CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx + 15;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 35;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
