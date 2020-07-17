import 'dart:math';
import 'dart:ui';

import 'package:cold_app/core/app_localizations.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:cold_app/presentation/dashboard/components/neumorphic_pie/middle_ring.dart';
import 'package:cold_app/presentation/dashboard/components/neumorphic_pie/progress_rings.dart';
import 'package:flutter/material.dart';

class NeumorphicPie extends StatelessWidget {
  final double size;
  final Color color;
  final double totalValue;
  final double currentValue;

  const NeumorphicPie(
      {Key key,
      @required this.size,
      @required this.color,
      @required this.totalValue,
      @required this.currentValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backGradient = [color, color];
    final frontGradient = [Colors.white.withAlpha(60), Colors.white.withAlpha(60)];

    // totalValue = 100
    // currentValue = ?

    double percentage = ((currentValue * 100) / totalValue) * 0.01;
    print('percentage');
    print(percentage);

    // Outer white circle
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white24, boxShadow: [
        Constants.boxShadow,
      ]),
      child: Center(
        // Container of the pie chart
        child: Container(
          height: size * 0.8,
          width: size * 0.8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              // Constants.boxShadow,
              // BoxShadow(
              //   color: Colors.grey.withOpacity(0.8),
              //   spreadRadius: 14,
              //   blurRadius: 20,
              //   offset: Offset(0, 7), // changes position of shadow
              // ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              Transform.rotate(
                angle: pi * 1.8,
                child: CustomPaint(
                  child: Center(),
                  painter: ProgressRings(
                    completedPercentage: 1,
                    circleWidth: size * 0.25,
                    gradient: backGradient,
                    // gradientStartAngle: 0.0,
                    // gradientEndAngle: pi / 3,
                    // progressStartAngle: 1.85,
                    // lengthToRemove: 3,
                  ),
                ),
              ),
              Transform.rotate(
                // angle: pi / 1.4,
                angle: pi,
                child: CustomPaint(
                  child: Center(),
                  painter: ProgressRings(
                    completedPercentage: percentage,
                    circleWidth: size * 0.25,
                    gradient: frontGradient,
                  ),
                ),
              ),
              Center(
                child: MiddleRing(
                  width: size * 0.55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        currentValue.toInt().toString(),
                        style: TextStyle(fontSize: size * 0.3, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        AppLocalizations.of(context).translate('of') +
                            ' ' +
                            totalValue.toInt().toString(),
                        style: TextStyle(fontSize: size * 0.1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final innerColor = Color.fromRGBO(233, 242, 249, 1);
final shadowColor = Color.fromRGBO(220, 227, 234, 1);

const redGradient = [
  Color.fromRGBO(255, 93, 91, 1),
  Color.fromRGBO(254, 154, 92, 1),
];
const orangeGradient = [
  Color.fromRGBO(251, 173, 86, 1),
  Color.fromRGBO(253, 255, 93, 1),
];
