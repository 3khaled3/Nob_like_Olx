import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nob/core/utils/Cubits/UserOperationCubit/user_operation_cubit.dart';
import 'package:nob/core/widget/CustomElvationBottom.dart';
import 'package:nob/routes.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Center(
          child: customElevationButtom(text: "logOut", onPressed:() {
            BlocProvider.of<UserOperationCubit>(context).signOut();
            GoRouter.of(context).pushReplacement(AppRouter.start);
          },),
        ),
      ),
    );
  }
}