import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: PageView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Image.asset(
            "assets/categories/Vehicles.jpg",
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
