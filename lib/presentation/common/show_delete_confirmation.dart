import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:flutter/material.dart';

Future<dynamic> showConfirmationPopup(BuildContext context,
    {@required String text,
    @required String buttonConfirmText,
    @required String buttonCancelText,
    @required Function onConfirm}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(text),
        actions: <Widget>[
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(buttonCancelText),
          ),
          MaterialButton(
            onPressed: () => Navigator.of(context).pop('Confirmed'),
            child: Text(
              buttonConfirmText,
              style: TextStyle(
                color: Constants.red,
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> showDeleteConfirmationPopup(BuildContext context, {Function onConfirm}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Warning! Are you sure you want to delete this? It can't be undone".i18n),
        actions: <Widget>[
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'.i18n),
          ),
          MaterialButton(
            onPressed: onConfirm,
            child: Text(
              'Delete'.i18n,
              style: TextStyle(
                color: Constants.red,
              ),
            ),
          ),
        ],
      );
    },
  );
}
