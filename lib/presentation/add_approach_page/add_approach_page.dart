import 'package:cold_app/presentation/common/show_delete_confirmation.dart';
import 'package:cold_app/presentation/common/snack_bar.dart';
import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/presentation/add_approach_page/controller.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:cold_app/presentation/common/large_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../common/base_app_bar.dart';
import 'form_input/date_form_input.dart';
import 'form_input/text_form_input.dart';
import 'form_input/time_form_input.dart';

class AddApproachPage extends StatefulWidget {
  final int approachId;

  AddApproachPage({Key key, this.approachId}) : super(key: key);

  @override
  _AddApproachPageState createState() => _AddApproachPageState();
}

class _AddApproachPageState extends State<AddApproachPage> {
  ApproachPresentation approachPresentation = ApproachPresentation();

  final AddApproachController controller = AddApproachController();

  final _formKey = GlobalKey<FormState>();

  bool wasModified = false;

  String _requiredValidator(value) {
    if (value == null || value == '') {
      return 'Required field'.i18n;
    }
    return null;
  }

  Future<bool> _onWillPop() async {
    if (wasModified) {
      await showConfirmationPopup(
        context,
        text: 'You have unsaved changes, do you really want to exit?'.i18n,
        buttonConfirmText: 'Yes'.i18n,
        buttonCancelText: 'Cancel'.i18n,
        onConfirm: () => Navigator.of(context).pop(true),
      ).then((value) {
        if (value.toString() == 'Confirmed') {
          Navigator.of(context).pop(true);
        }
      });
    } else {
      Navigator.pop(context, true);
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    Future<ApproachPresentation> approachPresentationFuture =
        controller.getApproach(context, widget.approachId);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
              print('approachPresentation.toJson');
              print(approachPresentation.points[0].item1);
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  // autovalidate: true,
                  onChanged: () => wasModified = true,
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
                                    // wasModified: _wasModified,
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
      ),
    );
  }

  void _saveForm(context) {
    // Validate returns true if the form is valid, otherwise false.
    print('aaaaaaaaaaa');
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      controller.saveApproach(approachPresentation);
      // Navigator.maybePop(context);
      Navigator.pop(context);

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
      // SnackBarError("Oops... There's something missing in this form".i18n)..show(context);
      // snackBarError("Oops... There's something missing in this form".i18n)..show(context);
      SnackBarHelper.createError(message: "Oops... There's something missing in this form".i18n)
        ..show(context);
      // Flushbar(
      //   message: "Oops... There's something missing in this form".i18n,
      //   duration: Duration(seconds: 3),
      //   margin: const EdgeInsets.all(8),
      //   padding: const EdgeInsets.all(20),
      //   borderRadius: 8,
      //   icon: Icon(
      //     FontAwesomeIcons.exclamationCircle,
      //     size: 28.0,
      //     color: Colors.red[600],
      //   ),
      //   // leftBarIndicatorColor: Colors.red[300],
      // )..show(context);
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
          item.headerTitle,
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
          item1: item.item1,
          item2: item.item2,
          item3: item.item3,
          item4: item.item4,
          item5: item.item5,
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
  final String item1;
  final String item2;
  final String item3;
  final String item4;
  final String item5;

  const _TitleWithSlider({
    Key key,
    @required this.id,
    @required this.name,
    @required this.value,
    @required this.onChanged,
    @required this.fullTitle,
    this.icon,
    @required this.item1,
    @required this.item2,
    @required this.item3,
    @required this.item4,
    @required this.item5,
  }) : super(key: key);

  String _getLabel(value) {
    String returnValue;
    switch (value) {
      case 1:
        {
          returnValue = item1;
        }
        break;

      case 2:
        {
          returnValue = item2;
        }
        break;
      case 3:
        {
          returnValue = item3;
        }
        break;
      case 4:
        {
          returnValue = item4;
        }
        break;
      case 5:
        {
          returnValue = item5;
        }
        break;

      default:
        {
          returnValue = 'Error';
        }
        break;
    }
    return returnValue;
  }

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
                divisions: Constants.maxPoints - 1,
                min: Constants.minPoints.toDouble(),
                max: Constants.maxPoints.toDouble(),
                onChanged: onChanged,
                label: _getLabel(_value),
                onChangeStart: (value) {
                  print('Slider value');
                  print(value);
                },
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
