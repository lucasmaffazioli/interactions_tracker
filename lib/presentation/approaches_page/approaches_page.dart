import 'package:cold_app/core/app_localizations.dart';
import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/presentation/approaches_page/controller.dart';
import 'package:cold_app/presentation/settings_page/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../add_approach_page/add_approach_page.dart';
import '../common/base_app_bar.dart';
import '../common/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        // 'Approaches',
        AppLocalizations.of(context).translate('approaches'),
        actions: <Widget>[
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.cog,
              color: Constants.mainTextColor,
            ),
            tooltip: 'Show settings',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ),
        ],
        appBar: AppBar(),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        // shape: CircleBorder(
        //   side: BorderSide(
        //     width: 4,
        //     color: Colors.white,
        //     style: BorderStyle.solid,
        //   ),
        // ),
        onPressed: (() async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddApproachPage()),
          ).then((value) {
            setState(() {});
          });
        }),
        child: FaIcon(FontAwesomeIcons.plus),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _Approaches(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(28), blurRadius: 20)]),
        child: BottomNavigationBar(
          elevation: 50,
          selectedItemColor: Constants.accent,
          unselectedItemColor: Constants.accentDisabled,
          items: [
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.chartPie,
                color: Constants.accent,
              ),
              title: Text(
                AppLocalizations.of(context).translate('dashboard'),
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
                AppLocalizations.of(context).translate('approaches'),
              ),
            ),
          ],
        ),
      ),
      // ],
      // ),
      // ),
      // body: CollapsingList(),
      // bottomNavigationBar: BottomNavigationBar(items: null),
    );
  }
}

class _Approaches extends StatefulWidget {
  @override
  __ApproachesState createState() => __ApproachesState();
}

class __ApproachesState extends State<_Approaches> {
  final ApproachesController controller = ApproachesController();

  List<ApproachSummaryPresentation> items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future<List<ApproachSummaryPresentation>> itemsFuture = controller.getAllApproaches(context);

    return StreamBuilder<List<ApproachSummaryPresentation>>(
        // return FutureBuilder<List<ApproachSummaryPresentation>>(
        // future: controller.getAllApproaches(context),
        stream: controller.getAllApproachesStream(context),
        builder: (context, AsyncSnapshot<List<ApproachSummaryPresentation>> snapshot) {
          print('projectconnection state is: ${snapshot.connectionState}');
          print('project snapshot data is: ${snapshot.data}');
          print('project has data is: ${snapshot.hasData.toString()}');

          if (snapshot.hasError) {
            return Container(child: Text('Error loading data!'));
          }
          items = snapshot.data ?? [];
          print('items');
          print(items);
          return ListView.builder(
            // Let the ListView know how many items it needs to build.
            itemCount: items.length,

            itemBuilder: (context, index) {
              final item = items[index];
              if (item.isMonth) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
                    item.month,
                    style: Constants.textH1,
                  ),
                );
              } else {
                return MyCard(
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddApproachPage(
                                approachId: item.id,
                              )),
                    ).then((value) {
                      // setState(() {});
                    });
                  }),
                  title: item.name,
                  description: item.description,
                  month: item.month,
                  day: item.day,
                  difficulty: item.difficulty,
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
    @required this.onTap,
    @required this.title,
    @required this.description,
    @required this.month,
    @required this.day,
    @required this.difficulty,
    @required this.skill,
    @required this.attraction,
    @required this.result,
  }) : super(key: key);

  final Function onTap;
  final String title;
  final String description;
  final String month;
  final String day;
  final int difficulty;
  final int skill;
  final int attraction;
  final int result;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
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
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      ScoreIcon(iconData: getPointTypeIcon(PointType.skill), points: skill),
                      ScoreIcon(
                          iconData: getPointTypeIcon(PointType.attraction), points: attraction),
                      ScoreIcon(
                          iconData: getPointTypeIcon(PointType.difficulty), points: difficulty),
                      ScoreIcon(iconData: getPointTypeIcon(PointType.result), points: result),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
