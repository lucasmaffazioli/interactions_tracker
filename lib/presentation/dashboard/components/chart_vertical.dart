import 'dart:async';

import 'package:cold_app/presentation/common/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartVertical extends StatefulWidget {
  final List<ChartLineData> listData;

  const ChartVertical(this.listData, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChartVerticalState();
}

class ChartLineData {
  final String title;
  final String dayOfWeek;
  final int value;
  final bool isCurrent;

  ChartLineData({
    @required this.title,
    @required this.dayOfWeek,
    @required this.value,
    this.isCurrent = false,
  });
}

class ChartVerticalState extends State<ChartVertical> {
  final Color barBackgroundColor = Constants.chartLineBackground;
  final Duration animDuration = const Duration(milliseconds: 250);
  double maxY;

  int touchedIndex;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    final _listDataMaxY = widget.listData;
    _listDataMaxY.sort((a, b) => a.value.compareTo(b.value));
    maxY = _listDataMaxY.last.value.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'Mingguan',
                    style: TextStyle(
                        color: const Color(0xff0f4a3c), fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Grafik konsumsi kalori',
                    style: TextStyle(
                        color: const Color(0xff379982), fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isCurrent = false,
    bool isTouched = false,
    Color barColor = Constants.accent2,
    double width = 10,
    List<int> showTooltips = const [],
  }) {
    Color color = barColor;
    if (isCurrent) color = Constants.accent3;
    if (isTouched) color = Colors.red;

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          color: color,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: maxY,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() {
    List<BarChartGroupData> returnList = [];
    int _count = 0;
    //
    widget.listData.forEach((element) {
      print('element.value.toString()');
      print(element.isCurrent.toString());
      returnList.add(
        makeGroupData(
          _count,
          element.value.toDouble(),
          isCurrent: element.isCurrent,
          isTouched: _count == touchedIndex,
        ),
      );
      _count++;
    });
    return returnList;
  }

  // List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
  //   switch (i) {
  //     case 0:
  //       return makeGroupData(0, 5, isTouched: i == touchedIndex);
  //     case 1:
  //       return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
  //     case 2:
  //       return makeGroupData(2, 5, isTouched: i == touchedIndex);
  //     case 3:
  //       return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
  //     case 4:
  //       return makeGroupData(4, 9, isTouched: i == touchedIndex);
  //     case 5:
  //       return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
  //     case 6:
  //       return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
  //     default:
  //       return null;
  //   }
  // });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchExtraThreshold: EdgeInsets.all(14),
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.red,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                widget.listData[group.x.toInt()].dayOfWeek + '\n' + (rod.y).toString(),
                TextStyle(color: Colors.white, fontSize: 14),
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
            margin: 16,
            getTitles: (double value) {
              return widget.listData[value.toInt()].dayOfWeek.substring(0, 1);
            },
          ),
          rightTitles: SideTitles(showTitles: true),
          leftTitles: SideTitles(
            showTitles: true,
          ),
          topTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 140),
            margin: 1,
            getTitles: (double value) {
              print('value');
              print(value);
              switch (value.toInt()) {
                case 0:
                  return 'M';
                case 1:
                  return 'T';
                case 2:
                  return 'W';
                case 3:
                  return 'T';
                case 4:
                  return 'F';
                case 5:
                  return 'S';
                case 6:
                  return 'S';
                default:
                  return '';
              }
            },
          )),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      refreshState();
    }
  }
}
