import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nob/features/home/data/product.dart';

class Description extends StatelessWidget {
  final ProductDataModel product;
  const Description({required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            'Description of product',
            style: GoogleFonts.inter(
              color: const Color(0xFF393F42),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Text(product.description,
            style: GoogleFonts.inter(
              color: const Color(0xFF393F42),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 1.75,
            ),
          ),
        ),
      ],
    );
  }
}
