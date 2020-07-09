import 'package:cold_app/core/app_localizations.dart';
import 'package:cold_app/domain/usecases/point_usecases.dart';
import 'package:cold_app/presentation/common/base_app_bar.dart';
import 'package:cold_app/presentation/points/edit_point_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PointsPage extends StatefulWidget {
  @override
  _PointsPageState createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  @override
  Widget build(BuildContext context) {
    List<PointPresentation> list;
    final TextEditingController _textController = TextEditingController();

    return Scaffold(
      appBar: BaseAppBar(
        AppLocalizations.of(context).translate('categories'),
        hasBackButton: true,
        appBar: AppBar(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _textController.text = '';
          showEditPopup(
              context, AppLocalizations.of(context).translate('create_category'), _textController,
              () {
            SavePoint().call(null, _textController.text, null);
            // item.name = _textController.text;
            setState(() {});
            Navigator.maybePop(context);
          });
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PointsPage()));
        },
        child: FaIcon(FontAwesomeIcons.plus),
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
                    // _textController.text = item.name;
                    // showEditPopup(
                    //     context,
                    //     AppLocalizations.of(context).translate('change_category'),
                    //     _textController, () {
                    //   SavePoint().call(item.id, _textController.text, item.pointType);
                    //   // item.name = _textController.text;
                    //   setState(() {});
                    //   Navigator.maybePop(context);
                    // });

                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => EditPointPage(
                                  appBarTitle:
                                      AppLocalizations.of(context).translate('edit_category'),
                                  pointId: item.id,
                                  pointName: item.name,
                                  pointType: item.pointType,
                                )))
                        .then((value) {
                      setState(() {});
                    });
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

  Future showEditPopup(
      BuildContext context, String title, TextEditingController _textController, Function onSave) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: TextField(
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              controller: _textController,
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () => Navigator.maybePop(context),
                child: Text(AppLocalizations.of(context).translate('cancel')),
              ),
              MaterialButton(
                onPressed: onSave,
                child: Text(AppLocalizations.of(context).translate('save')),
              ),
            ],
            // content: Stack(
            //   overflow: Overflow.visible,
            //   children: <Widget>[
            //     Positioned(
            //       right: -40.0,
            //       top: -40.0,
            //       child: InkResponse(
            //         onTap: () {
            //           Navigator.of(context).pop();
            //         },
            //         child: CircleAvatar(
            //           child: Icon(Icons.close),
            //           backgroundColor: Colors.red,
            //         ),
            //       ),
            //     ),
            //     Form(
            //       key: _formKey,
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: <Widget>[
            //           Padding(
            //             padding: EdgeInsets.all(8.0),
            //             child: TextFormField(),
            //           ),
            //           Padding(
            //             padding: EdgeInsets.all(8.0),
            //             child: TextFormField(),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: RaisedButton(
            //               child: Text("Submitß"),
            //               onPressed: () {
            //                 if (_formKey.currentState.validate()) {
            //                   _formKey.currentState.save();
            //                 }
            //               },
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          );
        });
  }
}
