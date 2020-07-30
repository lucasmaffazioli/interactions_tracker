import 'package:cold_app/data/models/approach/approach_model.dart';
import 'package:cold_app/data/models/approach/dashboard.dart';
import 'package:cold_app/data/models/approach/goals_model.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';
import 'package:cold_app/domain/entities/approach/approach_entity.dart';
import 'package:cold_app/domain/usecases/approach_usecases.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:cold_app/core/extensions/date_time_extension.dart';

ApproachFloorGateway approachGateway = ApproachFloorGateway();
GoalsModelFloorGateway goalsGateway = GoalsModelFloorGateway();

class GetApproachesSimpleGraphsData {
  Future<SimpleGraphsData> call() async {
    SimpleGraphsData simpleData = SimpleGraphsData();
    final DateTime dateTimeNow = DateTime.now();
    DateTime dateProcessing = dateTimeNow;
    int dayApproaches;

    int i = 0;

    simpleData.monthTotalApproaches = await approachGateway.findApproachesCountByDateInterval(
        dateTimeNow.add(Duration(days: -30)).initialDayMoment(), dateTimeNow.finalDayMoment());
    simpleData.dayTotalApproaches = await approachGateway.findApproachesCountByDateInterval(
        dateTimeNow.initialDayMoment(), dateTimeNow.finalDayMoment());
    final GoalsModel goal = await goalsGateway.findGoalsModel();
    simpleData.weekGoal = goal.weeklyApproachGoal;
    simpleData.dayGoal = goal.weeklyApproachGoal ~/ 7;
    simpleData.monthGoal = goal.weeklyApproachGoal * 4;

    simpleData.currentWeekDay = dateProcessing.weekday;

    do {
      // print('dateProcessing.weekday');
      // print(dateProcessing.weekday);
      // print(dateProcessing.toIso8601String());
      switch (dateProcessing.weekday) {
        case DateTime.sunday:
          {
            dayApproaches = await approachGateway.findApproachesCountByDateInterval(
                dateProcessing.initialDayMoment(), dateProcessing.finalDayMoment());
            simpleData.sunday = dayApproaches ?? 0;
          }
          break;
        case DateTime.monday:
          {
            dayApproaches = await approachGateway.findApproachesCountByDateInterval(
                dateProcessing.initialDayMoment(), dateProcessing.finalDayMoment());
            simpleData.monday = dayApproaches ?? 0;
          }
          break;
        case DateTime.tuesday:
          {
            dayApproaches = await approachGateway.findApproachesCountByDateInterval(
                dateProcessing.initialDayMoment(), dateProcessing.finalDayMoment());
            simpleData.tuesday = dayApproaches ?? 0;
          }
          break;
        case DateTime.wednesday:
          {
            dayApproaches = await approachGateway.findApproachesCountByDateInterval(
                dateProcessing.initialDayMoment(), dateProcessing.finalDayMoment());
            simpleData.wednesday = dayApproaches ?? 0;
          }
          break;
        case DateTime.thursday:
          {
            dayApproaches = await approachGateway.findApproachesCountByDateInterval(
                dateProcessing.initialDayMoment(), dateProcessing.finalDayMoment());
            simpleData.thursday = dayApproaches ?? 0;
          }
          break;
        case DateTime.friday:
          {
            dayApproaches = await approachGateway.findApproachesCountByDateInterval(
                dateProcessing.initialDayMoment(), dateProcessing.finalDayMoment());
            simpleData.friday = dayApproaches ?? 0;
          }
          break;
        case DateTime.saturday:
          {
            dayApproaches = await approachGateway.findApproachesCountByDateInterval(
                dateProcessing.initialDayMoment(), dateProcessing.finalDayMoment());
            simpleData.saturday = dayApproaches ?? 0;
          }
          break;
      }
      simpleData.weekTotalApproaches += dayApproaches ?? 0;
      if (dayApproaches > simpleData.maxApproachesDay) simpleData.maxApproachesDay = dayApproaches;
      //
      i++;
      dateProcessing =
          DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day).add(Duration(days: -i));

      print(i);
    } while (i <= 6);

