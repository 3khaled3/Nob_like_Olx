import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

class BuildSendMassegeBuble extends StatelessWidget {
  final String containt;
  const BuildSendMassegeBuble({
    super.key,
    required this.containt,
  });

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialThree(
      text: containt,
      color: const Color(0xFF1B97F3),
      tail: false,
      textStyle: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}

class BuildResiveMassegeBuble extends StatelessWidget {
  final String containt;
  const BuildResiveMassegeBuble({
    super.key,
    required this.containt,
  });

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialThree(
      text: containt,
      color: const Color(0xFFE8E8EE),
      tail: false,
      isSender: false,
    );
  }
}
