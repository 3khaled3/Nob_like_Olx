import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/message_data_model.dart';
import 'masseges_bubles.dart';

class MessageBuilder extends StatefulWidget {
  final List<MessageDataModel> messages;
  const MessageBuilder({
    Key? key,
    required this.messages,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MessageBuilderState createState() => _MessageBuilderState();
}

class _MessageBuilderState extends State<MessageBuilder> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Scroll to the end initially (if messages are not empty).
    if (widget.messages.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.messages.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return widget.messages[index].sender ==
                  FirebaseAuth.instance.currentUser!.uid
              ? BuildSendMassegeBuble(
                  containt: widget.messages[index].content,
                  seen: widget.messages[index].isRead,
                  time:
                      "${widget.messages[index].timestamp.hour}:${widget.messages[index].timestamp.minute} ")
              : BuildResiveMassegeBuble(
                 time:
                      "${widget.messages[index].timestamp.hour}:${widget.messages[index].timestamp.minute} "
              ,
                
                  containt: widget.messages[index].content
                  );
        },
      ),
    );
  }
}
