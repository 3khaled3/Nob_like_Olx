import 'package:flutter/material.dart';

import '../../../../core/utils/styles.dart';

AppBar profileDetailsAppBar(BuildContext context) {
  return AppBar(leadingWidth: 0,
    title: Text(
      "profile Details",
      style: Styles.style22BlueW800,
    ),
    backgroundColor: Styles.backgroundColor,
    elevation: .2,
    leading: const SizedBox(width: 0)
  );
}
