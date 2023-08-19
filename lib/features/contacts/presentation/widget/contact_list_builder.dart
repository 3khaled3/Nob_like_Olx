import 'package:flutter/material.dart';
import 'package:nob/features/contacts/presentation/widget/contact_widget.dart';

class ContactListBuilder extends StatelessWidget {
  final List<Map<String, dynamic>> users;
  const ContactListBuilder({
    required this.users,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ContactWidget(
          // "user": user, "notread": notread, "messages": messages
          user: users[index]["user"],
          messages: users[index]["messages"],
          unRead: users[index]["notread"],
        );
      },
    );
  }
}
