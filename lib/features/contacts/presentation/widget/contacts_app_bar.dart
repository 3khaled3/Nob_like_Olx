import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar contactAppBar(BuildContext context) {
  return AppBar(
    centerTitle: false,
    titleSpacing: 0,
    leadingWidth: 0,
    leading: const SizedBox(
      width: 0,
    ),
    title: Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        const Text(
          "Chats",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 22,
          ),
        ),
      ],
    ),
    backgroundColor: Colors.white,
    elevation: 0,
  );
}
