import 'package:cold_app/presentation/common/loading.dart';
import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/presentation/interactions_page/controller.dart';
import 'package:cold_app/presentation/common/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cold_app/presentation/common/show_delete_confirmation.dart';

import '../add_interaction_page/add_interaction_page.dart';
import '../common/constants.dart';

class InteractionsPage extends StatefulWidget {
  final Function changeAppBar;
  final BaseAppBar defaultAppBar;

  const InteractionsPage({
    @required this.changeAppBar,
    @required this.defaultAppBar,
    Key key,
  }) : super(key: key);

  @override
  _InteractionsPageState createState() => _InteractionsPageState();
}

class _InteractionsPageState extends State<InteractionsPage> {
  final InteractionsController controller = InteractionsController();
  bool isSelecting = false;
  Stream<List<InteractionSummaryPresentation>> stream;
  List<int> selectedItems = [];

  List<InteractionSummaryPresentation> items;

  @override
  void initState() {
    stream = controller.getAllInteractionsStream(context);

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
    // print('selectedItems.length');
    // print(selectedItems.length);
    // print(widget.defaultAppBar);
    // print(widget.defaultAppBar.title);

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
                await _deleteSelectedInteractions();
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

  _deleteSelectedInteractions() async {
    await controller.deleteInteractions(selectedItems);

    // print('Total deleted items');
    // print(totalDeleted);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<InteractionSummaryPresentation>>(
      stream: stream,
      builder: (context, AsyncSnapshot<List<InteractionSummaryPresentation>> snapshot) {
        if (snapshot.hasError) {
          return Container(child: Text(snapshot.error.toString()));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }
        if (snapshot.data.length == 0 &&
            (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done)) {
          return Center(
              child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text('Your interactions will be shown here'.i18n),
          ));
        }

        items = snapshot.data ?? [];
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
                            builder: (context) => AddInteractionPage(interactionId: item.id),
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
