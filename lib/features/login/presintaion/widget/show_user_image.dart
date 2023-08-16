import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/indicator.dart';

class ShowUserImage extends StatelessWidget {
  final void Function()? onPressed;
  const ShowUserImage({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  imageUrl: FirebaseAuth.instance.currentUser!.photoURL!,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
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
              onPressed: onPressed,
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
    );
  }
}
