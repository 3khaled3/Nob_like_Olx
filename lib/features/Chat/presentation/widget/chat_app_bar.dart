import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/indicator.dart';
import '../../../home/data/product.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({
    super.key,
    required this.user,
  });

  final UserDataModel user;

  @override
   build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: .5,
      leadingWidth: MediaQuery.sizeOf(context).width * .09,
      leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
      title: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
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
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      buildCircleIndicator(),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                ),
        ),
        title: Text("${user.displayName}"),
        subtitle: Text("${user.phoneNumber}"),
        onTap: () {},
      ),
    );
  }
}