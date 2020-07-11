import 'package:cold_app/data/models/approach/approach_views.dart';
import 'package:cold_app/domain/entities/approach/approach_entity.dart';
import 'package:cold_app/domain/usecases/approach_usecases.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/extensions/string_extension.dart';

class ApproachesController {
  callEditScreen(int id) async {
    // List<ApproachModel> approaches = await GetAllApproaches().call();

    // print('callEditScreen');
    // approaches.forEach((element) {
    //   print(element.toJson());
    // });

    ApproachEntity approach = await GetApproach().call(id);
    print('approach.toString()');
    print(approach.toJson());
  }

  Future<List<ApproachSummaryPresentation>> getAllApproaches(BuildContext context) async {
    List<ApproachSummaryPresentation> returnItems = [];
    List<ApproachSummaryView> items = await GetAllSummaryApproaches().call();

    print('getAllApproaches method called');

    int _lastMonth = 0;
    items.forEach((element) {
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
        difficulty: 1,
        skill: 1,
        attraction: 1,
        result: 1,
        // difficulty: element.difficulty.toInt(),
        // skill: element.skill.toInt(),
        // attraction: element.attraction.toInt(),
        // result: element.result.toInt(),
      ));
    });

    return returnItems;
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
