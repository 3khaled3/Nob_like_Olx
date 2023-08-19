import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/core/utils/Cubits/ChatCubit/chat_cubit.dart';
import 'package:nob/core/widget/customtextFaild.dart';
import 'package:nob/features/contacts/presentation/widget/contact_list_builder.dart';
import 'package:nob/features/contacts/presentation/widget/contacts_app_bar.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ContactsAppBar(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: customTextfaild(
                      labelText: "Search",
                      onChanged: (value) async {
                        await BlocProvider.of<ChatCubit>(context).search(value);

                      },
                    ),
                  ),
                  ContactListBuilder(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
