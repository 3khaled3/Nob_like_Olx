import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

class BuildSendMassegeBuble extends StatelessWidget {
  const BuildSendMassegeBuble({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const BubbleSpecialThree(
      text: "a",
      color: Color(0xFF1B97F3),
      tail: false,
      textStyle: TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}

class BuildResiveMassegeBuble extends StatelessWidget {
  const BuildResiveMassegeBuble({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const BubbleSpecialThree(
      text: "aaaa", // Use the actual message content here
      color: Color(0xFFE8E8EE),
      tail: false,
      isSender: false,
    );
  }
}
