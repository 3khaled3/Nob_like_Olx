import 'package:flutter/material.dart';

class CustomNavItem extends StatelessWidget {
  final IconData activeIcon;
  final IconData inactiveIcon;
  final bool isActive;
  final Color activeColor;
  final Color activetextColor;
  final Color inactiveColor;
  final String label;
  final Function() onPressed;

  const CustomNavItem({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.isActive,
    this.activeColor = const Color(0xff3A78FF),
    this.activetextColor = const Color(0xff0F172A),
    this.inactiveColor = const Color(0xff64748B),
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(0, 255, 193, 7),
      child: InkWell(
        splashColor: const Color.fromARGB(0, 255, 193, 7),
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : inactiveIcon,
              color: isActive ? activeColor : inactiveColor,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isActive ? activetextColor : inactiveColor,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
