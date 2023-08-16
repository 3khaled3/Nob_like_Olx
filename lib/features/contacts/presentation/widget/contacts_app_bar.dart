
import 'package:flutter/material.dart';

class ContactsAppBar extends StatelessWidget {
  const ContactsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 18),
      child: Text(
        "Chats",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 22,
        ),
      ),
    );
  }
}
