import 'package:cold_app/data/models/approach/approach_views.dart';
import 'package:cold_app/domain/usecases/approach_usecases.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/extensions/string_extension.dart';

class ApproachesController {
  Future<int> deleteApproaches(List<int> approachesId) async {
    int totalDeletedItems = 0;

    approachesId.forEach((element) async {
      print('Deleting approach $element ....');
      await DeleteApproach().call(element);
      // totalDeletedItems += deletedItems;
      // if (deletedItems < 1) {
      //   print('erorrrrrr'); // TODO throw error
      // }
    });

    return totalDeletedItems;
  }

  Stream<List<ApproachSummaryPresentation>> getAllApproachesStream(BuildContext context) async* {
    Stream<List<ApproachSummaryView>> items = await GetAllSummaryApproachesStream().call();
    List<ApproachSummaryPresentation> returnItems = [];
    await Future.delayed(const Duration(milliseconds: 2000), () {});

    print('getAllApproachesStream method called');
    await for (var value in items) {
      print('value');
      print(value);
      int _lastMonth = 0;
      value.forEach((element) {
        int _currentMonth = DateTime.parse(element.dateTime).month;
        if (_currentMonth != _lastMonth)
          returnItems.add(ApproachSummaryPresentation(
            isMonth: true,
            month: DateFormat.MMMM(Localizations.localeOf(context).languageCode)
                .format(DateTime.parse(element.dateTime))
                .capitalize(),
          ));

        returnItems.add(ApproachSummaryPresentation(
          isMonth: false,
          month: DateFormat.MMMM(Localizations.localeOf(context).languageCode)
              .format(DateTime.parse(element.dateTime))
              .capitalize(),
          day: DateTime.parse(element.dateTime).day.toString().padLeft(2, '0'),
          id: element.id,
          name: element.name,
          dateTime: element.dateTime,
          description: element.description,
          difficulty: element.difficulty.toInt(),
          skill: element.skill.toInt(),
          attraction: element.attraction.toInt(),
          result: element.result.toInt(),
        ));
        _lastMonth = _currentMonth;
      });
      yield returnItems;
      returnItems = [];
    }

    // return returnItems;
  }
}

class ApproachSummaryPresentation {
  final bool isMonth;
  final String month;
  final String day;
  final int id;
  final String name;
  final String dateTime;
  final String description;
  final int difficulty;
  final int skill;
  final int attraction;
  final int result;

  ApproachSummaryPresentation({
    @required this.isMonth,
    this.month,
    this.day,
    this.id,
    this.name,
    this.dateTime,
    this.description,
    this.difficulty,
    this.skill,
    this.attraction,
    this.result,
  });
}

// class MonthApproaches {
//   final String month;
//   final List<ApproachListItem> approachListItem;

//   MonthApproaches(this.month, this.approachListItem);
// }

class ApproachListItem {
  final bool isMonth;
  final String title;
  final String description;
  final String day;
  final String month;
  final int difficulty;
  final int skill;
  final int attraction;
  final int result;

  ApproachListItem({
    this.isMonth = false,
    @required this.title,
    @required this.description,
    @required this.day,
    @required this.month,
    @required this.difficulty,
    @required this.skill,
    @required this.attraction,
    @required this.result,
  });
}

// abstract class ListItem {
//   Widget buildTitle(BuildContext context);
//   Widget buildSubtitle(BuildContext context);
//   bool isMonth();
// }

// /// A ListItem that contains data to display a heading.
// class HeadingItem implements ListItem {
//   final String heading;
//   final String type = 'month';

//   isMonth() => true;

//   HeadingItem(this.heading);

//   Widget buildTitle(BuildContext context) {
//     return Text(
//       heading,
//       style: Theme.of(context).textTheme.headline5,
//     );
//   }

//   // Widget buildSubtitle(BuildContext context) => null;
//   Widget buildSubtitle(BuildContext context) => Text('body');
// }

// /// A ListItem that contains data to display a message.
// class MessageItem implements ListItem {
//   final String sender;
//   final String body;

//   isMonth() => false;

//   MessageItem(this.sender, this.body);

//   Widget buildTitle(BuildContext context) => Text(sender);

//   Widget buildSubtitle(BuildContext context) => Text(body);
// }
