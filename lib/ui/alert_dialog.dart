import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String title, String message) {

  // set up the button
  Widget okButton = TextButton(
    key: Key('okButton'),
    child: Text("OK"),
    onPressed: () { Navigator.of(context).pop(); } // dismiss dialog
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}