import 'package:flutter/material.dart';
import 'package:nob/features/contacts/presentation/widget/contact_widget.dart';
import 'package:nob/features/home/data/product.dart';


class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ContactWidget(
            user: UserDataModel(
                uid: "",
                displayName: "displayName",
                phoneNumber: "phoneNumber",
                profileImage: ""),
          );
        },
      ),
    );
  }
}
