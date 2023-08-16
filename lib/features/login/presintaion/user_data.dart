import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nob/core/utils/Cubits/RegisterCubit/register_cubit.dart';

import '../../../core/utils/indicator.dart';

class UserData extends StatelessWidget {
  const UserData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
         return  Scaffold(
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
              :  Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10000),
                      child: FirebaseAuth.instance.currentUser!.photoURL == null
                          ? SvgPicture.asset(
                              "assets/defultprofile.svg",
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  FirebaseAuth.instance.currentUser!.photoURL!,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      buildCircleIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Center(child: Icon(Icons.error)),
                            ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: RawMaterialButton(
                          onPressed: () async {
                               await BlocProvider.of<RegisterCubit>(context)
                                .updateProfilePhoto();
                            // final state = BlocProvider.of<AuthCubit>(context).state;
                            // if (state is success) {
                            //   showSnackbarMessage(
                            //     context,
                            //     "Success",
                            //     Colors.green,
                            //   );
                            // } else if (state is error) {
                            //   final errorMessage = (state).errorMessage;
                            //   showSnackbarMessage(context, errorMessage, Colors.red);
                            // }
                          },
                          elevation: 2.0,
                          fillColor: const Color.fromARGB(255, 38, 141, 120),
                          padding: EdgeInsets.zero,
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.camera_alt_sharp,
                            size: 22,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
      },
    );
  }
}
