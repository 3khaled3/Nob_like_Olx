import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/styles.dart';

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
         Text(
          "Chats",
          style: Styles.style22BlueW800
        ),
      ],
    ),
    backgroundColor: Styles.backgroundColor,
    elevation: 0.2,
  );
}
