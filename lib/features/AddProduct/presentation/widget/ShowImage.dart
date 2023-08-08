// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nob/core/widget/CustomcircleIconButtom.dart';

class ImageWithDeleteIcon extends StatelessWidget {
  final File imageFile;
  final VoidCallback onTap;

  const ImageWithDeleteIcon({
    super.key,
    required this.imageFile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Image.file(
          imageFile,
          fit: BoxFit.cover,
        )),
        Positioned(
            top: 0,
            right: 0,
            child: circleIconButtom(icon: Icons.close, onTap: onTap)),
      ],
    );
  }
}

class ImageLIst extends StatefulWidget {
  final List<File?> selectedImages;

  const ImageLIst({
    required this.selectedImages,
    super.key,
  });

  @override
  State<ImageLIst> createState() => _ImageLIstState();
}

class _ImageLIstState extends State<ImageLIst> {
  var imagelist;
  @override
  void initState() {
    imagelist = widget.selectedImages;
    super.initState();
  }

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
      itemCount: imagelist.length,
      itemBuilder: (context, index) {
        return ImageWithDeleteIcon(
          imageFile: imagelist[index]!,
          onTap: () {
            imagelist.removeAt(index);
            setState(() {});
          },
        );
      },
    );
  }
}
