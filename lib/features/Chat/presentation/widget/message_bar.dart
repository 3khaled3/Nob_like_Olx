
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

class Messagebar extends StatelessWidget {
  const Messagebar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MessageBar(
      messageBarColor: const Color.fromARGB(82, 214, 214, 214),
      onSend: (value) async {
        // Add the code to create the collection if it doesn't exist
        // await _SendMassegeMethod(value);
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
