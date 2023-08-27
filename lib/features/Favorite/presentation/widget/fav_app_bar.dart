import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavAppBar extends StatelessWidget {
  const FavAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Favorite",
            style: GoogleFonts.josefinSans(
              fontSize: 22.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
