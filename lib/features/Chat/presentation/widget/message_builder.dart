import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/message_data_model.dart';
import 'masseges_bubles.dart';

class MessageBuilder extends StatelessWidget {
  final List<MessageDataModel> messages;
  final ScrollController scrollController ;
  const MessageBuilder({
    Key? key,
    required this.messages, required this.scrollController,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemCount: messages.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return messages[index].sender ==
                  FirebaseAuth.instance.currentUser!.uid
              ? BuildSendMassegeBuble(type:messages[index].type,
                  containt: messages[index].content,
                  seen: messages[index].isRead,
                  time:
                      "${messages[index].timestamp.hour}:${messages[index].timestamp.minute} ")
              : BuildResiveMassegeBuble(type:messages[index].type,
                 time:
                      "${messages[index].timestamp.hour}:${messages[index].timestamp.minute} "
              ,
                
                  containt: messages[index].content
                  );
        },
      ),
    );
  }
}
