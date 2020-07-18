import 'package:cold_app/core/app_localizations.dart';
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

  String _required_value_text;
  String _not_valid_numer_text;

  GoalsPage(
    this.goalsModel, {
    Key key,
  }) : super(key: key);

  String _weeklyGoalsValidator(value) {
    if (value == null || value == '') {
      return _required_value_text;
    }

    final n = num.tryParse(value);
    if (n == null) {
      return '$value ' + _not_valid_numer_text;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _required_value_text = AppLocalizations.of(context).translate('required_field');
    _not_valid_numer_text = AppLocalizations.of(context).translate('not_valid_numer_field');

    return Scaffold(
      appBar: BaseAppBar(
        AppLocalizations.of(context).translate('goals_menu'),
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
                title: AppLocalizations.of(context).translate('weekly_approaches_goal') + ' *',
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
                        name: AppLocalizations.of(context).translate('save')),
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
