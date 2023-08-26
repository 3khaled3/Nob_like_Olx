
  import 'package:url_launcher/url_launcher.dart';

Future<void> lunchPhoneNum(phoneNumber) async {
    String url = 'tel:$phoneNumber';
                bool x = await canLaunchUrl(Uri.parse(url));
                if (x) {
     await launchUrl(Uri.parse(url));
                } else {
     throw 'Could not launch $url';
                }
  }