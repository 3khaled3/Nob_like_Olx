import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar categoriesAppBar({required onPressed, context}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.white,
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
          onPressed: onPressed,
          icon: const Icon(
            Icons.search,
            color: Colors.black,
          ))
    ],
    elevation: .5,
    title: const Text(
      "Categories",
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
    ),
  );
}
