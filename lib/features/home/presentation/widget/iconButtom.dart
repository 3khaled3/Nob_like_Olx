import 'package:flutter/material.dart';

class iconButtom extends StatelessWidget {
  final void Function()? onTap;
  final IconData? icon;

  const iconButtom({
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Icon(
              icon,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
