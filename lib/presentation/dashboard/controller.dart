import 'package:flutter/foundation.dart';
import '../../domain/usecases/dashboard_usecases.dart';

class DashBoardPageController {
  Future<SimpleGraphsData> getInteractionsSimpleData() async {
    // SimpleGraphsData simpleGraph = await GetInteractionsSimpleGraphsData().call();
    // print('-------------------------simpleGraph');
    // print(simpleGraph.monthTotalInteractions);
    // print(simpleGraph.weekInteractions.sunday);
    // print(simpleGraph.weekInteractions.saturday);
    // print(simpleGraph.weekGoal);
    // print(simpleGraph.dayGoal);
    return await GetInteractionsSimpleGraphsData().call();
  }

  Future<MyLineChartData> getDashboardLineData() async {
    print('getDashboardLineData');
    MyLineChartData lineChart = await GetGraphLinesData().call();
    print('getDashboardLineData ENNNND');

    // lineChart.lines.forEach((element) {
    // print('element.pointId');
    // print(element.pointId);
    // element.pointData.forEach((e) {
    // print('e.interactionName');
    // print(e.interactionName);
    // print(e.position);
    // });
    // });
    // print

    // List<WeekComplexData> weeks = await GetInteractionsComplexGraphsData().call();
    // List<int> interactionsByWeekDay = [];

    // print('foreach');
    // weeks.forEach((element) {
    //   print(element.dashboardData);
    // });
    return lineChart;
  }
}

class TotalInteractionsPresenter {
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

  TotalInteractionsPresenter({
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
