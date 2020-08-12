import 'package:flutter/material.dart';

import 'base_form_input.dart';

class TimeFormInput extends StatefulWidget {
  final String title;
  final Function validator;
  final Function onSave;
  final TimeOfDay initialValue;

  const TimeFormInput(
      {Key key, @required this.title, this.validator, @required this.onSave, this.initialValue})
      : super(key: key);

  @override
  _TimeFormInputState createState() => _TimeFormInputState(title, validator, onSave);
}

class _TimeFormInputState extends State<TimeFormInput> {
  final String title;
  final Function onSave;
  final Function validator;
  final TextEditingController _controller = TextEditingController();
  TimeOfDay _selectedTime;

  _TimeFormInputState(this.title, this.validator, this.onSave);

  @override
  Widget build(BuildContext context) {
    _selectedTime = widget.initialValue ?? TimeOfDay.now();
    _controller.text =
        _selectedTime.hour.toString() + ':' + _selectedTime.minute.toString().padLeft(2, '0');
    onSave(_selectedTime);

    return BaseFormInput(
      title: title,
      child: TextFormField(
        readOnly: true,
        onTap: (() {
          _selectDate(context);
        }),
        controller: _controller,
        validator: validator,
        decoration: myInputDecoration(),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      // setState(() {
      _selectedTime = picked;
      _controller.text =
          _selectedTime.hour.toString() + ':' + _selectedTime.minute.toString().padLeft(2, '0');
      onSave(_selectedTime);
      // });
    }
  }
}
