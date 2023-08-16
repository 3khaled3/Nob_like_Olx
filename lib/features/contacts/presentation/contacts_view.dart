import 'package:flutter/material.dart';
import 'package:nob/core/widget/customtextFaild.dart';
import 'package:nob/features/contacts/presentation/widget/contact_widget.dart';
import 'package:nob/features/contacts/presentation/widget/contacts_app_bar.dart';
import 'package:nob/features/home/data/product.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ContactsAppBar(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: customTextfaild(
                  labelText: "Search",
                ),
              ),
              ListView.builder(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
