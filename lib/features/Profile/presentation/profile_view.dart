import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nob/features/Profile/presentation/widget/profile_app_bar.dart';
import 'package:nob/features/Profile/presentation/widget/profile_widget.dart';
import '../../home/data/product.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    User currentUser = FirebaseAuth.instance.currentUser!;
    final user = UserDataModel(
        fcmToken:
            "fB-1m7snSPWivCJVnP9GFl:APA91bEuLNP8-Ki-N3diKRngVWoAJZH0fqRDeN-Pbxn2icCwBuTA9o6TFhOPJj_TUvPMoTunBJrCQ5arbDHObgOoOVH37Vsjy_bAJJaOw9v1EwScR1Gk9ebyfEADBtTKNrzpaAjWJcPL",
        uid: currentUser.uid,
        displayName: currentUser.displayName,
        phoneNumber: currentUser.phoneNumber,
        profileImage: null);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const ProfileAppBar(),
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