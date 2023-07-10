import 'package:flutter/material.dart';

class CustomAlertDialog {
  static void basic(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(text),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Done"),
          )
        ],
      ),
    );
  }
}
