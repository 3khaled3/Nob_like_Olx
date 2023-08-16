import 'package:flutter/material.dart';
import 'package:nob/core/widget/customtextFaild.dart';
import 'package:nob/features/contacts/presentation/widget/contact_list_builder.dart';
import 'package:nob/features/contacts/presentation/widget/contacts_app_bar.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContactsAppBar(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: customTextfaild(
                  labelText: "Search",
                ),
              ),
              ContactListBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
