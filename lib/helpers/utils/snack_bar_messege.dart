import 'package:flutter/material.dart';

class SnackBarMessage {
  static void get(BuildContext context, String message,
      {bool isSuccess = false}) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: const TextStyle(color: Colors.white)),
          backgroundColor: isSuccess ? Colors.green : Colors.red,
        ),
      );
  }
}
