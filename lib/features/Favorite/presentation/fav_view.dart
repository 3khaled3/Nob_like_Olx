import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/core/utils/Cubits/FavCubit/fav_cubit.dart';
import 'package:nob/core/utils/Cubits/FitchProductCubit/fitch_product_cubit.dart';
import 'package:nob/features/Favorite/presentation/widget/fav_app_bar.dart';
import 'package:nob/features/Favorite/presentation/widget/fav_builder.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavCubit, FavState>(
      builder: (context, state) {
       var x= BlocProvider.of<FitchProductCubit>(context).allProduct;
        print(x);
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [const FavAppBar(), FavBuilder()],
            ),
          ),
        );
      },
    );
  }
}
