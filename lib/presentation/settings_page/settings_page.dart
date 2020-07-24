import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/data/models/approach/goals_model.dart';
import 'package:cold_app/presentation/common/base_app_bar.dart';
import 'package:cold_app/presentation/goals/goals_page.dart';
import 'package:cold_app/presentation/points/points_page.dart';
import 'package:cold_app/presentation/settings_page/controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cold_app/domain/usecases/goals_usecases.dart';

class SettingsPage extends StatelessWidget {
  SettingsController controller = SettingsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        'Settings'.i18n,
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
              title: Text('Categories'.i18n),
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
              title: Text('Goals'.i18n),
            ),
          ),
          InkWell(
            onTap: () async {
              await controller.export();
            },
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.fileExport),
              title: Text('Export approaches'.i18n),
            ),
          ),
          InkWell(
            onTap: () async {
              await controller.import();
            },
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.fileImport),
              title: Text('Import approaches'.i18n),
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
