// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class customTextfaild extends StatelessWidget {
  final String labelText;
  final Function(String)? onChanged;
  final String inithialText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? borderRadius;
  final String? Function(String?)? validator;
  final int? maxLines;
  final double elevation;
  final TextStyle? labelStyle;
  final TextInputType? keyboardType;
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
    this.keyboardType,
    this.labelStyle = const TextStyle(color: Colors.grey),
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius!),
      child: TextFormField(
        initialValue: inithialText,
        validator: validator,
        onChanged: onChanged,
        maxLines: maxLines,
        minLines: 1,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding: const EdgeInsets.only(left: 12, right: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: labelText,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: const BorderSide(color: Colors.red),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          labelStyle: labelStyle,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }
}


class SendMessageTextfaild extends StatelessWidget {
  final String labelText;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? borderRadius;
  final String? Function(String?)? validator;
  final int? maxLines;
  final textEditingController;
  final double elevation;
  final TextStyle? labelStyle;
  final TextInputType? keyboardType;
  const SendMessageTextfaild({
    Key? key,
    required this.labelText,
    this.onChanged,
    this.textEditingController,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines,
    this.elevation = 0,
    this.keyboardType,
    this.labelStyle = const TextStyle(color: Colors.grey),
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius!),
      child: TextFormField(
         controller: textEditingController, 
        validator: validator,
        onChanged: onChanged,
        maxLines: maxLines,
        minLines: 1,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding: const EdgeInsets.only(left: 12, right: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: labelText,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: const BorderSide(color: Colors.red),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          labelStyle: labelStyle,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }
}
