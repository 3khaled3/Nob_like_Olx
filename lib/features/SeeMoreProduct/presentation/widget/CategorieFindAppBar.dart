// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/styles.dart';
import '../../../../routes.dart';

// ignore: non_constant_identifier_names
AppBar CategorieFindAppBar({required titel, required ontapArrow,context}) {
  return AppBar(
    leading: IconButton(
        onPressed: ontapArrow,
        icon: const Icon(
          Icons.arrow_back_ios_new,
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
    backgroundColor: Styles.backgroundColor,
    centerTitle: true,
    title: Text(
      titel,
      style: GoogleFonts.josefinSans(
        color: Colors.black,
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
