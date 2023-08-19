import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/core/utils/Cubits/ChatCubit/chat_cubit.dart';

class Messagebar extends StatelessWidget {
  final String resever;
  const Messagebar({
    super.key,
    required this.resever,
  });

  @override
  Widget build(BuildContext context) {
    return MessageBar(
      messageBarColor: const Color.fromARGB(82, 214, 214, 214),
      onSend: (value) async {
        await BlocProvider.of<ChatCubit>(context)
            .sendMessage(message: value, receiver: resever);
      },
      actions: [
        InkWell(
          child: const Icon(
            Icons.add,
            color: Colors.black,
            size: 24,
          ),
          onTap: () {},
        ),
        const SizedBox(width: 4),
        InkWell(
          child: const Icon(
            Icons.camera_alt,
            color: Colors.blue,
            size: 24,
          ),
          onTap: () {},
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}
