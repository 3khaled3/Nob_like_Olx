import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/styles.dart';
import '../../../../routes.dart';

AppBar settingsAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      "Settings",
      style: Styles.style22BlueW800,
    ),
    backgroundColor: Styles.backgroundColor,
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
