import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/presentation/approaches_page/controller.dart';
import 'package:cold_app/presentation/common/base_app_bar.dart';
import 'package:cold_app/presentation/settings_page/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../add_approach_page/add_approach_page.dart';
import '../common/constants.dart';

class ApproachesPage extends StatefulWidget {
  final Function changeBaseAppBar;

  const ApproachesPage(this.changeBaseAppBar, {Key key}) : super(key: key);

  @override
  _ApproachesPageState createState() => _ApproachesPageState();
}

class _ApproachesPageState extends State<ApproachesPage> {
  final ApproachesController controller = ApproachesController();
  Stream<List<ApproachSummaryPresentation>> stream;
  List<int> selectedItems = [];

  List<ApproachSummaryPresentation> items;

  @override
  void initState() {
    stream = controller.getAllApproachesStream(context);

    widget.changeBaseAppBar(BaseAppBar(
      'a', // TODO fix me
      // AppLocalizations.of(context).translate('approaches'),
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
    ));

    super.initState();
  }

  // @override
  // bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    return StreamBuilder<List<ApproachSummaryPresentation>>(
      stream: stream,
      builder: (context, AsyncSnapshot<List<ApproachSummaryPresentation>> snapshot) {
        print('projectconnection state is: ${snapshot.connectionState}');
        print('project snapshot data is: ${snapshot.data}');
        print('project has error is: ${snapshot.hasError} + ${snapshot.error.toString()}');
        print('project has data is: ${snapshot.hasData.toString()}');
        if (snapshot.hasError) {
          return Container(child: Text('Error loading data!'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: const CircularProgressIndicator(
                    backgroundColor: Constants.accent2,
                    // strokeWidth: 10,
                  ),
                  width: 60,
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text('Loading'.i18n),
                )
              ],
            ),
          );
        }

        items = snapshot.data ?? [];
        print('items');
        print(items);
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final isSelected = selectedItems.indexOf(item.id) != -1;
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
                      builder: (context) => AddApproachPage(approachId: item.id),
                    ),
                  );
                }),
                onLongPress: (() {
                  setState(() {
                    print(selectedItems.indexOf(item.id));
                    if (isSelected) {
                      selectedItems.removeAt(selectedItems.indexOf(item.id));
                    } else {
                      selectedItems.add(item.id);
                    }
                  });
                }),
                isSelected: isSelected,
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
      },
    );
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
    @required this.onLongPress,
    @required this.isSelected,
  }) : super(key: key);

  final Function onTap;
  final Function onLongPress;
  final bool isSelected;
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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      elevation: 0,
      child: Ink(
        decoration: BoxDecoration(
          color: isSelected ? Colors.black26 : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
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
      ),
    );
  }
}
