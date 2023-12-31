import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nob/features/home/data/product.dart';

class ProductTitle extends StatelessWidget {
  final ProductDataModel product;
  final void Function()? favoriteTap;
  const ProductTitle({
    required this.product,
    super.key,
    required this.favoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        //add product status
        title: Text(
          product.title,
          style: GoogleFonts.inter(
            color: const Color(0xFF393F42),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Text(
                '\$ ${product.price}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF393F42),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Container(
                  width: 40,
                  height: 24,
                  decoration: BoxDecoration(
                      color: const Color(0xffEFEFEF),
                      borderRadius: BorderRadius.circular(16)),
                  child: Center(
                    child: Text(
                      "${product.rating}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        trailing: InkWell(
          onTap: favoriteTap,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 46,
            height: 46,
            decoration: ShapeDecoration(
              color: Colors.grey[350],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Icon(
              product.favorte
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: product.favorte ? Colors.red : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
