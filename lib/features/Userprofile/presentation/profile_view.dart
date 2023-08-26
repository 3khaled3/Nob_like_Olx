import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/features/PersonalProfile/presentation/widget/profile_widget.dart';
import 'package:nob/features/Userprofile/presentation/widget/profile_app_bar.dart';
import '../../../core/utils/Cubits/FitchProductCubit/fitch_product_cubit.dart';
import '../../../core/utils/indicator.dart';
import '../../home/data/product.dart';

class Userprofile extends StatelessWidget {
  const Userprofile({super.key, required this.user});
  final UserDataModel user;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FitchProductCubit, FitchProductState>(
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
          if (allProduct[i].id.contains(user.uid!)) {
            finalallProduct.add(allProduct[i]);
            finalusers.add(users[i]);
          }
        }
        return Scaffold(
          appBar: userProfileAppBar(context),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                ProfileWidget(
                  user: user,
                  allproduct: finalallProduct,
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
