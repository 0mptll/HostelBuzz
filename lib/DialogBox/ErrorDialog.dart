import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String content;

  ErrorDialog({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

void showErrorDialog(BuildContext context, {required String title, required String content}) {
  showDialog(
    context: context,
    builder: (context) {
      return ErrorDialog(title: title, content: content);
    },
  );
}