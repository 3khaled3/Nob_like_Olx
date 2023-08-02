// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';

class titelcatogrey extends StatelessWidget {
  const titelcatogrey({
    required this.titel,
    required this.onPressed,
    super.key,
  });
  final String titel;

  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Text(
              titel,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 34,
              ),
            ),
          ),
        ),
        Center(
            child: TextButton(
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(0))),
                onPressed: onPressed,
                child: const Text(
                  "view all",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                  ),
                ))),
      ],
    );
  }
}
