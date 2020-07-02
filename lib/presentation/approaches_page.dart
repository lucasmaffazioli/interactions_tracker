import 'package:cold_app/presentation/controllers/approach.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Abordagens'),
      ),
      body: Approaches(),
      // bottomNavigationBar: BottomNavigationBar(items: null),
    );
  }
}

class Approaches extends StatelessWidget {
  // const Approaches({
  //   Key key,
  // }) : super(key: key);

  final ApproachesController controller = ApproachesController();

  @override
  Widget build(BuildContext context) {
    List<ListItem> items = controller.getAllApproaches();

    return ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: items.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = items[index];

        return ListTile(
          title: item.buildTitle(context),
          subtitle: item.buildSubtitle(context),
        );
      },
    );
  }
}
