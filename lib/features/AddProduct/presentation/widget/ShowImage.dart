import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/core/widget/CustomcircleIconButtom.dart';

import '../../../../core/utils/Cubits/AddProductCubit/add_product_cubit.dart';

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
  const ImageLIst({
    super.key,
  });

  @override
  State<ImageLIst> createState() => _ImageLIstState();
}

class _ImageLIstState extends State<ImageLIst> {
  @override
  Widget build(BuildContext context) {
    final imagelist = BlocProvider.of<AddProductCubit>(context).selectedImages;
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
