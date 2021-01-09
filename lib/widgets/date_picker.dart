import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

class VoteDate extends StatefulWidget {
  final String title;
  final String hint;
  final IconData prefixIcon;
  final TextEditingController controller;

  const VoteDate(
      {Key key, this.title, this.hint, this.prefixIcon, this.controller})
      : super(key: key);
  @override
  _VoteDateState createState() => _VoteDateState();
}

class _VoteDateState extends State<VoteDate> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 17.0),
      child: DateTimePicker(
        controller: widget.controller,
        calendarTitle: widget.title,
        firstDate: DateTime(2020),
        lastDate: DateTime(2035),
        decoration: InputDecoration(
            fillColor: Colors.white,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
            prefixIcon: Icon(
              widget.prefixIcon,
              color: Colors.indigo[400],
            ),
            hintText: widget.hint),
      ),
    );
  }
}
