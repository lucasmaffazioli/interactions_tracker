import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/domain/usecases/point_usecases.dart';
import 'package:cold_app/presentation/common/base_app_bar.dart';
import 'package:cold_app/presentation/points/controller.dart';
import 'package:cold_app/presentation/points/edit_point_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PointsPage extends StatefulWidget {
  @override
  _PointsPageState createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  PointsController controller = PointsController();

  @override
  Widget build(BuildContext context) {
    List<PointPresentation> list;

    return Scaffold(
      appBar: BaseAppBar(
        'Categories'.i18n,
        hasBackButton: true,
        appBar: AppBar(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => EditPointPage(
                        appBarTitle: 'Edit category'.i18n,
                        pointId: null,
                        pointName: null,
                        pointType: null,
                      )))
              .then((value) {
            setState(() {});
          });
        },
        child: FaIcon(FontAwesomeIcons.plus),
      ),
      body: Container(
        child: FutureBuilder<List<PointPresentation>>(
          future: controller.getAllPoints(),
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
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => EditPointPage(
                                  appBarTitle: 'Edit category'.i18n,
                                  pointId: item.id,
                                  pointName: item.name,
                                  pointType: item.pointType,
                                )))
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: ListTile(
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
