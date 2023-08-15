import 'package:flutter/material.dart';
import 'package:nob/features/productDetails/presentation/widget/call_chat_bottum.dart';
import 'package:nob/features/productDetails/presentation/widget/product_describtion.dart';
import 'package:nob/features/productDetails/presentation/widget/product_image.dart';
import 'package:nob/features/productDetails/presentation/widget/product_saller.dart';
import 'package:nob/features/productDetails/presentation/widget/product_title.dart';
import '../../home/data/product.dart';
import 'widget/product_details_appbar.dart';

class ProdctDetailsView extends StatelessWidget {
  final ProductDataModel product;
  final UserDataModel user;
  const ProdctDetailsView(
      {super.key, required this.product, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: productDetailsAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ProductImage(images: product.images),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: [
                        ProductTitle(product: product),
                        Saller(user: user),
                        Description(
                          product: product,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          CallAndChatBottum(
            callOnPressed: () {},
            chatOnPressed: () {},
          ),
        ],
      ),
    );
  }
}
