// ignore_for_file: file_names

import 'package:flutter/material.dart';

Future<dynamic> showbottomSheet({required context, required widget}) {
  return showModalBottomSheet<dynamic>(
    backgroundColor: const Color.fromARGB(0, 255, 255, 255),
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      var container = Container(
        // height: MediaQuery.of(context).size.height*.6,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        child: widget,
      );
      return container;
    },
  );
}