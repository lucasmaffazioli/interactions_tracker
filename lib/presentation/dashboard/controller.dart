import 'package:flutter/foundation.dart';
import '../../domain/usecases/dashboard_usecases.dart';

class DashBoardPageController {
  Future<SimpleGraphsData> getApproachesSimpleData() async {
    // SimpleGraphsData simpleGraph = await GetApproachesSimpleGraphsData().call();
    // print('-------------------------simpleGraph');
    // print(simpleGraph.monthTotalApproaches);
    // print(simpleGraph.weekApproaches.sunday);
    // print(simpleGraph.weekApproaches.saturday);
    // print(simpleGraph.weekGoal);
    // print(simpleGraph.dayGoal);
    return await GetApproachesSimpleGraphsData().call();
  }

  Future<MyLineChartData> getDashboardLineData() async {
    print('getDashboardLineData');
    MyLineChartData lineChart = await GetGraphLinesData().call();
    print('getDashboardLineData ENNNND');

    // lineChart.lines.forEach((element) {
    // print('element.pointId');
    // print(element.pointId);
    // element.pointData.forEach((e) {
    // print('e.approachName');
    // print(e.approachName);
    // print(e.position);
    // });
    // });
    // print

    // List<WeekComplexData> weeks = await GetApproachesComplexGraphsData().call();
    // List<int> approachesByWeekDay = [];

    // print('foreach');
    // weeks.forEach((element) {
    //   print(element.dashboardData);
    // });
    return lineChart;
  }
}

class TotalApproachesPresenter {
  final int sunday;
  final int monday;
  final int tuesday;
  final int wednesday;
  final int thursday;
  final int friday;
  final int saturday;

  final int currentDay;
  final int currentWeek;
  final int currentMonth;
  final int currentDayTotal;
  final int currentWeekTotal;
  final int currentMonthTotal;

  TotalApproachesPresenter({
    @required this.sunday,
    @required this.monday,
    @required this.tuesday,
    @required this.wednesday,
    @required this.thursday,
    @required this.friday,
    @required this.saturday,
    @required this.currentDay,
    @required this.currentWeek,
    @required this.currentMonth,
    @required this.currentDayTotal,
    @required this.currentWeekTotal,
    @required this.currentMonthTotal,
  });
}
