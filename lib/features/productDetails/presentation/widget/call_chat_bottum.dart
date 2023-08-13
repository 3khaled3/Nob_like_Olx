import 'package:flutter/material.dart';
import 'package:nob/core/widget/CustomElvationBottom.dart';

class CallAndChatBottum extends StatelessWidget {
  final void Function() chatOnPressed;
  final void Function() callOnPressed;
  const CallAndChatBottum({
    super.key,
    required this.chatOnPressed,
    required this.callOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
              child: customElevationButtom(
                  text: "Chat", onPressed: chatOnPressed)),
          const SizedBox(
            width: 30,
          ),
          Expanded(
              child: CustomSideButton(
                  backgroundColor: const Color(0xFFF0F2F1),
                  text: "Call",
                  onPressed: callOnPressed,
                  padding: const EdgeInsets.all(14))),
        ],
      ),
    );
  }
}
