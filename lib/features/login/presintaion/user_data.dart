import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/core/utils/Cubits/RegisterCubit/register_cubit.dart';
import 'package:nob/features/login/presintaion/widget/show_user_image.dart';
import '../../../core/utils/indicator.dart';
import '../../../../core/widget/tossetMassage.dart';

class UserData extends StatelessWidget {
  const UserData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                margin: const EdgeInsets.symmetric(vertical: 40),
                child: SizedBox(
                  height: 115,
                  width: 115,
                  child: state is Waitting
                      ? buildCircleIndicator()
                      : ShowUserImage(onPressed: () async {
                          await BlocProvider.of<RegisterCubit>(context)
                              .updateProfilePhoto();
                          final state =
                              // ignore: use_build_context_synchronously
                              BlocProvider.of<RegisterCubit>(context).state;
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
            ],
          ),
        );
      },
    );
  }
}
