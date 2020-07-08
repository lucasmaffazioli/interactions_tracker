import 'package:cold_app/core/app_localizations.dart';
import 'package:cold_app/domain/usecases/point_usecases.dart';
import 'package:cold_app/presentation/common/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PointsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<PointPresentation> list;

    return Scaffold(
      appBar: BaseAppBar(
        AppLocalizations.of(context).translate('categories'),
        hasBackButton: true,
        appBar: AppBar(),
      ),
      body: Container(
        child: FutureBuilder<List<PointPresentation>>(
          future: GetAllPoints().call(),
          builder: (context, AsyncSnapshot snapshot) {
            print('projectconnection state is: ${snapshot.connectionState}');
            print('project snapshot data is: ${snapshot.data}');
            print('project has data is: ${snapshot.hasData.toString()}');

            if (snapshot.connectionState != ConnectionState.done && snapshot.hasData) {
              print('project snapshot data is: ${snapshot.data}');
              print('project snapshot error is: ${snapshot.error}');
              return Container(child: Text('Loading data....'));
            }
            list = snapshot.data ?? [];
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];

                return InkWell(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PointsPage()));
                  },
                  child: ListTile(
                    // leading: item.(FontAwesomeIcons.pollH),
                    title: Text(item.name),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
