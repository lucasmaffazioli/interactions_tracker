import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/presentation/common/on_will_pop_helper.dart';
import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/domain/usecases/point_usecases.dart';
import 'package:cold_app/presentation/add_interaction_page/form_input/text_form_input.dart';
import 'package:cold_app/presentation/common/base_app_bar.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:cold_app/presentation/common/large_button.dart';
import 'package:cold_app/presentation/common/show_delete_confirmation.dart';
import 'package:flutter/material.dart';

class EditPointPage extends StatefulWidget {
  final String appBarTitle;
  final int pointId;
  final String pointName;
  final PointType pointType;
  final String item1;
  final String item2;
  final String item3;
  final String item4;
  final String item5;

  EditPointPage({
    Key key,
    @required this.appBarTitle,
    @required this.pointId,
    @required this.pointName,
    @required this.pointType,
    @required this.item1,
    @required this.item2,
    @required this.item3,
    @required this.item4,
    @required this.item5,
  }) : super(key: key);

  @override
  _EditPointPageState createState() => _EditPointPageState();
}

class _EditPointPageState extends State<EditPointPage> {
  final _formKey = GlobalKey<FormState>();

  String newName;

  String newItem1;

  String newItem2;

  String newItem3;

  String newItem4;

  String newItem5;

  bool wasModified = false;

  String _requiredValidator(String value) {
    print('value');
    print(value);
    if (value == null || value.trim() == '') {
      return 'Required field'.i18n;
    }
    return null;
  }

  Future<bool> _onWillPop() async {
    return await onWillPop(context, wasModified);
  }

  @override
  Widget build(BuildContext context) {
    newName = widget.pointName;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: BaseAppBar(
          widget.appBarTitle,
          hasBackButton: true,
          appBar: AppBar(),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            onChanged: () => wasModified = true,
            autovalidate: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Column(
                    children: <Widget>[
                      TextFormInput(
                        initialValue: widget.pointName,
                        title: 'Name'.i18n + ' *',
                        validator: _requiredValidator,
                        onSave: (value) {
                          newName = value;
                        },
                      ),
                      TextFormInput(
                        initialValue: widget.pointId.toString(),
                        title: 'Code'.i18n,
                        enabled: false,
                        onSave: null,
                      ),
                      TextFormInput(
                        initialValue: widget.item1.toString(),
                        title: 'First item'.i18n,
                        validator: _requiredValidator,
                        onSave: (value) {
                          newItem1 = value;
                        },
                      ),
                      TextFormInput(
                        initialValue: widget.item2.toString(),
                        title: 'Second item'.i18n,
                        validator: _requiredValidator,
                        onSave: (value) {
                          newItem2 = value;
                        },
                      ),
                      TextFormInput(
                        initialValue: widget.item3.toString(),
                        title: 'Third item'.i18n,
                        validator: _requiredValidator,
                        onSave: (value) {
                          newItem3 = value;
                        },
                      ),
                      TextFormInput(
                        initialValue: widget.item4.toString(),
                        title: 'Fourth item'.i18n,
                        validator: _requiredValidator,
                        onSave: (value) {
                          newItem4 = value;
                        },
                      ),
                      TextFormInput(
                        initialValue: widget.item5.toString(),
                        title: 'Fifth item'.i18n,
                        validator: _requiredValidator,
                        onSave: (value) {
                          newItem5 = value;
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Visibility(
                        visible: widget.pointType == PointType.skill,
                        child: Expanded(
                          child: LargeButton(
                              backgroundColor: Constants.red,
                              onPressed: () {
                                // if (_formKey.currentState.validate()) {
                                //   _formKey.currentState.save();
                                showDeleteConfirmationPopup(context, onConfirm: () async {
                                  await DeletePoint().call(widget.pointId);
                                  Navigator.maybePop(context);
                                }).then((value) => Navigator.maybePop(context));
                                // }
                              },
                              name: 'Delete'.i18n),
                        ),
                      ),
                      Expanded(
                        child: LargeButton(
                            backgroundColor: Constants.accent,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                SavePoint().call(
                                  widget.pointId,
                                  newName,
                                  widget.pointType,
                                  newItem1,
                                  newItem2,
                                  newItem3,
                                  newItem4,
                                  newItem5,
                                );
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
        ),
      ),
    );
  }
}
