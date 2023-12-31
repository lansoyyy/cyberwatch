import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

Future<bool?> showToast(msg) {
  return Fluttertoast.showToast(
    backgroundColor: Colors.black,
    toastLength: Toast.LENGTH_LONG,
    msg: msg,
  );
}
