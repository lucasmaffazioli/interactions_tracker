import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: const CircularProgressIndicator(
              backgroundColor: Constants.accent2,
              // strokeWidth: 10,
            ),
            width: 60,
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text('Loading...'.i18n),
          )
        ],
      ),
    );
  }
}
