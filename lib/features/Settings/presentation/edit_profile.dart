import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nob/core/utils/Cubits/UserOperationCubit/user_operation_cubit.dart';
import 'package:nob/core/widget/CustomElvationBottom.dart';
import 'package:nob/core/widget/customtextFaild.dart';
import 'package:nob/features/Settings/presentation/widget/edit_profile_appbar.dart';
import 'package:nob/features/login/presintaion/widget/show_user_image.dart';
import '../../../core/utils/indicator.dart';
import '../../../../core/widget/tossetMassage.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String? newusername;
    return BlocBuilder<UserOperationCubit, UserOperationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: editProfileAppBar(context),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 120),
                    margin: const EdgeInsets.only(top: 20, bottom: 40),
                    child: SizedBox(
                      height: 115,
                      width: 115,
                      child: state is Waitting
                          ? buildCircleIndicator()
                          : ShowUserImage(onPressed: () async {
                              await BlocProvider.of<UserOperationCubit>(context)
                                  .updateProfilePhoto();
                              final state =
                                  // ignore: use_build_context_synchronously
                                  BlocProvider.of<UserOperationCubit>(context)
                                      .state;
                              if (state is Success) {
                                showToastMessage(
                                  "Your image has been updated",
                                  Colors.green,
                                );
                              } else if (state is Error) {
                                final errorMessage = (state).errorMessage;
                                showToastMessage(errorMessage, Colors.red);
                              }
                            }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: customTextfaild(
                      labelText: "Username",
                      inithialText:
                          FirebaseAuth.instance.currentUser!.displayName ?? "",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        } else {
                          newusername = value;

                          return null;
                        }
                      },
                    ),
                  ),
                  // Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: customElevationButtom(
                        text: "Save",
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await BlocProvider.of<UserOperationCubit>(context)
                                .updateDisplayName(newusername!);
                            final state =
                                // ignore: use_build_context_synchronously
                                BlocProvider.of<UserOperationCubit>(context)
                                    .state;
                            if (state is Success) {
                              // ignore: use_build_context_synchronously
                              GoRouter.of(context).pop();

                              showToastMessage(
                                "Username has been updated",
                                Colors.green,
                              );
                            } else if (state is Error) {
                              final errorMessage = (state).errorMessage;
                              showToastMessage(errorMessage, Colors.red);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
