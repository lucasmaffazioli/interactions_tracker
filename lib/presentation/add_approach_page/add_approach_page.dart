import 'package:cold_app/core/app_localizations.dart';
import 'package:cold_app/presentation/add_approach_page/controller.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../common/base_app_bar.dart';
import 'form_input/date_form_input.dart';
import 'form_input/text_form_input.dart';
import 'form_input/time_form_input.dart';

class AddApproachPage extends StatelessWidget {
  ApproachPresentation approachPresentation = ApproachPresentation();
  final AddApproachController controller = AddApproachController();

  final _formKey = GlobalKey<FormState>();

  String _required_value_text;

  String _requiredValidator(value) {
    print('value');
    print(value);
    if (value == null || value == '') {
      return _required_value_text;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _required_value_text = AppLocalizations.of(context).translate('required_value');

    Future<ApproachPresentation> approachPresentationFuture = controller.getApproach();

    return Scaffold(
      appBar: BaseAppBar(
        AppLocalizations.of(context).translate('new_approach'),
        appBar: AppBar(),
        hasBackButton: true,
      ),
      body: FutureBuilder<ApproachPresentation>(
          future: approachPresentationFuture,
          builder: (context, AsyncSnapshot snapshot) {
            print('projectconnection state is: ${snapshot.connectionState}');
            print('project snapshot data is: ${snapshot.data}');
            print('project has data is: ${snapshot.hasData.toString()}');

            if (snapshot.connectionState != ConnectionState.done) {
              print('project snapshot data is: ${snapshot.data}');
              return Container(child: Text('Loading data....'));
            }
            ApproachPresentation approachPresentation = snapshot.data;
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                child: DateFormInput(
                                  title: AppLocalizations.of(context).translate('date') + ' *',
                                  validator: _requiredValidator,
                                  onSave: ((value) {
                                    approachPresentation.date = value;
                                  }),
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                child: TimeFormInput(
                                  title: AppLocalizations.of(context).translate('time') + ' *',
                                  onSave: ((value) {
                                    approachPresentation.time = value;
                                  }),
                                ),
                              ),
                            ],
                          ),
                          TextFormInput(
                            title: AppLocalizations.of(context).translate('name') + ' *',
                            validator: _requiredValidator,
                            onSave: ((value) {
                              approachPresentation.name = value;
                            }),
                          ),
                          TextFormInput(
                            title: AppLocalizations.of(context).translate('summary') + ' *',
                            validator: _requiredValidator,
                            onSave: ((value) {
                              approachPresentation.description = value;
                            }),
                          ),
                          TextFormInput(
                            title: AppLocalizations.of(context).translate('notes'),
                            maxLines: 5,
                            minLines: 3,
                            onSave: ((value) {
                              approachPresentation.notes = value;
                            }),
                          ),
                          _Points(
                            pointPresentation: approachPresentation.points,
                            onSave: ((value) {
                              // approachPresentation.description = value;
                              print('value on call');
                              print(value);
                            }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: RawMaterialButton(
                        fillColor: Constants.accent,
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          print('aaaaaaaaaaa');
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            print('approachPresentation.date');
                            print(approachPresentation.date);

                            approachPresentation.points.forEach((element) {
                              print(element.name);
                              print(element.value);
                            });
                            // print(approachData.time);
                            // print(approachData.name);
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.

                          }
                        },
                        child: Text(
                          AppLocalizations.of(context).translate('save'),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class _Points extends StatefulWidget {
  final List<PointPresentation> pointPresentation;
  final Function onSave;

  const _Points({@required this.pointPresentation, @required this.onSave, Key key})
      : super(key: key);

  @override
  __PointsState createState() => __PointsState();
}

class __PointsState extends State<_Points> {
  @override
  Widget build(BuildContext context) {
    List<Widget> listWidgets = [];

    // int index = 0;
    widget.pointPresentation.forEach((item) {
      // index++;
      if (item.isHeader) {
        listWidgets.add(TitleWithIcon(
          item.headerTitle,
          iconData: item.headerIcon,
        ));
        listWidgets.add(SizedBox(height: 10));
      } else {
        listWidgets.add(_TitleWithSlider(
          id: item.id,
          name: item.name,
          value: item.value,
          showTitle: item.showTitle,
          onChanged: ((double value) {
            print('New Value ' + value.toString());
            setState(() {
              item.value = value.toInt();
            });
            widget.onSave(item);
          }),
        ));
      }
    });
    return Column(
      children: listWidgets,
    );
  }
}

class _TitleWithSlider extends StatelessWidget {
  final int id;
  final String name;
  final int value;
  final Function onChanged;
  final bool showTitle;

  const _TitleWithSlider({
    Key key,
    @required this.id,
    @required this.name,
    @required this.value,
    @required this.onChanged,
    @required this.showTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _value = value.toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Visibility(
          visible: showTitle,
          child: Text(
            name,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Slider(
                value: _value,
                divisions: 10,
                min: 0,
                max: 10,
                onChanged: onChanged,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(
                    // color: Constants.accent2,
                    color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(Constants.borderRadiusSmall)),
                color: Colors.white,
              ),
              child: Center(child: Text(_value.toInt().toString())),
            )
          ],
        ),
      ],
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
