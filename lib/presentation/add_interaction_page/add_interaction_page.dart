import 'package:cold_app/presentation/common/on_will_pop_helper.dart';
import 'package:cold_app/presentation/common/snack_bar.dart';
import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/presentation/add_interaction_page/controller.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:cold_app/presentation/common/large_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../common/base_app_bar.dart';
import 'form_input/date_form_input.dart';
import 'form_input/text_form_input.dart';
import 'form_input/time_form_input.dart';

class AddInteractionPage extends StatefulWidget {
  final int interactionId;

  AddInteractionPage({Key key, this.interactionId}) : super(key: key);

  @override
  _AddInteractionPageState createState() => _AddInteractionPageState();
}

class _AddInteractionPageState extends State<AddInteractionPage> {
  InteractionPresentation interactionPresentation = InteractionPresentation();

  final AddInteractionController controller = AddInteractionController();

  final _formKey = GlobalKey<FormState>();

  bool wasModified = false;

  String _requiredValidator(value) {
    if (value == null || value == '') {
      return 'Required field'.i18n;
    }
    return null;
  }

  Future<bool> _onWillPop() async {
    return await onWillPop(context, wasModified);
  }

  @override
  Widget build(BuildContext context) {
    Future<InteractionPresentation> interactionPresentationFuture =
        controller.getInteraction(context, widget.interactionId);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: BaseAppBar(
          'New Interaction'.i18n,
          appBar: AppBar(),
          hasBackButton: true,
        ),
        body: FutureBuilder<InteractionPresentation>(
            future: interactionPresentationFuture,
            builder: (context, AsyncSnapshot snapshot) {
              // print('projectconnection state is: ${snapshot.connectionState}');
              // print('project snapshot data is: ${snapshot.data}');
              // print('project has data is: ${snapshot.hasData.toString()}');

              if (snapshot.connectionState != ConnectionState.done) {
                print('project snapshot data is: ${snapshot.data}');
                return Container(child: Text('Loading data....'));
              }
              interactionPresentation = snapshot.data;
              print('interactionPresentation.toJson');
              print(interactionPresentation.points[0].item1);
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
                                    initialValue: interactionPresentation.date,
                                    validator: _requiredValidator,
                                    // wasModified: _wasModified,
                                    onSave: ((value) {
                                      interactionPresentation.date = value;
                                    }),
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Expanded(
                                  child: TimeFormInput(
                                    title: 'Time'.i18n + ' *',
                                    initialValue: interactionPresentation.time,
                                    onSave: ((value) {
                                      interactionPresentation.time = value;
                                    }),
                                  ),
                                ),
                              ],
                            ),
                            TextFormInput(
                              title: 'Name'.i18n + ' *',
                              validator: _requiredValidator,
                              initialValue: interactionPresentation.name,
                              onSave: ((value) {
                                interactionPresentation.name = value;
                              }),
                            ),
                            TextFormInput(
                              title: 'Summary'.i18n + ' *',
                              validator: _requiredValidator,
                              initialValue: interactionPresentation.description,
                              onSave: ((value) {
                                interactionPresentation.description = value;
                              }),
                            ),
                            TextFormInput(
                              title: 'Notes'.i18n,
                              maxLines: 5,
                              minLines: 3,
                              initialValue: interactionPresentation.notes,
                              onSave: ((value) {
                                interactionPresentation.notes = value;
                              }),
                            ),
                            _Points(
                                pointPresentation: interactionPresentation.points,
                                onSave: ((value) {
                                  // interactionPresentation.description = value;
                                  print('value on call');
                                  print(value);
                                }),
                                onAnyChange: ((value) {
                                  wasModified = true;
                                })),
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

      controller.saveInteraction(interactionPresentation);
      // Navigator.maybePop(context);
      Navigator.pop(context);

      // print('interactionPresentation.date');
      // print(interactionPresentation.date);

      // interactionPresentation.points.forEach((element) {
      //   print(element.isHeader.toString());
      //   print(element.name);
      //   print(element.value);
      // });
      // print(interactionData.time);
      // print(interactionData.name);
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
  final Function onAnyChange;

  const _Points(
      {@required this.pointPresentation, @required this.onSave, this.onAnyChange, Key key})
      : super(key: key);

  @override
  __PointsState createState() => __PointsState();
}

class __PointsState extends State<_Points> {
  @override
  Widget build(BuildContext context) {
    List<Widget> listWidgets = [];

    widget.pointPresentation.forEach((item) {
      if (item.isHeader) {
        listWidgets.add(TitleWithIcon(
          item.headerTitle.i18n, // Specially for the PointType.skill title
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
            widget.onAnyChange(value);
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
