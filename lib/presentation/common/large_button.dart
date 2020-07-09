import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  final Color backgroundColor;
  final Function onPressed;
  final String name;

  const LargeButton({
    Key key,
    @required this.backgroundColor,
    @required this.onPressed,
    @required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: RawMaterialButton(
        fillColor: backgroundColor,
        onPressed: onPressed,
        child: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
