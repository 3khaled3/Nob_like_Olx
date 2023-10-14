import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/styles.dart';

AppBar searchAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      "Search",
      style:Styles.style22BlueW800,
    ),

    backgroundColor: Styles.backgroundColor,
    elevation: 0.2,
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
