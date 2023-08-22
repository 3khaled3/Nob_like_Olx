import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nob/features/Chat/data/message_data_model.dart';
import 'package:nob/routes.dart';
import '../../../../core/utils/indicator.dart';
import '../../../home/data/product.dart';

class ContactWidget extends StatelessWidget {
  final UserDataModel user;
  final List<MessageDataModel>? messages;
  final int unRead;

  const ContactWidget({
    super.key,
    required this.user,
    required this.messages,
    required this.unRead,
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
        subtitle:
            messages!.isEmpty ? const Text("") : Text(messages!.last.content),
        onTap: () {
          GoRouter.of(context).push(AppRouter.kchatview, extra: user);
        },
        trailing: Column(
          children: [
            messages!.isEmpty
                ? const Text("")
                : Text(
                    "${messages!.last.timestamp.hour}:${messages!.last.timestamp.minute}"),
            unRead != 0
                ? CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 13,
                    child: Text("$unRead"),
                  )
                : const SizedBox(
                    width: 0,
                  ),
          ],
        ));
  }
}
