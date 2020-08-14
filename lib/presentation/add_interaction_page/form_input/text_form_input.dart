import 'package:flutter/material.dart';

import 'base_form_input.dart';

class TextFormInput extends StatelessWidget {
  final String title;
  final String initialValue;
  final Function onSave;
  final Function validator;
  final int maxLines;
  final int minLines;
  final TextInputType textInputType;
  final bool enabled;

  const TextFormInput({
    Key key,
    @required this.title,
    @required this.onSave,
    this.initialValue,
    this.validator,
    this.maxLines,
    this.minLines,
    this.textInputType,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseFormInput(
      title: title,
      child: TextFormField(
        keyboardType: textInputType,
        initialValue: initialValue,
        minLines: minLines,
        maxLines: maxLines,
        validator: validator,
        decoration: enabled ? myInputDecoration() : myDisabledInputDecoration(),
        onSaved: (String value) {
          if (onSave != null) onSave(value.trim());
        },
        enabled: enabled,
      ),
    );
  }
}
