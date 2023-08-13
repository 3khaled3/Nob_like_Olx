import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductTitle extends StatelessWidget {
  const ProductTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          'Air pods max by Apple',
          style: GoogleFonts.inter(
            color: const Color(0xFF393F42),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            '\$ 1999,99',
            style: GoogleFonts.inter(
              color: const Color(0xFF393F42),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        trailing: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 46,
            height: 46,
            decoration: ShapeDecoration(
              color: const Color(0x19939393),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: const Icon(Icons.favorite_border_rounded),
          ),
        ),
      ),
    );
  }
}
