import 'package:flutter/material.dart';

class ElevatedButton2 extends StatelessWidget {
  ElevatedButton2({
    Key key,
    this.buttonName,
    this.onPressed,
    this.chaveFormulario,
  }) : super(key: key);

  String buttonName;
  VoidCallback onPressed;
  var chaveFormulario;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ElevatedButton(
        child: Text(buttonName),
        style: ElevatedButton.styleFrom(
          primary: Colors.green[700], // background
          onPrimary: Colors.white,
          shadowColor: Colors.black,
          elevation: 10,

          textStyle: TextStyle(fontSize: 20),
          shape: (RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.white, width: 2),
          )), // foreground
        ),
        onPressed: onPressed,
      ),
    );
  }
}
