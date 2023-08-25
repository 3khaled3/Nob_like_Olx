import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/core/widget/customtextFaild.dart';
import 'package:nob/features/contacts/presentation/widget/contact_list_builder.dart';
import 'package:nob/features/contacts/presentation/widget/contacts_app_bar.dart';
import '../../../core/utils/Cubits/ContactCubit/contact_cubit.dart';
import '../../../core/utils/indicator.dart';
import '../../Chat/data/message_data_model.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    String Search = "";
    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: BlocProvider.of<ContactCubit>(context).getChatsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildCircleIndicator();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading data'),
            );
          } else {
            List<Map<String, dynamic>> finalOutput = snapshot.data!;
            finalOutput.removeWhere((map) => (map["messages"] as List).isEmpty);
            List<Map<String, dynamic>> search = [];

            return BlocBuilder<ContactCubit, ContactState>(
              builder: (context, state) {
                return Scaffold(
                  appBar: contactAppBar(context),
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: customTextfaild(
                              labelText: "Search",
                              onChanged: (value) async {
                                search.clear();
                                Search = value;
                                List a =
                                    await BlocProvider.of<ContactCubit>(context)
                                        .search(value);
                                for (var i = 0; i < a.length; i++) {
                                  List<MessageDataModel> x = [];
                                  search.add({
                                    "user": a[i],
                                    "notread": 0,
                                    "messages": x
                                  });
                                }
                              },
                            ),
                          ),
                          Search.isEmpty
                              ? ContactListBuilder(users: finalOutput)
                              : ContactListBuilder(users: search),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        });
  }

  
}
