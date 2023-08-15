// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class circleIconButtom extends StatelessWidget {
  final icon;
  final Color? colorbottom;
  final iconColor;
  final double? iconsize;
  final void Function()? onTap;
  const circleIconButtom({
    this.iconColor,
    this.colorbottom = const Color.fromARGB(95, 158, 158, 158),
    required this.icon,
    required this.onTap,
    this.iconsize = 16,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Material(
        color: colorbottom,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Icon(
            icon,
            color: iconColor,
            size: iconsize,
          ),
        ),
      ),
    );
  }
}
