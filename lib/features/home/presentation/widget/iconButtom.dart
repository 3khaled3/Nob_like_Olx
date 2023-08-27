// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: camel_case_types
class iconButtom extends StatelessWidget {
  final void Function()? onTap;
  final IconData? icon;
  final double elvation;

  const iconButtom({
    required this.icon,
    required this.onTap,
    this.elvation = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Material(
          // Wrap with Material to add elevation
          elevation: elvation, // Adjust the elevation value as needed
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            child: InkWell(
              onTap: onTap,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Icon(
                  icon,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ));
  }
}
