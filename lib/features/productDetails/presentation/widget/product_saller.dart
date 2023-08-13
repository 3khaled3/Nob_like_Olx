import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nob/core/widget/CustomElvationBottom.dart';

class Saller extends StatelessWidget {
  const Saller({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1),
        ListTile(
          title: Text(
            'Apple Store',
            style: GoogleFonts.inter(
              color: const Color(0xFF393F42),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            'online 12 mins ago',
            style: GoogleFonts.inter(
              color: const Color(0xFF939393),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              "assets/categories/Vehicles.jpg",
              fit: BoxFit.cover,
              width: 49,
              height: 49,
            ),
          ),
          trailing: CustomSideButton(text: "Follow", onPressed:() {
            
          },),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
