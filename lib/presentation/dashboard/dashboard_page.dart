import 'package:cold_app/domain/usecases/dashboard_usecases.dart';
import 'package:cold_app/presentation/common/loading.dart';
import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:cold_app/presentation/dashboard/components/chart_vertical.dart';
import 'package:cold_app/presentation/dashboard/components/label.dart';
import 'package:cold_app/presentation/dashboard/components/line_chart.dart';
import 'package:cold_app/presentation/dashboard/components/modern_pies.dart';
import 'package:cold_app/presentation/dashboard/controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashBoardPageController controller = DashBoardPageController();

  SimpleGraphsData simpleGraphsData = SimpleGraphsData();
  // List<ComplexGraphsData> complexGraphsData = ComplexGraphsData();

  @override
  Widget build(BuildContext context) {
    Future<SimpleGraphsData> simpleGraphsDataFuture = controller.getApproachesSimpleData();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: simpleGraphsDataFuture,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      simpleGraphsData = snapshot.data;
                    } else {
                      simpleGraphsData = SimpleGraphsData();
                    }
                    return Column(
                      children: <Widget>[
                        ChartVertical(
                          maxY: simpleGraphsData.maxApproachesDay.toDouble(),
                          title: 'Week'.i18n,
                          listData: <ChartLineData>[
                            ChartLineData(
                              bottomTitle: 'Sunday'.i18n,
                              topTitle: simpleGraphsData.sunday.toString(),
                              value: simpleGraphsData.sunday,
                              isCurrent: simpleGraphsData.currentWeekDay == 7,
                            ),
                            ChartLineData(
                              bottomTitle: 'Monday'.i18n,
                              topTitle: simpleGraphsData.monday.toString(),
                              value: simpleGraphsData.monday,
                              isCurrent: simpleGraphsData.currentWeekDay == 1,
                            ),
                            ChartLineData(
                              bottomTitle: 'Tuesday'.i18n,
                              topTitle: simpleGraphsData.tuesday.toString(),
                              value: simpleGraphsData.tuesday,
                              isCurrent: simpleGraphsData.currentWeekDay == 2,
                            ),
                            ChartLineData(
                              bottomTitle: 'Wednesday'.i18n,
                              topTitle: simpleGraphsData.wednesday.toString(),
                              value: simpleGraphsData.wednesday,
                              isCurrent: simpleGraphsData.currentWeekDay == 3,
                            ),
                            ChartLineData(
                              bottomTitle: 'Thursday'.i18n,
                              topTitle: simpleGraphsData.thursday.toString(),
                              value: simpleGraphsData.thursday,
                              isCurrent: simpleGraphsData.currentWeekDay == 4,
                            ),
                            ChartLineData(
                              bottomTitle: 'Friday'.i18n,
                              topTitle: simpleGraphsData.friday.toString(),
                              value: simpleGraphsData.friday,
                              isCurrent: simpleGraphsData.currentWeekDay == 5,
                            ),
                            ChartLineData(
                              bottomTitle: 'Saturday'.i18n,
                              topTitle: simpleGraphsData.saturday.toString(),
                              value: simpleGraphsData.saturday,
                              isCurrent: simpleGraphsData.currentWeekDay == 6,
                            ),
                          ],
                        ),
                        ModernPies(
                          centerPieValue: PieValue(
                              totalValue: simpleGraphsData.monthGoal,
                              currentValue: simpleGraphsData.monthTotalApproaches),
                          leftPieValue: PieValue(
                              totalValue: simpleGraphsData.weekGoal,
                              currentValue: simpleGraphsData.weekTotalApproaches),
                          rightPieValue: PieValue(
                              totalValue: simpleGraphsData.dayGoal,
                              currentValue: simpleGraphsData.dayTotalApproaches),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Label(
                              color: Constants.accent2,
                              text: 'Week'.i18n,
                            ),
                            Label(
                              color: Constants.accent,
                              text: 'Month'.i18n,
                            ),
                            Label(
                              color: Constants.accent3,
                              text: 'Day'.i18n,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Analysis'.i18n,
                  style: Constants.textH1,
                ),
              ),
            ),
            ComplexGraph(),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}

class ComplexGraph extends StatelessWidget {
  final DashBoardPageController controller = DashBoardPageController();
  MyLineChartData myLineChartData;

  List<Line> _getLine(List<LineData> listLineData) {
    List<Line> listLines = [];
    Line line;
    List<FlSpot> flSpots = [];
    listLines.add(
      Line(
        color: Colors.red,
        spots: <FlSpot>[
          FlSpot(0, 3),
          FlSpot(2, 5),
          FlSpot(3, 2),
          FlSpot(4, 5),
          FlSpot(5, 3.1),
          FlSpot(6, 4),
          FlSpot(7, 3),
          FlSpot(8, 2),
          FlSpot(9, 2),
          FlSpot(10, 2),
          FlSpot(11, 2),
          FlSpot(12, 2),
        ],
      ),
    );

    listLineData.forEach((element) {
      element.pointData.forEach((e) {
        flSpots.add(FlSpot(e.position.toDouble(), e.value.toDouble()));
      });
      // line = Line(color: Colors.blue, spots: flSpots);
      listLines.add(Line(color: Colors.blue, spots: flSpots));
    });

    return listLines;
  }

  @override
  Widget build(BuildContext context) {
    Future<MyLineChartData> lineChart = controller.getDashboardLineData();

    return FutureBuilder(
      future: lineChart,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          print('snapshot.error');
          print(snapshot.error);
          return Text(snapshot.error.toString());
          // SnackBarHelper.createError(message: snapshot.error.toString()).show(context);
        } else if (snapshot.hasData) {
          myLineChartData = snapshot.data;

          print('snapshot.data');
          print(snapshot.data);
          return LineChartSample2(
            chartBottomTitle: <ChartPositionTitle>[
              ChartPositionTitle(title: 'FEV', value: 0),
              ChartPositionTitle(title: 'MAR', value: 5),
              ChartPositionTitle(title: 'APR', value: 9),
            ],
            chartLeftTitle: <ChartPositionTitle>[
              ChartPositionTitle(title: '0', value: 0),
              ChartPositionTitle(title: '1', value: 1),
              ChartPositionTitle(title: '2', value: 2),
              ChartPositionTitle(title: '3', value: 3),
              ChartPositionTitle(title: '4', value: 4),
              ChartPositionTitle(title: '5', value: 5),
              ChartPositionTitle(title: '6', value: 6),
            ],
            lines: _getLine(myLineChartData.lines),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
