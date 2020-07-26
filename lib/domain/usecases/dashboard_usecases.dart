import 'package:cold_app/data/models/approach/dashboard.dart';
import 'package:cold_app/data/models/approach/goals_model.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';
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
      print('dateProcessing.weekday');
      print(dateProcessing.weekday);
      print(dateProcessing.toIso8601String());
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

class GetApproachesComplexGraphsData {
  Future<List<WeekComplexData>> call() async {
    // List<ApproachesDashboardDataView> returnList;
    List<WeekComplexData> list = [];
    DateTime dateTimeNow = DateTime.now();
    int weekNumber = 0;
    int firstWeek = 9999;
    int finalWeek;
    int i = 0;

    do {
      DateTime dateProcessing =
          DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day).add(Duration(days: -i));
      weekNumber = _weekNumber(dateProcessing);
      if (firstWeek > weekNumber) firstWeek = weekNumber;
      if (finalWeek == null) finalWeek = weekNumber;
      //
      _calc(dateProcessing, weekNumber, list);
      i++;
    } while (finalWeek - firstWeek <= 11);
    list.removeLast();

    ///
    /// Processamento de datas
    ///
    ///
    for (int i = 0; i < list.length; i++) {
      final week = list[i];
      list[i].dashboardData =
          await approachGateway.findDashboardDataByDateInterval(week.initialDate, week.finalDate);
    }
    // list.forEach((element) {
    //   element.dashboardData.forEach((e) {
    // print('e.toJson()');
    // print(e.toJson());
    //   });
    // });

    return list;
  }

  List<WeekComplexData> _calc(DateTime dateProcessing, int weekNumber, List<WeekComplexData> list) {
    int indexWeekNumber = list.indexWhere((element) => element.weekNumber == weekNumber);

    if (indexWeekNumber == -1) {
      list.add(WeekComplexData(weekNumber, dateProcessing, dateProcessing.finalDayMoment()));
    } else {
      if (dateProcessing.difference(list[indexWeekNumber].initialDate).inDays < 0)
        list[indexWeekNumber].initialDate = dateProcessing;
    }
    return list;
  }

  /// Calculates week number from a date as per https://en.wikipedia.org/wiki/ISO_week_date#Calculation
  int _weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }
}

class WeekComplexData {
  int weekNumber;
  DateTime initialDate;
  DateTime finalDate;
  List<DashboardComplexModel> dashboardData;

  WeekComplexData(this.weekNumber, this.initialDate, this.finalDate, {this.dashboardData});
}
