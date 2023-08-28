// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class circleIconButtom extends StatelessWidget {
  final icon;
  final Color? colorbottom;
  final iconColor;
  final double? iconsize;
  final void Function()? onTap;
  const circleIconButtom({
    this.iconColor,
    this.colorbottom = const Color.fromARGB(95, 158, 158, 158),
    required this.icon,
    required this.onTap,
    this.iconsize = 16,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Material(
        color: colorbottom,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Icon(
            icon,
            color: iconColor,
            size: iconsize,
          ),
        ),
      ),
    );
  }
}

class CustomLikeButton extends StatelessWidget {
  // final double buttonSize;
  //  final icon;
  final Color? colorbottom;
  final iconColor;
  final double? iconsize;
  // final void Function()? onTap;
  final bool liked;
  final Future<bool?> Function(bool)? isliked;
  // final Future<bool?> Function(bool)? onTap;

  const CustomLikeButton({
    this.iconColor,
    this.colorbottom = const Color.fromARGB(95, 158, 158, 158),
    // required this.onTap,
    this.iconsize = 16,
    super.key, this.isliked, required this.liked,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Material(
        color: colorbottom,
        shape: const CircleBorder(),
        child: InkWell(
          // onTap: onTap,
          customBorder: const CircleBorder(),
          child: LikeButton(isLiked: liked,
            size: iconsize!,
            circleColor:
                CircleColor(start: Colors.red[300]!, end: Colors.red[300]!),
            bubblesColor: BubblesColor(
              dotPrimaryColor: Colors.red[800]!,
              dotSecondaryColor: Colors.red[300]!,
            ),
            likeBuilder: (bool isLiked) {
              return Icon(
                isLiked
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: isLiked ? Colors.red : Colors.white,
                size: iconsize!,
              );
            },
            onTap:isliked
          ),
        ),
      ),
    );
  }
}
