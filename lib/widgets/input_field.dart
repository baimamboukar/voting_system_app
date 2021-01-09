import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final String label;
  final TextInputType type;
  final TextEditingController controller;

  const InputField(
      {Key key,
      this.hintText,
      this.prefixIcon,
      this.label,
      this.type,
      this.controller})
      : super(key: key);
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 17.0),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.type,
        validator: (value) {
          if (value.isEmpty) {
            return 'Lorem ipsum validate';
          }
          return 'Validated';
        },
        decoration: InputDecoration(
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
          prefixIcon: Icon(
            widget.prefixIcon,
            color: Colors.indigo[400],
          ),
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
