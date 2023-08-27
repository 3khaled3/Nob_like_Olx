import 'package:url_launcher/url_launcher.dart';

Future<void> lunchPhoneNum(phoneNumber) async {
  try {
    Uri phoneno = Uri.parse('tel:$phoneNumber');
    if (await launchUrl(phoneno)) {
      }
  } catch (e) {
    // ignore: avoid_print
    print(e.toString());
  }
}
