import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showCustomToast(BuildContext context, String message,
    {bool isError = false}) {
  final color = isError ? Colors.red : Theme.of(context).primaryColor;
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16,
  );
}
