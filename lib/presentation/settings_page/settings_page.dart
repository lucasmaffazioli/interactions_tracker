import 'package:cold_app/core/app_localizations.dart';
import 'package:cold_app/data/models/approach/goals_model.dart';
import 'package:cold_app/presentation/common/base_app_bar.dart';
import 'package:cold_app/presentation/goals/goals_page.dart';
import 'package:cold_app/presentation/points/points_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cold_app/domain/usecases/goals_usecases.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        AppLocalizations.of(context).translate('settings'),
        hasBackButton: true,
        appBar: AppBar(),
      ),
      body: ListView(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PointsPage()));
            },
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.pollH),
              title: Text(AppLocalizations.of(context).translate('categories')),
            ),
          ),
          InkWell(
            onTap: () async {
              GoalsModel goalsModel = await GetGoals().call();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GoalsPage(goalsModel),
                ),
              );
            },
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.bullseye),
              title: Text(AppLocalizations.of(context).translate('goals_menu')),
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.photo_album),
          //   title: Text('Album'),
          // ),
          // ListTile(
          //   leading: Icon(Icons.phone),
          //   title: Text('Phone'),
          // ),
        ],
      ),
    );
  }
}
