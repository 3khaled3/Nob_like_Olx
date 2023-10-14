import 'package:flutter/material.dart';
import 'package:nob/core/ProdactWidget/saleItem.dart';

import '../../../home/data/product.dart';

class FavBuilder extends StatelessWidget {
  final List<UserDataModel> users;
  final List<ProductDataModel> products;

  const FavBuilder({
    super.key,
    required this.users,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    mainAxisExtent: 250,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return SaleItem(user: users[index], product: products[index]);
                  //
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
