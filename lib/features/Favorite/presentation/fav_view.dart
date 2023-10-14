import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nob/core/utils/Cubits/FavCubit/fav_cubit.dart';
import 'package:nob/core/utils/Cubits/FitchProductCubit/fitch_product_cubit.dart';
import 'package:nob/core/utils/indicator.dart';
import 'package:nob/features/Favorite/presentation/widget/fav_app_bar.dart';
import 'package:nob/features/Favorite/presentation/widget/fav_builder.dart';

import '../../../core/utils/styles.dart';
import '../../home/data/product.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavCubit, FavState>(
      builder: (context, state) {
        if (BlocProvider.of<FitchProductCubit>(context).allProduct == null) {
          return buildCircleIndicator();
        } else {
          List<ProductDataModel> allProduct =
              BlocProvider.of<FitchProductCubit>(context).allProduct!;
          List<UserDataModel> users =
              BlocProvider.of<FitchProductCubit>(context).users!;
          List<UserDataModel> finalusers = [];
          List<ProductDataModel> finalallProduct = [];
          for (var i = 0; i < allProduct.length; i++) {
            if (allProduct[i].favorte) {
              finalallProduct.add(allProduct[i]);
              finalusers.add(users[i]);
            }
          }

          return Scaffold(
            backgroundColor: Styles.backgroundColor,
            appBar: favAppBar(context),
            body: finalallProduct.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(child: LottieBuilder.asset("assets/empity.json")),
                      Text(
                        "Favorite is empity",
                        style: GoogleFonts.lobsterTwo(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FavBuilder(
                        products: finalallProduct,
                        users: finalusers,
                      )
                    ],
                  ),
          );
        }
      },
    );
  }
}
