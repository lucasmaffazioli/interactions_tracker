import 'package:cold_app/presentation/common/constants.dart';
import 'package:cold_app/presentation/dashboard/components/neumorphic_pie/neumorphic_pie.dart';
import 'package:flutter/material.dart';

class PieValue {
  final int totalValue;
  final int currentValue;

  PieValue({@required this.totalValue, @required this.currentValue});
}

class ModernPies extends StatelessWidget {
  final PieValue leftPieValue;
  final PieValue rightPieValue;
  final PieValue centerPieValue;

  const ModernPies({
    Key key,
    @required this.leftPieValue,
    @required this.rightPieValue,
    @required this.centerPieValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 70,
            left: 15,
            child: NeumorphicPie(
              size: 110,
              color: Constants.accent2,
              totalValue: leftPieValue.totalValue.toDouble(),
              currentValue: leftPieValue.currentValue.toDouble(),
            ),
          ),
          Positioned(
            top: 70,
            right: 35,
            child: NeumorphicPie(
              size: 90,
              color: Constants.accent3,
              totalValue: rightPieValue.totalValue.toDouble(),
              currentValue: rightPieValue.currentValue.toDouble(),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: NeumorphicPie(
              size: 140,
              color: Constants.accent,
              totalValue: centerPieValue.totalValue.toDouble(),
              currentValue: centerPieValue.currentValue.toDouble(),
            ),
          ),
        ],
      ),
    );
  }
}
