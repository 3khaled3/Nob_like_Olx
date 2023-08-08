// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';

class customElevationButtom extends StatelessWidget {
  final Color buttomColor;
  final Color textColor;
  final void Function() onPressed;
  final String text;

  const customElevationButtom({
    required this.text,
    required this.onPressed,
    this.buttomColor = Colors.blue,
    this.textColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(14)),
        backgroundColor: MaterialStateProperty.all(
          buttomColor,
        ),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w500, color: textColor),
      ),
    );
  }
}