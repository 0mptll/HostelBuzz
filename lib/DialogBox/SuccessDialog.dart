import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final String title;
  final String content;

  SuccessDialog({required this.title, required this.content});

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

void showSuccessDialog(BuildContext context, {required String title, required String content}) {
  showDialog(
    context: context,
    builder: (context) {
      return SuccessDialog(title: title, content: content);
    },
  );
}
