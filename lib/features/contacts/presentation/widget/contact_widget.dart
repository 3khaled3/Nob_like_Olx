import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/indicator.dart';
import '../../../home/data/product.dart';

class ContactWidget extends StatelessWidget {
  final UserDataModel user;
  const ContactWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(1000000),
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
      trailing: const CircleAvatar(
        backgroundColor: Colors.red,
        radius: 13,
        child: Text("5"),
      ),
    );
  }
}
