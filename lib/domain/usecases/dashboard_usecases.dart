import 'package:cold_app/data/models/interaction/interaction_model.dart';
import 'package:cold_app/data/models/interaction/goals_model.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';
import 'package:cold_app/domain/entities/interaction/interaction_entity.dart';
import 'package:cold_app/domain/usecases/interaction_usecases.dart';
import 'package:flutter/foundation.dart';
import 'package:cold_app/core/extensions/date_time_extension.dart';

InteractionFloorGateway interactionGateway = InteractionFloorGateway();
GoalsModelFloorGateway goalsGateway = GoalsModelFloorGateway();

class GetInteractionsSimpleGraphsData {
  Future<SimpleGraphsData> call() async {
    SimpleGraphsData simpleData = SimpleGraphsData();
    final DateTime dateTimeNow = DateTime.now();
    DateTime dateProcessing = dateTimeNow;
    int dayInteractions;

    int i = 0;

    simpleData.monthTotalInteractions =
        await interactionGateway.findInteractionsCountByDateInterval(
            dateTimeNow.add(Duration(days: -30)).initialDayMoment(), dateTimeNow.finalDayMoment());
    simpleData.dayTotalInteractions = await interactionGateway.findInteractionsCountByDateInterval(
        dateTimeNow.initialDayMoment(), dateTimeNow.finalDayMoment());
    final GoalsModel goal = await goalsGateway.findGoalsModel();
    simpleData.weekGoal = goal.weeklyInteractionGoal;
    simpleData.dayGoal = goal.weeklyInteractionGoal ~/ 7;
    simpleData.monthGoal = goal.weeklyInteractionGoal * 4;

    simpleData.currentWeekDay = dateProcessing.weekday;

    do {
      // print('dateProcessing.weekday');
      // print(dateProcessing.weekday);
      // print(dateProcessing.toIso8601String());
      switch (dateProcessing.weekday) {
        case DateTime.sunday:
          {
            dayInteractions = await interactionGateway.findInteractionsCountByDateInterval(
                dateProcessing.initialDayMoment(), dateProcessing.finalDayMoment());
            simpleData.sunday = dayInteractions ?? 0;
          }
          break;
        case DateTime.monday:
          {
            dayInteractions = await interactionGateway.findInteractionsCountByDateInterval(
                dateProcessing.initialDayMoment(), dateProcessing.finalDayMoment());
            simpleData.monday = dayInteractions ?? 0;
          }
          break;
        case DateTime.tuesday:
          {
            dayInteractions = await interactionGateway.findInteractionsCountByDateInterval(
                dateProcessing.initialDayMoment(), dateProcessing.finalDayMoment());
            simpleData.tuesday = dayInteractions ?? 0;
          }
          break;
        case DateTime.wednesday:
          {
            dayInteractions = await interactionGateway.findInteractionsCountByDateInterval(
                dateProcessing.initialDayMoment(), dateProcessing.finalDayMoment());
            simpleData.wednesday = dayInteractions ?? 0;
          }
          break;
        case DateTime.thursday:
          {
            dayInteractions = await interactionGateway.findInteractionsCountByDateInterval(
                dateProcessing.initialDayMoment(), dateProcessing.finalDayMoment());
            simpleData.thursday = dayInteractions ?? 0;
          }
          break;
        case DateTime.friday:
          {
            dayInteractions = await interactionGateway.findInteractionsCountByDateInterval(
                dateProcessing.initialDayMoment(), dateProcessing.finalDayMoment());
            simpleData.friday = dayInteractions ?? 0;
          }
          break;
        case DateTime.saturday:
          {
            dayInteractions = await interactionGateway.findInteractionsCountByDateInterval(
                dateProcessing.initialDayMoment(), dateProcessing.finalDayMoment());
            simpleData.saturday = dayInteractions ?? 0;
          }
          break;
      }
      simpleData.weekTotalInteractions += dayInteractions ?? 0;
      if (dayInteractions > simpleData.maxInteractionsDay)
        simpleData.maxInteractionsDay = dayInteractions;
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
  int dayTotalInteractions;
  int weekTotalInteractions;
  int monthTotalInteractions;
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
  int maxInteractionsDay;
  SimpleGraphsData({
    this.dayTotalInteractions = 0,
    this.weekTotalInteractions = 0,
    this.monthTotalInteractions = 0,
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
    this.maxInteractionsDay = 0,
  });
}

// class GetInteractionsComplexGraphsData {
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
//           await interactionGateway.findDashboardDataByDateInterval(week.initialDate, week.finalDate);
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
    List<InteractionModel> interactionsModel = await interactionGateway.getLast30Interactions();

    int x = 30;
    for (final interactionModel in interactionsModel) {
      InteractionEntity interaction = await GetInteraction().call(interactionModel.id);

      for (final point in interaction.points) {
        lineChart.feedPoint(interaction.id, interaction.name, point.id, point.name, point.value, x);
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
    int interactionId,
    String interactionName,
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

    lines[selectedLineIndex].pointData.add(
          PointData(
            interactionId: interactionId,
            interactionName: interactionName,
            position: x,
            value: pointValue,
          ),
        );
  }
}

class LineData {
  final int pointId;
  final String pointName;
  List<PointData> pointData = [];

  LineData({@required this.pointId, @required this.pointName});
}

class PointData {
  final int interactionId;
  final String interactionName;
  final int position;
  final int value;

  PointData(
      {@required this.interactionId,
      @required this.interactionName,
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
