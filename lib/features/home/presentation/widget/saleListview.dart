// ignore_for_file: file_names, camel_case_types
import 'package:flutter/material.dart';
import '../../../../core/ProdactWidget/saleItem.dart';
import '../../data/product.dart';

class saleListView extends StatelessWidget {
  // final List<Product> products;
  const saleListView({
    super.key,
    //  required this.products
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SaleItem(
            // product: products[index]
            ),
        SizedBox(width: 20,),
        SaleItem(
              // product: products[index]
              ),
        // ),
      ],
    );
  }
}
