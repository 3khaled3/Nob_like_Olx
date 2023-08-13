// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';

class titelcatogrey extends StatelessWidget {
  const titelcatogrey({
    required this.titel,
    required this.onPressed,
    this.titelfontSize=28,
    super.key,
  });
  final String titel;
  final double? titelfontSize;

  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        titel,maxLines: 1,overflow: TextOverflow.ellipsis,
        style:  TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize:titelfontSize,
        ),
      ),
      trailing: TextButton(
          style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.all(0))),
          onPressed: onPressed,
          child: const Text(
            "See more",
            style: TextStyle(
              color: Colors.black,
              fontSize: 11,
              fontWeight: FontWeight.normal,
            ),
          )),
    );
  }
}
