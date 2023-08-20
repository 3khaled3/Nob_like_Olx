
import 'package:flutter/material.dart';
import 'package:nob/core/ProdactWidget/saleItem.dart';

import '../../../home/data/product.dart';

class FavBuilder extends StatelessWidget {
  const FavBuilder({
    super.key,
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
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 250,
                              mainAxisExtent: 285,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return SaleItem(
                          user: UserDataModel(
                              displayName: "khaled",
                              phoneNumber: "+201234567890",
                              profileImage:
                                  "https://firebasestorage.googleapis.com/v0/b/nob-d0c2f.appspot.com/o/profile_photos%2FR2oEofDmNWab5F2TGBx8vKgz0Lg1%2FIMG_20230712_091049.jpg?alt=media&token=66b8b5e1-0d1f-487f-a3e7-163f19cc4590",
                              uid: "R2oEofDmNWab5F2TGBx8vKgz0Lg1"),
                          product: ProductDataModel(
                            images: [
                              "https://firebasestorage.googleapis.com/v0/b/nob-d0c2f.appspot.com/o/ads%2FR2oEofDmNWab5F2TGBx8vKgz0Lg1%2F2023-08-18-15-19-23-IMG_20230712_091049.jpg?alt=media&token=cb297227-a00d-4f35-81ec-9b84bca8d56b"
                            ],
                            price: 555555,
                            category: "Mobile Phones, Tablets, & Accessories",
                            description: "lol",
                            rating: "1 / 10",
                            status: "New",
                            title: "hi",
                          ),
                        );
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
