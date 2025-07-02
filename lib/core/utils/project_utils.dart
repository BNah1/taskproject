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

void _showModal(BuildContext context, Widget child) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.4,
        child: child,
      );
    },
  );
}