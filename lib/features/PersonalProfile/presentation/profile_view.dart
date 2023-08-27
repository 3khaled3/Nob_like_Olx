import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/features/PersonalProfile/presentation/widget/profile_app_bar.dart';
import 'package:nob/features/PersonalProfile/presentation/widget/profile_widget.dart';
import '../../../core/utils/Cubits/FitchProductCubit/fitch_product_cubit.dart';
import '../../../core/utils/indicator.dart';
import '../../home/data/product.dart';

class PresonalProfileView extends StatelessWidget {
  const PresonalProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FitchProductCubit, FitchProductState>(
        builder: (context, state) {
          
    User currentUser = FirebaseAuth.instance.currentUser!;
    final user = UserDataModel(
        fcmToken:
            "fB-1m7snSPWivCJVnP9GFl:APA91bEuLNP8-Ki-N3diKRngVWoAJZH0fqRDeN-Pbxn2icCwBuTA9o6TFhOPJj_TUvPMoTunBJrCQ5arbDHObgOoOVH37Vsjy_bAJJaOw9v1EwScR1Gk9ebyfEADBtTKNrzpaAjWJcPL",
        uid: currentUser.uid,
        displayName: currentUser.displayName,
        phoneNumber: currentUser.phoneNumber,
        profileImage: null);
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
          if (allProduct[i].id.contains(currentUser.uid)) {
            finalallProduct.add(allProduct[i]);
            finalusers.add(users[i]);
          }
        }
        return Scaffold(backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const ProfileAppBar(),
                  ProfileWidget(
                    user: user,
                    allproduct: finalallProduct,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}

// customElevationButtom(
//             text: "logOut",
//             onPressed: () {
//               BlocProvider.of<UserOperationCubit>(context).signOut();
//               GoRouter.of(context).pushReplacement(AppRouter.start);
//             },
//           )