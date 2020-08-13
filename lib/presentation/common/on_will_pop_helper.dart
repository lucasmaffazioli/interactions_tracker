import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/presentation/common/show_delete_confirmation.dart';
import 'package:flutter/material.dart';

Future<bool> onWillPop(BuildContext context, wasModified) async {
  if (wasModified) {
    await showConfirmationPopup(
      context,
      text: 'You have unsaved changes, do you really want to exit?'.i18n,
      buttonConfirmText: 'Yes'.i18n,
      buttonCancelText: 'Cancel'.i18n,
      onConfirm: () => Navigator.of(context).pop(true),
    ).then((value) {
      if (value.toString() == 'Confirmed') {
        Navigator.of(context).pop(true);
      }
    });
  } else {
    Navigator.pop(context, true);
  }

  // return true;
}
