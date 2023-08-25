// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: non_constant_identifier_names
AppBar CategorieFindAppBar({required titel, required ontapArrow}) {
  return AppBar(
    leading: IconButton(
        onPressed: ontapArrow,
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        )),
    actions: [
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: Colors.black,
          ))
    ],
    elevation: .5,
    backgroundColor: Colors.white,
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
