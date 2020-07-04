import 'package:flutter/material.dart';

class BaseFormInput extends StatelessWidget {
  final String title;
  final Widget child;

  const BaseFormInput({Key key, this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        child,
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

InputDecoration myInputDecoration() {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(4),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(4),
    ),
  );
}
