import 'package:flutter/material.dart';

import '../main.dart';
import '../ui/dialog/loading.dart';

void showInSnackBar(String value) {
  ScaffoldMessenger.of(navigatorKey.currentContext!)
      .showSnackBar(SnackBar(content: Text(value,textAlign: TextAlign.center,)));
}

void opendialog(BuildContext context) async {
  DialogBuilder(context).showLoaderDialog(context);
}

void hideOpenDialog(BuildContext context) async {
  DialogBuilder(context).hideOpenDialog();
}