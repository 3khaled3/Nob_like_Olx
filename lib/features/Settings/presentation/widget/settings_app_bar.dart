import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes.dart';

AppBar settingsAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      "Settings",
      style: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w800,
        color: Colors.blue[500],
      ),
    ),
    backgroundColor: Colors.white,
    elevation: .2,
    leading: IconButton(
        onPressed: () {
          GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        )),
  );
}
