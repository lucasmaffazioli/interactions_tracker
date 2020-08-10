import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/data/models/approach/goals_model.dart';
import 'package:cold_app/domain/usecases/goals_usecases.dart';
import 'package:cold_app/presentation/add_approach_page/form_input/text_form_input.dart';
import 'package:cold_app/presentation/common/base_app_bar.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:cold_app/presentation/common/large_button.dart';
import 'package:flutter/material.dart';

class GoalsPage extends StatelessWidget {
  final GoalsModel goalsModel;

  final _formKey = GlobalKey<FormState>();

  GoalsPage(
    this.goalsModel, {
    Key key,
  }) : super(key: key);

  String _weeklyGoalsValidator(value) {
    if (value == null || value == '') {
      return 'Required field'.i18n;
    }

    final n = num.tryParse(value);
    if (n == null) {
      return '$value ' + ' is not a number!'.i18n;
    }

    if (n > 100) {
      return 'The maximum value for weekly goals is 100!'.i18n;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        'Goals'.i18n,
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
                textInputType: TextInputType.number,
                initialValue: goalsModel.weeklyApproachGoal.toString(),
                title: 'Weekly approaches'.i18n + ' *',
                validator: _weeklyGoalsValidator,
                onSave: ((value) {
                  SaveGoals().call(int.parse(value));
                }),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: LargeButton(
                      backgroundColor: Constants.accent,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Navigator.maybePop(context);
                        }
                      },
                      name: 'Save'.i18n,
                    ),
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
