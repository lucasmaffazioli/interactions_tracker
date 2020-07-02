import 'package:cold_app/domain/entities/approach/approach_entity.dart';
import 'package:flutter/material.dart';

class ApproachesController {
  List<ListItem> getAllApproaches() {
    final items = List<ListItem>.generate(
      1200,
      (i) => i % 6 == 0 ? HeadingItem("Heading $i") : MessageItem("Sender $i", "Message body $i"),
    );
    return items;
  }
}

abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  // Widget buildSubtitle(BuildContext context) => null;
  Widget buildSubtitle(BuildContext context) => Text('aaaaa');
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  Widget buildTitle(BuildContext context) => Text(sender);

  Widget buildSubtitle(BuildContext context) => Text(body);
}
