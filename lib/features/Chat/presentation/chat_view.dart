import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/core/utils/Cubits/ChatCubit/chat_cubit.dart';
import 'package:nob/features/Chat/presentation/widget/chat_app_bar.dart';
import 'package:nob/features/Chat/presentation/widget/message_bar.dart';
import 'package:nob/features/Chat/presentation/widget/message_builder.dart';
import '../../../core/utils/indicator.dart';
import '../../home/data/product.dart';
import '../data/message_data_model.dart';

class ChatView extends StatefulWidget {
  final UserDataModel user;
  const ChatView({super.key, required this.user});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> with WidgetsBindingObserver {
  final ScrollController scrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();

  String message = "";
  late Stream<List<MessageDataModel>> _messageStream;
  bool _isKeyboardVisible = false;
  @override
  void initState() {
    super.initState();
    _messageStream =
        BlocProvider.of<ChatCubit>(context).messagesStream(widget.user.uid!);

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    setState(() {
      _isKeyboardVisible = keyboardHeight > 0;
      if (!_isKeyboardVisible) {
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MessageDataModel>>(
        stream: _messageStream,
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
                      child: ChatAppBar(user: widget.user)),
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
                                    message: message,
                                    receiver: widget.user.uid!);
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
