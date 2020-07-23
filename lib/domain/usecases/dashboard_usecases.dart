import 'package:cold_app/data/models/approach/approach_views.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';
import 'package:intl/intl.dart';

// ApproachesDashboardDataViewGateway dashboardDataViewGateway = ApproachesDashboardDataViewGateway();
ApproachFloorGateway approachGateway = ApproachFloorGateway();

class GetAllApproachesDashboardDataFuture {
  Future<List<WeekNumber>> call() async {
    // List<ApproachesDashboardDataView> returnList;
    List<WeekNumber> list = [];
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

    return list;
  }

  List<WeekNumber> _calc(DateTime dateProcessing, int weekNumber, List<WeekNumber> list) {
    int indexWeekNumber = list.indexWhere((element) => element.weekNumber == weekNumber);

    if (indexWeekNumber == -1) {
      list.add(WeekNumber(
          weekNumber,
          dateProcessing,
          DateTime(
              dateProcessing.year, dateProcessing.month, dateProcessing.day, 23, 59, 59, 999)));
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

class WeekNumber {
  int weekNumber;
  DateTime initialDate;
  DateTime finalDate;
  List<ApproachesDashboardDataView> dashboardData;

  WeekNumber(this.weekNumber, this.initialDate, this.finalDate, {this.dashboardData});
}
