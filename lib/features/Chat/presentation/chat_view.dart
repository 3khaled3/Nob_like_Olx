import 'package:flutter/material.dart';
import 'package:nob/features/Chat/presentation/widget/chat_app_bar.dart';
import 'package:nob/features/Chat/presentation/widget/masseges_bubles.dart';
import 'package:nob/features/Chat/presentation/widget/message_bar.dart';
import '../../home/data/product.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    var user = UserDataModel(
        uid: "",
        displayName: "displayName",
        phoneNumber: "phoneNumber",
        profileImage: "");

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 55),
          child: ChatAppBar(user: user)),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return BuildSendMassegeBuble();
              },
            ),
          ),
          Messagebar(),
        ],
      ),
    );
  }
}
