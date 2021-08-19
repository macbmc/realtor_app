import 'package:flutter/material.dart';

class ErrorAlertDialogue extends StatelessWidget {
  final String  Message;
  const ErrorAlertDialogue({Key key, this.Message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      content: Text(Message),
      actions: [
        RaisedButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Center(child: Text("OK")),
        )
      ],
    );
  }
}