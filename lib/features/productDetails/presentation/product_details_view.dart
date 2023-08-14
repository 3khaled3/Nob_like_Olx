import 'package:flutter/material.dart';
import 'package:nob/features/productDetails/presentation/widget/call_chat_bottum.dart';
import 'package:nob/features/productDetails/presentation/widget/product_describtion.dart';
import 'package:nob/features/productDetails/presentation/widget/product_image.dart';
import 'package:nob/features/productDetails/presentation/widget/product_saller.dart';
import 'package:nob/features/productDetails/presentation/widget/product_title.dart';
import 'widget/product_details_appbar.dart';

class ProdctDetailsView extends StatelessWidget {
  const ProdctDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: productDetailsAppBar(context),
      body: Column(
        children: [
          const Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  ProductImage(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: [
                        ProductTitle(),
                        Saller(),
                        Description(),
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
