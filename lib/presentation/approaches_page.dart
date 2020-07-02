import 'package:cold_app/presentation/constants.dart';
import 'package:cold_app/presentation/controllers/approach.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      body: Approaches(),
      // bottomNavigationBar: BottomNavigationBar(items: null),
    );
  }
}

class AppBarTitleText extends StatelessWidget {
  final String text;

  const AppBarTitleText(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'MPlusRounded',
          fontWeight: FontWeight.w900,
          fontSize: 26,
          color: Constants.mainTitleColor),
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
    List<ApproachListItem> items = controller.getAllApproaches();

    return ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: items.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = items[index];

        if (item.isMonth) {
          return ListTile(
            title: Center(
              child: AppBarTitleText(item.title),
            ),
          );
        } else {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(item.title),
                    Text(item.title),
                    Text(item.title),
                    Text(item.title),
                    Text(item.title),
                    Text(item.title),
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
                            item.day,
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Text(
                          item.month,
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
      },
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
