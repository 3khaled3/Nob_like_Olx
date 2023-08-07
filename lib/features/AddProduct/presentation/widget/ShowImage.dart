import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nob/core/widget/CustomcircleIconButtom.dart';

class ImageWithDeleteIcon extends StatelessWidget {
  final File imageFile;
  final VoidCallback onTap;

  const ImageWithDeleteIcon({
    required this.imageFile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Display the image
        Positioned.fill(
            child: Image.file(
          imageFile,
          fit: BoxFit.cover,
        )),
        // Positioned widget to place the delete icon in the top-right corner
        Positioned(
            top: 0,
            right: 0,
            child: circleIconButtom(icon: Icons.close, onTap: onTap)),
      ],
    );
  }
}

class ImageLIst extends StatefulWidget {
  final List<File?> imagelist;
  const ImageLIst({super.key, required this.imagelist});

  @override
  State<ImageLIst> createState() => _ImageLIstState();
}

class _ImageLIstState extends State<ImageLIst> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: widget.imagelist.length,
      itemBuilder: (context, index) {
        return ImageWithDeleteIcon(
          imageFile: widget.imagelist[index]!,
          onTap: () {
            widget.imagelist.removeAt(index);
            setState(() {});
          },
        );
      },
    );
  }
}
