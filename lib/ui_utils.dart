import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String text) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: Duration(seconds: 1),
    ),
  );
}

const bold = TextStyle(fontWeight: FontWeight.bold);
const link = TextStyle(color: Color(0xFF3F729B));
