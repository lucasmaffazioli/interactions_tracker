import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/presentation/add_approach_page/controller.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:cold_app/presentation/common/large_button.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../common/base_app_bar.dart';
import 'form_input/date_form_input.dart';
import 'form_input/text_form_input.dart';
import 'form_input/time_form_input.dart';

class AddApproachPage extends StatelessWidget {
  final int approachId;

  AddApproachPage({Key key, this.approachId}) : super(key: key);

  ApproachPresentation approachPresentation = ApproachPresentation();
  final AddApproachController controller = AddApproachController();

  final _formKey = GlobalKey<FormState>();

  String _requiredValidator(value) {
    if (value == null || value == '') {
      return 'Required field'.i18n;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Future<ApproachPresentation> approachPresentationFuture =
        controller.getApproach(context, approachId);

    return Scaffold(
      appBar: BaseAppBar(
        'New Approach'.i18n,
        appBar: AppBar(),
        hasBackButton: true,
      ),
      body: FutureBuilder<ApproachPresentation>(
          future: approachPresentationFuture,
          builder: (context, AsyncSnapshot snapshot) {
            // print('projectconnection state is: ${snapshot.connectionState}');
            // print('project snapshot data is: ${snapshot.data}');
            // print('project has data is: ${snapshot.hasData.toString()}');

            if (snapshot.connectionState != ConnectionState.done) {
              print('project snapshot data is: ${snapshot.data}');
              return Container(child: Text('Loading data....'));
            }
            approachPresentation = snapshot.data;
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                // autovalidate: true,
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
                                  title: 'Date'.i18n + ' *',
                                  initialValue: approachPresentation.date,
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
                                  title: 'Time'.i18n + ' *',
                                  initialValue: approachPresentation.time,
                                  onSave: ((value) {
                                    approachPresentation.time = value;
                                  }),
                                ),
                              ),
                            ],
                          ),
                          TextFormInput(
                            title: 'Name'.i18n + ' *',
                            validator: _requiredValidator,
                            initialValue: approachPresentation.name,
                            onSave: ((value) {
                              approachPresentation.name = value;
                            }),
                          ),
                          TextFormInput(
                            title: 'Summary'.i18n + ' *',
                            validator: _requiredValidator,
                            initialValue: approachPresentation.description,
                            onSave: ((value) {
                              approachPresentation.description = value;
                            }),
                          ),
                          TextFormInput(
                            title: 'Notes'.i18n,
                            maxLines: 5,
                            minLines: 3,
                            initialValue: approachPresentation.notes,
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
                    LargeButton(
                      backgroundColor: Constants.accent,
                      onPressed: () => _saveForm(context),
                      name: 'Save'.i18n,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void _saveForm(context) {
    // Validate returns true if the form is valid, otherwise false.
    print('aaaaaaaaaaa');
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      controller.saveApproach(approachPresentation);
      Navigator.maybePop(context);

      // print('approachPresentation.date');
      // print(approachPresentation.date);

      // approachPresentation.points.forEach((element) {
      //   print(element.isHeader.toString());
      //   print(element.name);
      //   print(element.value);
      // });
      // print(approachData.time);
      // print(approachData.name);
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.

    } else {
      Flushbar(
        message: "Oops... There's something missing in this form".i18n,
        duration: Duration(seconds: 3),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(20),
        borderRadius: 8,
        icon: Icon(
          FontAwesomeIcons.exclamationCircle,
          size: 28.0,
          color: Colors.red[600],
        ),
        // leftBarIndicatorColor: Colors.red[300],
      )..show(context);
    }
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
          item.headerTitle.i18n,
          iconData: item.headerIcon,
        ));
        listWidgets.add(SizedBox(height: 10));
      } else {
        listWidgets.add(_TitleWithSlider(
          id: item.id,
          name: item.name,
          value: item.value,
          fullTitle: item.fullTitle,
          icon: item.headerIcon,
          onChanged: ((double value) {
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
  final bool fullTitle;
  final IconData icon;

  const _TitleWithSlider({
    Key key,
    @required this.id,
    @required this.name,
    @required this.value,
    @required this.onChanged,
    @required this.fullTitle,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _value = value.toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Visibility(
              visible: fullTitle,
              child: Padding(
                padding: const EdgeInsets.only(right: 7),
                child: FaIcon(
                  icon,
                  color: Constants.accent2,
                ),
              ),
            ),
            Text(
              name,
              style: TextStyle(fontSize: 18),
            ),
          ],
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
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(Radius.circular(Constants.borderRadiusSmall)),
                color: Colors.white,
              ),
              child: Center(
                  child: Text(
                _value.toInt().toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Constants.accent2,
                  fontWeight: FontWeight.w500,
                ),
              )),
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
        iconData == null
            ? SizedBox.shrink()
            : FaIcon(
                iconData,
                color: Constants.accent2,
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
