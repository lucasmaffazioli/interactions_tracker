import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:cold_app/presentation/constants.dart';
import 'package:cold_app/presentation/controllers/approach.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: AppBarTitleText('Abordagens'),
        ),
        backgroundColor: Constants.background,
      ),
      body: SafeArea(child: Approaches()),
      // body: CollapsingList(),
      // bottomNavigationBar: BottomNavigationBar(items: null),
    );
  }
}

class AppBarTitleText extends StatelessWidget {
  final String text;

  const AppBarTitleText(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      // elevation: 5,
      child: Container(
        height: 65,
        width: double.infinity,
        color: Constants.background,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontFamily: 'MPlusRounded',
                fontWeight: FontWeight.w900,
                fontSize: 26,
                color: Constants.mainTitleColor),
          ),
        ),
      ),
    );
  }
}

class Approaches extends StatelessWidget {
  final ApproachesController controller = ApproachesController();

  @override
  Widget build(BuildContext context) {
    List<MonthApproaches> items = controller.getAllApproaches();

    return NotificationListener(
      child: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: items.length,

        itemBuilder: (context, index) {
          final item = items[index];
          final List<Widget> approaches = [];

          item.approachListItem.forEach((element) {
            approaches.add(
              MyCard(
                title: element.title,
                month: element.month,
                day: element.day,
              ),
            );
          });

          return StickyHeader(
            header: AppBarTitleText(item.month),
            content: Column(children: approaches),
          );

          // ListTile(
          //   title: Center(
          //     child: AppBarTitleText(item.title),
          //   ),
          // );
          // } else {
          //   return MyCard(
          //     title: item.title,
          //     month: item.month,
          //     day: item.day,
          //   );
          // }
        },
      ),
    );
  }
}

class MiniIcon extends StatelessWidget {
  final IconData iconData;

  const MiniIcon(this.iconData, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: FaIcon(
        iconData,
        color: Constants.accent2,
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({
    Key key,
    this.title,
    this.month,
    this.day,
  }) : super(key: key);
  final String title;
  final String month;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(title),
              Text(title),
              Text(title),
              Text(title),
              Text(title),
              Text(title),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      day,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Text(
                    month,
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  MiniIcon(FontAwesomeIcons.pollH),
                  MiniIcon(FontAwesomeIcons.solidHeart),
                  MiniIcon(FontAwesomeIcons.medal),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
