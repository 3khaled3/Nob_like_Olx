import 'package:flutter/material.dart';
import 'package:nob/features/contacts/presentation/widget/contact_widget.dart';
import '../../../home/data/product.dart';

class ContactListBuilder extends StatelessWidget {
  const ContactListBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return const ContactWidget(
          user: UserDataModel(
              uid: "",
              displayName: "displayName",
              phoneNumber: "phoneNumber",
              profileImage: ""),
        );
      },
    );
  }
}
