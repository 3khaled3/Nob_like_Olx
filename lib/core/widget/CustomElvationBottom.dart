// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class customElevationButtom extends StatelessWidget {
  final Color buttomColor;
  final Color textColor;
  final void Function() onPressed;
  final String text;
  final double borderRadius ;

  const customElevationButtom({
    required this.text,
    required this.onPressed,
    this.buttomColor = Colors.blue,
    this.textColor = Colors.white,
    super.key,  this.borderRadius=4,
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
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      child: Text(text,
          style: GoogleFonts.inter(
            color: textColor,
            // fontSize: 14,
            fontWeight: FontWeight.w500,
          )),
    );
  }
}

class CustomSideButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;

  const CustomSideButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.padding,
      this.backgroundColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding,
        elevation: 0,
        shadowColor: const Color.fromARGB(0, 255, 86, 34),
        foregroundColor: Colors.grey,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(
            width: 0.50,
            color: Color(0xFFD9D9D9),
          ),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: const Color(0xFF393F42),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
