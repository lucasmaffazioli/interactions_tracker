import 'package:cold_app/domain/entities/approach/approach_entity.dart';
import 'package:flutter/foundation.dart';

class ApproachesController {
  List<ApproachListItem> getAllApproaches() {
    // final items = List<ApproachListItem>.generate(
    //   15,
    //   (i) => i % 6 == 0
    //       ? ApproachListItem(isMonth: true, month: i.toString())
    //       : ApproachListItem(
    //           isMonth: false, title: 'Kim Kardashian', day: i.toString(), month: 'Dezembro'),
    // );
    List<ApproachListItem> items = [];
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description:
              'Long hair, nice back, good looking nose, nice person, od looking nose, nice person, od looking nose, nice person, od looking nose, nice person, od looking nose, nice person, od looking nose, nice person, od looking nose, nice person, very happy, nice overral',
          day: '27',
          month: 'agosto',
          attraction: 8,
          skill: 10,
          isMonth: true,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description:
              'Long hair, nice back, good looking nose, good looking nose, good looking nose, good looking nose, good looking nose, good looking nose, good looking nose, nice person, very happy, nice overral',
          day: '27',
          month: 'agosto',
          skill: 10,
          isMonth: false,
          attraction: 7,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description: 'Long asdasdasdasdas',
          day: '24',
          month: 'agosto',
          skill: 10,
          attraction: 8,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description: 'Long hair',
          day: '13',
          month: 'agosto',
          skill: 10,
          attraction: 8,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description: 'Long hair',
          day: '10',
          month: 'agosto',
          skill: 10,
          attraction: 8,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description: 'Long hair',
          day: '2',
          month: 'agosto',
          skill: 10,
          attraction: 8,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description: 'Long hair',
          day: '24',
          month: 'agosto',
          skill: 10,
          attraction: 8,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description: 'Long hair',
          day: '13',
          month: 'agosto',
          skill: 10,
          attraction: 8,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description: 'Long hair',
          day: '10',
          month: 'agosto',
          skill: 10,
          attraction: 8,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description: 'Long hair',
          day: '2',
          month: 'setembro',
          isMonth: true,
          skill: 10,
          attraction: 8,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description: 'Long hair',
          day: '24',
          month: 'agosto',
          skill: 10,
          attraction: 8,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description: 'Long hair',
          day: '13',
          month: 'agosto',
          skill: 10,
          attraction: 8,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description: 'Long hair',
          day: '10',
          month: 'agosto',
          skill: 10,
          attraction: 8,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description: 'Long hair',
          day: '2',
          month: 'dezembro',
          isMonth: true,
          skill: 10,
          attraction: 8,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description: 'Long hair',
          day: '13',
          month: 'agosto',
          skill: 10,
          attraction: 8,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description: 'Long hair',
          day: '10',
          month: 'agosto',
          skill: 10,
          attraction: 8,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description: 'Long hair',
          day: '13',
          month: 'agosto',
          skill: 10,
          attraction: 8,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description: 'Long hair',
          day: '10',
          month: 'agosto',
          skill: 10,
          attraction: 8,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description: 'Long hair',
          day: '13',
          month: 'agosto',
          skill: 10,
          attraction: 8,
          result: 7),
    );
    items.add(
      ApproachListItem(
          title: 'Joana Dark',
          description: 'Long hair',
          day: '10',
          month: 'agosto',
          skill: 10,
          attraction: 8,
          result: 7),
    );
    // items.add(
    //   MonthApproaches('Julho', <ApproachListItem>[
    //     ApproachListItem(
    //         title: 'Joana Dark',
    //         description: 'Long hair',
    //         day: '27',
    //         month: 'agosto',
    //         skill: 10,
    //         attraction: 8,
    //         result: 7),
    //     ApproachListItem(
    //         title: 'Joana Dark',
    //         description: 'Long hair',
    //         day: '24',
    //         month: 'agosto',
    //         skill: 10,
    //         attraction: 8,
    //         result: 7),
    //     ApproachListItem(
    //         title: 'Joana Dark',
    //         description: 'Long hair',
    //         day: '13',
    //         month: 'agosto',
    //         skill: 10,
    //         attraction: 8,
    //         result: 7),
    //     ApproachListItem(
    //         title: 'Joana Dark',
    //         description: 'Long hair',
    //         day: '10',
    //         month: 'agosto',
    //         skill: 10,
    //         attraction: 8,
    //         result: 7),
    //     ApproachListItem(
    //         title: 'Joana Dark',
    //         description: 'Long hair',
    //         day: '2',
    //         month: 'agosto',
    //         skill: 10,
    //         attraction: 8,
    //         result: 7),
    //   ]),
    // );
    // items.add(
    //   MonthApproaches('Julho', <ApproachListItem>[
    //     ApproachListItem(
    //         title: 'Joana Dark',
    //         description: 'Long hair',
    //         day: '27',
    //         month: 'agosto',
    //         skill: 10,
    //         attraction: 8,
    //         result: 7),
    //     ApproachListItem(
    //         title: 'Joana Dark',
    //         description: 'Long hair',
    //         day: '24',
    //         month: 'agosto',
    //         skill: 10,
    //         attraction: 8,
    //         result: 7),
    //     ApproachListItem(
    //         title: 'Joana Dark',
    //         description: 'Long hair',
    //         day: '13',
    //         month: 'agosto',
    //         skill: 10,
    //         attraction: 8,
    //         result: 7),
    //     ApproachListItem(
    //         title: 'Joana Dark',
    //         description: 'Long hair',
    //         day: '10',
    //         month: 'agosto',
    //         skill: 10,
    //         attraction: 8,
    //         result: 7),
    //     ApproachListItem(
    //         title: 'Joana Dark',
    //         description: 'Long hair',
    //         day: '2',
    //         month: 'agosto',
    //         skill: 10,
    //         attraction: 8,
    //         result: 7),
    //   ]),
    // );

    return items;
  }
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
  final int skill;
  final int attraction;
  final int result;

  ApproachListItem({
    this.isMonth = false,
    @required this.title,
    @required this.description,
    @required this.day,
    @required this.month,
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
