import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/core/utils/Cubits/ChatCubit/chat_cubit.dart';
import 'package:nob/features/Chat/presentation/widget/chat_app_bar.dart';
import 'package:nob/features/Chat/presentation/widget/message_bar.dart';
import 'package:nob/features/Chat/presentation/widget/message_builder.dart';
import '../../../core/utils/indicator.dart';
import '../../home/data/product.dart';
import '../data/message_data_model.dart';

class ChatView extends StatelessWidget {
  final UserDataModel user;
  const ChatView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final TextEditingController textEditingController =
        TextEditingController(); // Add this line

    String message = "";

    return StreamBuilder<List<MessageDataModel>>(
        stream: BlocProvider.of<ChatCubit>(context).messagesStream(user.uid!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildCircleIndicator();
          } else if (snapshot.hasError) {
            print("========================");
            print(snapshot.error);
            return const Center(
              child: Text('Error loading data'),
            );
          } else {
            List<MessageDataModel> finalOutput = snapshot.data!;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
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
                        scrollController: scrollController,
                      ),
                      SendMessageBar(
                        onChanged: (value) {
                          message = value;
                          scrollController.jumpTo(
                              scrollController.position.maxScrollExtent);
                        },
                        onSaved: () async {
                          if (message.isNotEmpty) {
                            textEditingController.clear();
                            await BlocProvider.of<ChatCubit>(context)
                                .sendMessage(
                                    message: message, receiver: user.uid!);
                          }
                        },
                        textEditingController: textEditingController,
                      ),
                      // SizedBox(height:  MediaQuery.of(context).viewInsets.bottom,)
                    ],
                  ),
                );
              },
            );
          }
        });
  }
}
