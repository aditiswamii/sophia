import 'package:flutter/material.dart';

class DialogBuilder {

  DialogBuilder(this.context);

  final BuildContext context;

  showLoaderDialog(BuildContext context,String message) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(left: 7), child: Text(message)),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void hideOpenDialog() {
    Navigator.of(context).pop();
  }
}