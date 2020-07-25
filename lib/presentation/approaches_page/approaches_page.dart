import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/presentation/approaches_page/controller.dart';
import 'package:cold_app/presentation/common/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cold_app/presentation/common/show_delete_confirmation.dart';

import '../add_approach_page/add_approach_page.dart';
import '../common/constants.dart';

class ApproachesPage extends StatefulWidget {
  final Function changeAppBar;
  final BaseAppBar defaultAppBar;

  const ApproachesPage({
    @required this.changeAppBar,
    @required this.defaultAppBar,
    Key key,
  }) : super(key: key);

  @override
  _ApproachesPageState createState() => _ApproachesPageState();
}

class _ApproachesPageState extends State<ApproachesPage> {
  final ApproachesController controller = ApproachesController();
  bool isSelecting = false;
  Stream<List<ApproachSummaryPresentation>> stream;
  List<int> selectedItems = [];

  List<ApproachSummaryPresentation> items;

  @override
  void initState() {
    stream = controller.getAllApproachesStream(context);

    super.initState();
  }

  _emptySelected() {
    isSelecting = false;
    widget.changeAppBar(widget.defaultAppBar);
    setState(() {
      selectedItems.clear();
    });
  }

  _selectItems(int itemId, bool isSelected) {
    if (isSelected) {
      setState(() {
        selectedItems.removeAt(selectedItems.indexOf(itemId));
      });
    } else {
      setState(() {
        selectedItems.add(itemId);
      });
    }
    print('selectedItems.length');
    print(selectedItems.length);
    print(widget.defaultAppBar);
    print(widget.defaultAppBar.title);

    if (selectedItems.length == 0) {
      _emptySelected();
    } else {
      isSelecting = true;
      widget.changeAppBar(BaseAppBar(
        '%d selected'.plural(selectedItems.length),
        hasBackButton: true,
        backButtonCustomTap: _emptySelected,
        actions: <Widget>[
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.trash,
              color: Constants.mainTextColor,
            ),
            tooltip: 'Delete items'.i18n,
            onPressed: () {
              showDeleteConfirmationPopup(context, onConfirm: () async {
                await _deleteSelectedApproaches();
                _emptySelected();
                Navigator.maybePop(context);
              });
            },
          ),
        ],
        appBar: AppBar(),
      ));
    }
  }

  _deleteSelectedApproaches() async {
    int totalDeleted = await controller.deleteApproaches(selectedItems);
    print('Total deleted items');
    print(totalDeleted);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ApproachSummaryPresentation>>(
      stream: stream,
      builder: (context, AsyncSnapshot<List<ApproachSummaryPresentation>> snapshot) {
        print('projectconnection state is: ${snapshot.connectionState}');
        print('project snapshot data is: ${snapshot.data}');
        print('project has error is: ${snapshot.hasError} - ${snapshot.error.toString()}');
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
                  child: Text('Loading...'.i18n),
                )
              ],
            ),
          );
        }
        if (snapshot.data.length == 0 &&
            (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done)) {
          return Center(
              child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text('Your approaches will be shown here'.i18n),
          ));
        }

        items = snapshot.data ?? [];
        print('items');
        print(items);
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final bool isSelected = selectedItems.indexOf(item.id) != -1;
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
                onTap: (isSelecting
                    ? () => _selectItems(item.id, isSelected)
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddApproachPage(approachId: item.id),
                          ),
                        );
                      }),
                onLongPress: (() {
                  _selectItems(item.id, isSelected);
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
