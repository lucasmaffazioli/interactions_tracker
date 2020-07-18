import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/domain/usecases/point_usecases.dart';
import 'package:cold_app/presentation/add_approach_page/form_input/text_form_input.dart';
import 'package:cold_app/presentation/common/base_app_bar.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:cold_app/presentation/common/large_button.dart';
import 'package:flutter/material.dart';

class EditPointPage extends StatelessWidget {
  final String appBarTitle;
  final int pointId;
  final String pointName;
  final String pointType;
  final _formKey = GlobalKey<FormState>();
  String newName;

  EditPointPage({
    Key key,
    @required this.appBarTitle,
    @required this.pointId,
    @required this.pointName,
    @required this.pointType,
  }) : super(key: key);

  String _requiredValidator(String value) {
    print('value');
    print(value);
    if (value == null || value.trim() == '') {
      return 'Required field'.i18n;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    newName = pointName;

    return Scaffold(
      appBar: BaseAppBar(
        appBarTitle,
        hasBackButton: true,
        appBar: AppBar(),
      ),
      body: Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: TextFormInput(
                initialValue: pointName,
                title: 'Name'.i18n + ' *',
                validator: _requiredValidator,
                onSave: ((value) {
                  newName = value;
                }),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: LargeButton(
                        backgroundColor: Constants.red,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            _showDeleteConfirmationPopup(context, onConfirm: () async {
                              await DeletePoint().call(pointId);
                              Navigator.maybePop(context);
                            }).then((value) => Navigator.maybePop(context));
                          }
                        },
                        name: 'Delete'.i18n),
                  ),
                  Expanded(
                    child: LargeButton(
                        backgroundColor: Constants.accent,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            SavePoint().call(pointId, newName, pointType);
                            Navigator.maybePop(context);
                          }
                        },
                        name: 'Save'.i18n),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _showDeleteConfirmationPopup(BuildContext context, {Function onConfirm}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Warning! Are you sure you want to delete this? It can't be undone".i18n),
          actions: <Widget>[
            MaterialButton(
              onPressed: () => Navigator.maybePop(context),
              child: Text('Cancel'.i18n),
            ),
            MaterialButton(
              onPressed: onConfirm,
              child: Text(
                'Delete'.i18n,
                style: TextStyle(
                  color: Constants.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
