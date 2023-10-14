import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/styles.dart';

AppBar aboutusAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      "About us",
      style: Styles.style22BlueW800,
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
