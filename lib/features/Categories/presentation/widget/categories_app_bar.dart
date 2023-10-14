import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/styles.dart';
import '../../../../routes.dart';

AppBar categoriesAppBar({context}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Styles.backgroundColor,
    leading: IconButton(
        onPressed: () {
          GoRouter.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        )),
    actions: [
      IconButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kSearchView);
          },
          icon: const Icon(
            Icons.search,
            color: Colors.black,
          ))
    ],
    elevation: .2,
    title: const Text(
      "Categories",
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
    ),
  );
}
