import 'package:cold_app/presentation/common/constants.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final Color color;
  final String text;

  const Label({
    Key key,
    @required this.color,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: Row(
            children: <Widget>[
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: color.withAlpha(200),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    color: Constants.borderColor,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(text),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Constants.borderColor,
          ),
        ),
      ),
    );
  }
}
