import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/styles.dart';

AppBar userProfileAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      "User Profile",
      style: Styles.style22BlueW800,
    ),
    centerTitle: true,
    backgroundColor: Styles.backgroundColor,
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
