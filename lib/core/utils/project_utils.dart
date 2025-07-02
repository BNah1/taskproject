import 'package:flutter/material.dart';

void showToast(
  BuildContext context,
  String message,
  String title,
  String optionText,
) {
  if (context.mounted) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(optionText),
            ),
          ],
        );
      },
    );
  }
}
