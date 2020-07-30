import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  final List<Line> lines;
  final List<ChartPositionTitle> chartBottomTitle;
  final List<ChartPositionTitle> chartLeftTitle;

  const LineChartSample2({
    Key key,
    @required this.lines,
    @required this.chartBottomTitle,
    @required this.chartLeftTitle,
  }) : super(key: key);

  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class Line {
  final List<FlSpot> spots;
  final Color color;

  Line({@required this.spots, @required this.color});
}

class ChartPositionTitle {
  final String title;
  final int value;

  ChartPositionTitle({
    @required this.title,
    @required this.value,
  });
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 0.9,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color(0xff232d37)),
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0, left: 2.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    List<LineChartBarData> lineBarsData = [];

    widget.lines.forEach((element) {
      lineBarsData.add(
        LineChartBarData(
          spots: element.spots,
          isCurved: false,
          colors: [element.color.withOpacity(0.5)],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),

          // belowBarData: BarAreaData(
          //   show: true,
          //   colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          // ),
        ),
      );
    });

    return LineChartData(
      lineTouchData: LineTouchData(
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueAccent,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;
              return LineTooltipItem(
                'Week ${flSpot.x.toInt().toString()} \n${flSpot.y.toInt()}',
                const TextStyle(color: Colors.white),
              );
            }).toList();
          },
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle:
              const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            String title = '';
            widget.chartBottomTitle.forEach((element) {
              if (value == element.value) {
                title = element.title;
              }
            });
            return title;
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            String title = '';
            widget.chartLeftTitle.forEach((element) {
              if (value == element.value) {
                title = element.title;
              }
            });
            return title;
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
          FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 30,
      minY: 0,
      maxY: 10,
      lineBarsData: lineBarsData,
    );
  }
}
