import 'package:flutter/material.dart';

import '../../../../core/widget/customtextFaild.dart';


class SendMessageBar extends StatelessWidget {
  final dynamic Function(String)? onChanged;
  final void Function()? onSaved;
  
  final TextEditingController textEditingController;

  const SendMessageBar({
    super.key,
    required this.onChanged,
    required this.onSaved,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(82, 214, 214, 214),
      height: 60,
      width: double.infinity,
      child: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.blue,
              )),
          Expanded(
              child: SendMessageTextfaild(
                          textEditingController: textEditingController,
                          labelText: "Type your message",
                          borderRadius: 300,
                          onChanged: onChanged,
                        ),
              ),
          IconButton(
              onPressed: onSaved,
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.blue,
              )),
        ],
      ),
    );
  }
}
