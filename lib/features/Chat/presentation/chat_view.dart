import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/core/utils/Cubits/ChatCubit/chat_cubit.dart';
import 'package:nob/features/Chat/presentation/widget/chat_app_bar.dart';
import 'package:nob/features/Chat/presentation/widget/masseges_bubles.dart';
import 'package:nob/features/Chat/presentation/widget/message_bar.dart';
import '../../../core/utils/indicator.dart';
import '../../home/data/product.dart';
import '../data/message_data_model.dart';

class ChatView extends StatelessWidget {
  final UserDataModel user;
  const ChatView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MessageDataModel>>(
        stream: BlocProvider.of<ChatCubit>(context).messagesStream(user.uid!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildCircleIndicator();
          } else if (snapshot.hasError) {
            print("========================");
            print(snapshot.error);
            print("========================");
            return const Center(
              child: Text('Error loading data'),
            );
          } else {
            List<MessageDataModel> finalOutput = snapshot.data!;
            return BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
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
                      MessageBuilder(messages: finalOutput,),
                      Messagebar(resever:user.uid!,),
                    ],
                  ),
                );
              },
            );
          }
        });
  }
}

class MessageBuilder extends StatelessWidget {
  final List<MessageDataModel> messages;
  const MessageBuilder({
    super.key,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return messages[index].sender ==
                  FirebaseAuth.instance.currentUser!.uid
              ? BuildSendMassegeBuble(containt:messages[index].content,)
              : BuildResiveMassegeBuble(containt:messages[index].content);
        },
      ),
    );
  }
}
