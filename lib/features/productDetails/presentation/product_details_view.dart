import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nob/features/productDetails/presentation/widget/call_chat_bottum.dart';
import 'package:nob/features/productDetails/presentation/widget/product_describtion.dart';
import 'package:nob/features/productDetails/presentation/widget/product_image.dart';
import 'package:nob/features/productDetails/presentation/widget/product_saller.dart';
import 'package:nob/features/productDetails/presentation/widget/product_title.dart';
import '../../../core/utils/Cubits/FavCubit/fav_cubit.dart';
import '../../../core/utils/Cubits/FitchProductCubit/fitch_product_cubit.dart';
import '../../../core/utils/funcation/lunch_phone_num.dart';
import '../../../core/utils/styles.dart';
import '../../../routes.dart';
import '../../home/data/product.dart';
import 'widget/product_details_appbar.dart';

class ProdctDetailsView extends StatelessWidget {
  final ProductDataModel product;
  final UserDataModel user;
  const ProdctDetailsView(
      {super.key, required this.product, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavCubit, FavState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Styles.backgroundColor,
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
                          ProductTitle(
                            product: product,
                            favoriteTap: () async {
                              final favCubit =
                                  BlocProvider.of<FavCubit>(context);
                              // final fetchProductCubit =
                                  BlocProvider.of<FitchProductCubit>(context);

                              product.favorte = !product.favorte;
                              await favCubit.addToFav(product.id);
                              
                            },
                          ),
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
              callOnPressed: () async {
                await lunchPhoneNum(user.phoneNumber!);
              },
              chatOnPressed: () {
                GoRouter.of(context).push(AppRouter.kchatview, extra: user);
              },
            ),
          ],
        ),
      );
    });
  }
}
