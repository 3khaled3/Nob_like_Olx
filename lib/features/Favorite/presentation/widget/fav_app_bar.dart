import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/styles.dart';
import '../../../../routes.dart';

AppBar favAppBar(BuildContext context) {
  return AppBar(
    title: const Text(
      "Favorite",
      style: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w800,
        color: Colors.black,
      ),
    ),
    centerTitle: true,
    backgroundColor: Styles.backgroundColor,
    elevation: 0,
    leading: const SizedBox(width: 0),
    actions: [
      IconButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kSearchView);
          },
          icon: const Icon(
            Icons.search,
            color: Colors.black,
          )),
    ],
  );
}
