// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class customTextfaild extends StatelessWidget {
  final String labelText;
  final Function(String)? onChanged;
  final String inithialText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final int? maxLines;
  final double elevation;
  final TextStyle? labelStyle;
  const customTextfaild({
    Key? key,
    required this.labelText,
    this.onChanged,
    this.validator,
    this.inithialText = "",
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines,
    this.elevation = 0,
    this.labelStyle= const TextStyle(color: Colors.grey),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(8),
      child: TextFormField(
        initialValue: inithialText,        
        validator: validator,
        onChanged: onChanged,
        maxLines: maxLines,
        minLines: 1,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding: const EdgeInsets.only(left: 12, right: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: labelText,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          labelStyle: labelStyle,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }
}



















// class customSettingTextfaild extends StatelessWidget {
//    final String labelText;
//   final Function(String)? onChanged;
//   final String inithialText;
//   final String? Function(String?)? validator;
//   const customSettingTextfaild({
//     Key? key,
//     required this.labelText,
//     this.onChanged,
//     this.validator,
//     this.inithialText="",
//   }) : super(key: key);


//   @override
//   Widget build(BuildContext context) {
//     return
//
//   }
// }