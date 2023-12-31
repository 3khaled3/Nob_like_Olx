import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/styles.dart';

AppBar productDetailsAppBar(context) {
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
    title: Text('Details product',
        style: GoogleFonts.inter(
          textStyle: const TextStyle(
            color: Color(0xFF393F42),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        )),
    elevation: 0,
  );
}
