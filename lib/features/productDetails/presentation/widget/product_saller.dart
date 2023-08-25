import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nob/core/widget/CustomElvationBottom.dart';
import 'package:nob/features/home/data/product.dart';

import '../../../../core/utils/indicator.dart';

class Saller extends StatelessWidget {
  final UserDataModel user;
  const Saller({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1),
        ListTile(
          title: Text(
            user.displayName == null || user.displayName!.isEmpty
                ? "user"
                : user.displayName!,
            style: GoogleFonts.inter(
              color: const Color(0xFF393F42),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            'online 12 mins ago',
            style: GoogleFonts.inter(
              color: const Color(0xFF939393),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: ClipRRect(
              borderRadius: BorderRadius.circular(100000),
              child: user.profileImage == null || user.profileImage!.isEmpty
                  ? SvgPicture.asset(
                      "assets/defultprofile.svg",
                      fit: BoxFit.cover,
                      height: 49,
                      width: 49,
                    )
                  : CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 49,
                      width: 49,
                      imageUrl: "${user.profileImage}",
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              buildCircleIndicator(),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    )),
          trailing: CustomSideButton(
            text: "Follow",
            onPressed: () {},
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
