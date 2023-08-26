import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar userProfileAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      "User Profile",
      style: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w800,
        color: Colors.blue[500],
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
        onPressed: () {
          GoRouter.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        )),
  );
}
