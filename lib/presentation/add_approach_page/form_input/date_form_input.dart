import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'base_form_input.dart';

class DateFormInput extends StatefulWidget {
  final String title;
  final Function validator;
  final Function onSave;
  final DateTime initialValue;

  const DateFormInput(
      {Key key, @required this.title, this.validator, @required this.onSave, this.initialValue})
      : super(key: key);

  @override
  _DateFormInputState createState() => _DateFormInputState(title, validator, onSave);
}

class _DateFormInputState extends State<DateFormInput> {
  final String title;
  final Function onSave;
  final Function validator;
  final TextEditingController _controller = TextEditingController();
  DateTime _selectedDate;

  _DateFormInputState(this.title, this.validator, this.onSave);

  @override
  Widget build(BuildContext context) {
    _selectedDate = widget.initialValue ?? DateTime.now();
    _controller.text = DateFormat('dd/MM/yyyy').format(_selectedDate);

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
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != _selectedDate) _selectedDate = picked;
    _controller.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
    onSave(_selectedDate);
  }
}
