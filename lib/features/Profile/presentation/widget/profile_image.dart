
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/indicator.dart';

class ProfileImage extends StatelessWidget {
  final String? profileImage;
  const ProfileImage({
    super.key,
    this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 120),
      margin: const EdgeInsets.only(bottom: 8),
      height: 115,
      width: 115,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10000),
        child: profileImage == null
            ? SvgPicture.asset(
                "assets/defultprofile.svg",
                fit: BoxFit.cover,
              )
            : CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: profileImage!,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    buildCircleIndicator(),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
      ),
    );
  }
}
