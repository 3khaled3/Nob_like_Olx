// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nob/features/Settings/presentation/widget/info.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class appinfo extends StatelessWidget {
  const appinfo({super.key});
  final String info =
      "https://firebasestorage.googleapis.com/v0/b/wechat-d43c1.appspot.com/o/info.jpg?alt=media&token=47a94fb9-f2cf-4dd3-8f5e-debeb4ec6cec";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: aboutusAppBar(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            BuildImageSection(),
            const SizedBox(
              height: 16,
            ),
            Text(
              "khaled tarek",
              style: GoogleFonts.pacifico(
                color: Colors.black,
                fontSize: 32,
              ),
            ),
            const Text(
              "FLUTTER DEVELOPER",
              style: TextStyle(
                color: Color.fromARGB(255, 105, 105, 105),
                fontSize: 16,
              ),
            ),
            const Divider(
                thickness: 1,
                color: Color.fromARGB(255, 105, 105, 105),
                endIndent: 30,
                indent: 30),
            BuildViewData("01273793869", Icons.phone, () async {
              Uri phoneno = Uri.parse('tel:+201273793869');
              if (await launchUrl(phoneno)) {
                //dialer opened
              } else {
                //dailer is not opened
              }
            }),
            BuildViewData("dev.khaledtarek@gmail.com", Icons.email, () async {
              String email = Uri.encodeComponent("dev.khaledtarek@gmail.com");
              String subject = Uri.encodeComponent("Hello Khaled");
              Uri mail = Uri.parse("mailto:$email?subject=$subject");
              if (await launchUrl(mail)) {
                //email app opened
              } else {
                //email app is not opened
              }
            }),
            const Spacer(),
            const Spacer(),
          ],
        ));
  }

  CircleAvatar BuildImageSection() {
    return CircleAvatar(
      radius: 112,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(info),
        radius: 110,
      ),
    );
  }

  BuildViewData(data, icon, onTap) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.circular(30),
            ),
            child: ListTile(
              title: Text(
                data,
                style: const TextStyle(fontSize: 20),
              ),
              leading: Icon(icon),
            ),
          ),
        ));
  }
}
