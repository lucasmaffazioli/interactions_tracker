import 'package:flutter/material.dart';

import 'base_form_input.dart';

class TextFormInput extends StatelessWidget {
  final String title;
  final String initialValue;
  final Function onSave;
  final Function validator;
  final int maxLines;
  final int minLines;

  const TextFormInput({
    Key key,
    @required this.title,
    @required this.onSave,
    this.initialValue,
    this.validator,
    this.maxLines,
    this.minLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseFormInput(
      title: title,
      child: TextFormField(
        initialValue: initialValue,
        minLines: minLines,
        maxLines: maxLines,
        validator: validator,
        decoration: myInputDecoration(),
        onSaved: ((String value) {
          onSave(value.trim());
        }),
      ),
    );
  }
}
