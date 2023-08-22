import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

class BuildSendMassegeBuble extends StatelessWidget {
  final String containt;
  final String time;
  final bool seen;
  const BuildSendMassegeBuble({
    super.key,
    required this.containt,
    required this.seen,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          height: 4,
        ),
        BubbleSpecialThree(
          sent: true,
          seen: seen,
          text: containt,
          color: const Color(0xFF1B97F3),
          tail: false,
          textStyle: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Text(
            time,
            style: const TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ),
      ],
    );
  }
}

class BuildResiveMassegeBuble extends StatelessWidget {
  final String containt;
  final String time;
  const BuildResiveMassegeBuble({
    super.key,
    required this.containt,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 4,
        ),
        BubbleSpecialThree(
          text: containt,
          color: const Color(0xFFE8E8EE),
          tail: false,
          isSender: false,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Text(
            time,
            style: const TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ),
      ],
    );
  }
}
