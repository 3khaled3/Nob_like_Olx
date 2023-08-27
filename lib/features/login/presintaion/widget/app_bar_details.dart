import 'package:flutter/material.dart';

AppBar profileDetailsAppBar(BuildContext context) {
  return AppBar(leadingWidth: 0,
    title: Text(
      "profile Details",
      style: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w800,
        color: Colors.blue[500],
      ),
    ),
    backgroundColor: Colors.white,
    elevation: .2,
    leading: const SizedBox(width: 0)
  );
}
