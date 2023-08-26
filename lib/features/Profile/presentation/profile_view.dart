import 'package:flutter/material.dart';
import 'package:nob/features/Profile/presentation/widget/profile_app_bar.dart';
import 'package:nob/features/Profile/presentation/widget/profile_widget.dart';
import '../../home/data/product.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    const user = UserDataModel(
        fcmToken:
            "fB-1m7snSPWivCJVnP9GFl:APA91bEuLNP8-Ki-N3diKRngVWoAJZH0fqRDeN-Pbxn2icCwBuTA9o6TFhOPJj_TUvPMoTunBJrCQ5arbDHObgOoOVH37Vsjy_bAJJaOw9v1EwScR1Gk9ebyfEADBtTKNrzpaAjWJcPL",
        uid: "uzeCpT8SUFWHc3Jkmpo4Ky4rtzs2",
        displayName: "Khaled tarek",
        phoneNumber: "+201234567890",
        profileImage: null);
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ProfileAppBar(),
              ProfileWidget(user: user),
            ],
          ),
        ),
      ),
    );
  }
}

// customElevationButtom(
//             text: "logOut",
//             onPressed: () {
//               BlocProvider.of<UserOperationCubit>(context).signOut();
//               GoRouter.of(context).pushReplacement(AppRouter.start);
//             },
//           )