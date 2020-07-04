import 'package:cold_app/presentation/add_approach_page/controller.dart';
import 'package:cold_app/presentation/add_approach_page/form_input/base_form_input.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../common/base_app_bar.dart';
import 'form_input/date_form_input.dart';
import 'form_input/text_form_input.dart';
import 'form_input/time_form_input.dart';

class AddApproachPage extends StatelessWidget {
  ApproachData approachData = ApproachData();

  final _formKey = GlobalKey<FormState>();

  String _requiredValidator(value) {
    print('value');
    print(value);
    if (value == null || value == '') {
      return 'Valor obrigaório!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        'Nova Abordagem',
        appBar: AppBar(),
        hasBackButton: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: DateFormInput(
                      title: 'Data *',
                      validator: _requiredValidator,
                      onSave: ((value) {
                        approachData.date = value;
                      }),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: TimeFormInput(
                      title: 'Hora *',
                      onSave: ((value) {
                        approachData.time = value;
                      }),
                    ),
                  ),
                ],
              ),
              TextFormInput(
                title: 'Nome *',
                validator: _requiredValidator,
                onSave: ((value) {
                  approachData.name = value;
                }),
              ),
              TextFormInput(
                title: 'Resumo *',
                validator: _requiredValidator,
                onSave: ((value) {
                  approachData.description = value;
                }),
              ),
              TextFormInput(
                title: 'Notas',
                maxLines: 5,
                minLines: 3,
                onSave: ((value) {
                  approachData.notes = value;
                }),
              ),
              TitleWithIcon(
                'Habilidades',
                iconData: FontAwesomeIcons.pollH,
              ),
              BaseFormInput(
                title: 'aaaa',
                // child: Slider(
                //   value: 5,
                // ),
              ),
              RaisedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, otherwise false.
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    print('approachData.date');
                    print(approachData.date);
                    print(approachData.time);
                    print(approachData.name);
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.

                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleWithIcon extends StatelessWidget {
  final String title;
  final IconData iconData;

  const TitleWithIcon(
    this.title, {
    Key key,
    @required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FaIcon(
          iconData,
          color: Constants.mainTextColor,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: Constants.textH1,
        ),
      ],
    );
  }
}
