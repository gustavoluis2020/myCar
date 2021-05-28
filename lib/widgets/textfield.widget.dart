import 'package:flutter/material.dart';

class TextField2 extends StatelessWidget {
  const TextField2({
    Key key,
    @required this.controller,
    @required this.labelText,
    @required this.validatorText,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final String validatorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        validator: (texto) {
          if (texto == null || texto.isEmpty) {
            return validatorText;
          }
        },
        decoration: InputDecoration(
          fillColor: Colors.green[700],
          filled: true,
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 5,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30)),
        ),
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
        onChanged: (u) {},
        keyboardType: TextInputType.number);
  }
}