    return simpleData;
  }
}

class SimpleGraphsData {
  int dayTotalApproaches;
  int weekTotalApproaches;
  int monthTotalApproaches;
  int dayGoal;
  int weekGoal;
  int monthGoal;
  int sunday;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;
  int saturday;
  int currentWeekDay;
  int maxApproachesDay;
  SimpleGraphsData({
    this.dayTotalApproaches = 0,
    this.weekTotalApproaches = 0,
    this.monthTotalApproaches = 0,
    this.dayGoal = 0,
    this.weekGoal = 0,
    this.monthGoal = 0,
    this.sunday = 0,
    this.monday = 0,
    this.tuesday = 0,
    this.wednesday = 0,
    this.thursday = 0,
    this.friday = 0,
    this.saturday = 0,
    this.currentWeekDay = 0,
    this.maxApproachesDay = 0,
  });
}

// class GetApproachesComplexGraphsData {
//   Future<ComplexData> call() async {
//     ComplexData complexData;
//     DateTime dateTimeNow = DateTime.now();
//     int weekNumber = 0;
//     int firstWeek = 9999;
//     int finalWeek;
//     int i = 0;

//     do {
//       DateTime dateProcessing =
//           DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day).add(Duration(days: -i));
//       weekNumber = _weekNumber(dateProcessing);
//       if (firstWeek > weekNumber) firstWeek = weekNumber;
//       if (finalWeek == null) finalWeek = weekNumber;
//       //
//       _calc(dateProcessing, weekNumber, complexData);
//       i++;
//     } while (finalWeek - firstWeek <= 11);
//     complexData.removeLast();

//     ///
//     /// Processamento de datas
//     ///
//     ///
//     for (int i = 0; i < complexData.length; i++) {
//       final week = complexData[i];
//       complexData[i].dashboardData =
//           await approachGateway.findDashboardDataByDateInterval(week.initialDate, week.finalDate);
//     }
//     print('***************  Complex dashboard data');

//     complexData.forEach((element) {
//       element.dashboardData.forEach((e) {
//         print('e.toJson()');
//         print(e.toJson());
//       });
//     });

//     return complexData;
//   }
// }

class GetGraphLinesData {
  Future<MyLineChartData> call() async {
    MyLineChartData lineChart = MyLineChartData();
    List<ApproachModel> approachesModel = await approachGateway.getLast30Approaches();

    int x = 30;
    for (final approachModel in approachesModel) {
      ApproachEntity approach = await GetApproach().call(approachModel.id);

      for (final point in approach.points) {
        lineChart.feedPoint(approach.id, approach.name, point.id, point.name, point.value, x);
      }
      x--;
    }

    return lineChart;
  }
}

class MyLineChartData {
  List<LineData> lines = [];

  MyLineChartData();

  void feedPoint(
    int approachId,
    String approachName,
    int pointId,
    String pointName,
    int pointValue,
    int x,
  ) {
    int selectedLineIndex = lines.indexWhere((element) => element.pointId == pointId);
    if (selectedLineIndex == -1) {
      lines.add(LineData(pointId: pointId, pointName: pointName));
      selectedLineIndex = lines.indexWhere((element) => element.pointId == pointId);
    }

    lines[selectedLineIndex].pointData.add(PointData(
          approachId: approachId,
          approachName: approachName,
          position: x,
          value: pointValue,
        ));

    // for (int i; i <= lines.length; i++) {
    // }
  }
}

class LineData {
  final int pointId;
  final String pointName;
  List<PointData> pointData = [];

  LineData({@required this.pointId, @required this.pointName});
}

class PointData {
  final int approachId;
  final String approachName;
  final int position;
  final int value;

  PointData(
      {@required this.approachId,
      @required this.approachName,
      @required this.position,
      @required this.value});
}

// class WeekComplexData {
//   int weekNumber;
//   DateTime initialDate;
//   DateTime finalDate;
//   List<DashboardComplexModel> dashboardData;

//   WeekComplexData(this.weekNumber, this.initialDate, this.finalDate, {this.dashboardData});
// }
