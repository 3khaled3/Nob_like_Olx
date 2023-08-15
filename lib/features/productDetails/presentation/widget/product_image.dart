import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/indicator.dart';

class ProductImage extends StatelessWidget {
  final List<dynamic>? images;
  const ProductImage({
    required this.images,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: PageView.builder(
        itemCount: images!.length,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: images![index],
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                buildCircleIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
