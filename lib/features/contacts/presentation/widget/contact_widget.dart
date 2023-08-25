import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    String time = " ";
    String suptitel = " ";
    try {
      DateTime now = DateTime.now();
      DateTime messageTime = messages!.last.timestamp;
      if (now.year == messageTime.year &&
          now.month == messageTime.month &&
          now.day == messageTime.day) {
        // Message was sent today, show the time
        time = '${messageTime.hour}:${messageTime.minute}';
      } else {
        // Message was sent on a different day, show the date in "d/m/y" format
        time = '${messageTime.day}/${messageTime.month}/${messageTime.year}';
      }
      // ignore: empty_catches
    } catch (e) {}
    if (messages!.isNotEmpty) {
      suptitel =
          messages!.last.sender == FirebaseAuth.instance.currentUser!.uid ? "you" : 
              "${user.displayName}";
      suptitel +=
          " : ${messages!.last.type == "String" ?"\" ${messages!.last.content} \" " : "Image"}";
    }
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
        subtitle: Text(
          suptitel,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          GoRouter.of(context).push(AppRouter.kchatview, extra: user);
        },
        trailing: Column(
          children: [
            Text(time),
            // : Text(
            //     "${messages!.last.timestamp.hour}:${messages!.last.timestamp.minute}"),
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
