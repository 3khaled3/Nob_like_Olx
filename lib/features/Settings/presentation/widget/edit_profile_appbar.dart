import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/styles.dart';

AppBar editProfileAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      "Edit Profile",
      style: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w800,
        color: Colors.blue[500],
      ),
    ),
    backgroundColor: Styles.backgroundColor,
    elevation: .2,
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
