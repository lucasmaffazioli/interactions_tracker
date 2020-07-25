import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/domain/usecases/point_usecases.dart';
import 'package:cold_app/presentation/add_approach_page/form_input/text_form_input.dart';
import 'package:cold_app/presentation/common/base_app_bar.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:cold_app/presentation/common/large_button.dart';
import 'package:cold_app/presentation/common/show_delete_confirmation.dart';
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
              child: Column(
                children: <Widget>[
                  TextFormInput(
                    initialValue: pointName,
                    title: 'Name'.i18n + ' *',
                    validator: _requiredValidator,
                    onSave: ((value) {
                      newName = value;
                    }),
                  ),
                  TextFormInput(
                    initialValue: pointId.toString(),
                    title: 'Code'.i18n,
                    enabled: false,
                    onSave: () {},
                  ),
                ],
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
                            showDeleteConfirmationPopup(context, onConfirm: () async {
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
}
