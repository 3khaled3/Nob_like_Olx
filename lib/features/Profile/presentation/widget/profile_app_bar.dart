
import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 16),
        Text(
          "Profile",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w800,
            color: Colors.blue[500],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
