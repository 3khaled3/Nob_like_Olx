import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar productDetailsAppBar() {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.white,
    leading: IconButton(
        onPressed: () {},
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
