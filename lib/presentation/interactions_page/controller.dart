import 'package:cold_app/data/models/interaction/interaction_views.dart';
import 'package:cold_app/domain/usecases/interaction_usecases.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/extensions/string_extension.dart';

class InteractionsController {
  Future<int> deleteInteractions(List<int> interactionsId) async {
    int totalDeletedItems = 0;

    interactionsId.forEach((element) async {
      print('Deleting interaction $element ....');
      await DeleteInteraction().call(element);
      // totalDeletedItems += deletedItems;
      // if (deletedItems < 1) {
      //   print('erorrrrrr'); // TODO throw error
      // }
    });

    return totalDeletedItems;
  }

  Stream<List<InteractionSummaryPresentation>> getAllInteractionsStream(
      BuildContext context) async* {
    Stream<List<InteractionSummaryView>> items = await GetAllSummaryInteractionsStream().call();
    List<InteractionSummaryPresentation> returnItems = [];
    await Future.delayed(const Duration(milliseconds: 2000), () {});

    print('getAllInteractionsStream method called');
    await for (var value in items) {
      print('value');
      print(value);
      int _lastMonth = 0;
      value.forEach((element) {
        int _currentMonth = DateTime.parse(element.dateTime).month;
        if (_currentMonth != _lastMonth) {
          returnItems.add(InteractionSummaryPresentation(
            isMonth: true,
            month: DateFormat.MMMM(Localizations.localeOf(context).languageCode)
                .format(DateTime.parse(element.dateTime))
                .capitalize(),
          ));
        }

        returnItems.add(InteractionSummaryPresentation(
          isMonth: false,
          month: DateFormat.MMMM(Localizations.localeOf(context).languageCode)
              .format(DateTime.parse(element.dateTime))
              .capitalize(),
          day: DateTime.parse(element.dateTime).day.toString().padLeft(2, '0'),
          id: element.id,
          name: element.name,
          dateTime: element.dateTime,
          description: element.description,
          difficulty: element.difficulty == null ? 0 : element.difficulty.toInt(),
          skill: element.skill == null ? 0 : element.skill.toInt(),
          attraction: element.attraction == null ? 0 : element.attraction.toInt(),
          result: element.result == null ? 0 : element.result.toInt(),
        ));
        _lastMonth = _currentMonth;
      });
      // if (returnItems.isNotEmpty) yield returnItems;
      yield returnItems;
      returnItems = [];
    }

    // return returnItems;
  }
}

class InteractionSummaryPresentation {
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

  InteractionSummaryPresentation({
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

// class MonthInteractions {
//   final String month;
//   final List<InteractionListItem> interactionListItem;

//   MonthInteractions(this.month, this.interactionListItem);
// }

class InteractionListItem {
  final bool isMonth;
  final String title;
  final String description;
  final String day;
  final String month;
  final int difficulty;
  final int skill;
  final int attraction;
  final int result;

  InteractionListItem({
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
