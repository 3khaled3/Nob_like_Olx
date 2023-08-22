import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/core/utils/Cubits/ChatCubit/chat_cubit.dart';
import 'package:nob/features/Chat/presentation/widget/chat_app_bar.dart';
import 'package:nob/features/Chat/presentation/widget/masseges_bubles.dart';
import 'package:nob/features/Chat/presentation/widget/message_bar.dart';
// import 'package:nob/features/Chat/presentation/widget/message_builder.dart';
import '../../../core/utils/indicator.dart';
import '../../home/data/product.dart';
import '../data/message_data_model.dart';

class ChatView extends StatelessWidget {
  final UserDataModel user;
  const ChatView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

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
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollController
                  .jumpTo(_scrollController.position.maxScrollExtent);
            });
            return BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                return Scaffold(
                  backgroundColor: Colors.grey[200],
                  appBar: PreferredSize(
                      preferredSize: const Size(double.infinity, 55),
                      child: ChatAppBar(user: user)),
                  body: Column(
                    children: [
                      MessageBuilder(
                        messages: finalOutput,
                        controller: _scrollController,
                      ),
                      GestureDetector(
                        onTap: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _scrollController.jumpTo(
                                _scrollController.position.maxScrollExtent);
                          });
                        },
                        child: Messagebar(
                          resever: user.uid!,
                        ),
                      ),
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
  final ScrollController controller;
  const MessageBuilder({
    super.key,
    required this.messages,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: controller,
        itemCount: messages.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return messages[index].sender ==
                  FirebaseAuth.instance.currentUser!.uid
              ? BuildSendMassegeBuble(
                  containt: messages[index].content,
                  seen: messages[index].isRead,
                  time:
                      "${messages[index].timestamp.hour}:${messages[index].timestamp.minute} ")
              : BuildResiveMassegeBuble(
                  time:
                      "${messages[index].timestamp.hour}:${messages[index].timestamp.minute} ",
                  containt: messages[index].content);
        },
      ),
    );
  }
}
