import 'package:cold_app/presentation/approaches_page/controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../add_approach_page/add_approach_page.dart';
import '../common/base_app_bar.dart';
import '../common/constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        'Abordagens',
        appBar: AppBar(),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: (() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddApproachPage()),
          );
        }),
        child: FaIcon(FontAwesomeIcons.plus),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _Approaches(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Constants.accent,
        unselectedItemColor: Constants.accentDisabled,
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.chartPie,
              color: Constants.accent,
            ),
            title: Text(
              'Dashboard',
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.list,
              // color: Constants.accentDisabled,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.list,
              // color: Constants.accent,
            ),
            title: Text(
              'Abordagens',
            ),
          ),
        ],
      ),
      // ],
      // ),
      // ),
      // body: CollapsingList(),
      // bottomNavigationBar: BottomNavigationBar(items: null),
    );
  }
}

class _Approaches extends StatelessWidget {
  final ApproachesController controller = ApproachesController();

  @override
  Widget build(BuildContext context) {
    Future<List<ApproachListItem>> itemsFuture = controller.getAllApproaches();
    List<ApproachListItem> items;

    return FutureBuilder<List<ApproachListItem>>(
        future: itemsFuture,
        builder: (context, AsyncSnapshot snapshot) {
          print('projectconnection state is: ${snapshot.connectionState}');
          print('project snapshot data is: ${snapshot.data}');
          print('project has data is: ${snapshot.hasData.toString()}');

          if (snapshot.connectionState != ConnectionState.done) {
            print('project snapshot data is: ${snapshot.data}');
            return Container(child: Text('Loading data....'));
          }
          items = snapshot.data ?? [];
          return ListView.builder(
            // Let the ListView know how many items it needs to build.
            itemCount: items.length,

            itemBuilder: (context, index) {
              final item = items[index];
              // final List<Widget> approaches = [];
              if (item.isMonth) {
                return Center(
                    child: Text(
                  item.month,
                  style: Constants.textH1,
                ));
              } else {
                return MyCard(
                  title: item.title,
                  description: item.description,
                  month: item.month,
                  day: item.day,
                  skill: item.skill,
                  attraction: item.attraction,
                  result: item.result,
                );
              }
            },
          );
        });
  }
}

class ScoreIcon extends StatelessWidget {
  final IconData iconData;
  final int points;

  const ScoreIcon({this.iconData, this.points, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 6, 0, 0),
      child: Column(
        children: <Widget>[
          FaIcon(
            iconData,
            color: Constants.accent2,
          ),
          Text(
            points.toString(),
            style: TextStyle(color: Constants.accent2, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({
    Key key,
    @required this.title,
    @required this.description,
    @required this.month,
    @required this.day,
    @required this.skill,
    @required this.attraction,
    @required this.result,
  }) : super(key: key);
  final String title;
  final String description;
  final String month;
  final String day;
  final int skill;
  final int attraction;
  final int result;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    description,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      day,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      month,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    ScoreIcon(iconData: FontAwesomeIcons.pollH, points: skill),
                    ScoreIcon(iconData: FontAwesomeIcons.solidHeart, points: attraction),
                    ScoreIcon(iconData: FontAwesomeIcons.medal, points: result),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
