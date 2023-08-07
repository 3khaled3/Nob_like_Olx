// ignore_for_file: file_names, camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nob/core/constant.dart';

class HomeCategory extends StatelessWidget {
  const HomeCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [];
    for (var categoryData in categories) {
      var categoryName = categoryData.keys.first;
      var imagePath = categoryData.values.first;
      items.add(homeCard(
        categoriesImage: imagePath,
        categoriesTitel: categoryName,
      ));
    }
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 110,
            width: double.infinity,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return items[index];
              },
            ),
          ),
        ),
      ],
    );
  }
}

class homeCard extends StatelessWidget {
  const homeCard({
    super.key,
    required this.categoriesTitel,
    required this.categoriesImage,
  });

  final String categoriesImage;
  final String categoriesTitel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // GoRouter.of(context)
          // .push(AppRouter.kallproductsView, extra: categorieslist[i]);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            width: 68,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(120.0),
                    child: Image.asset(
                      categoriesImage,
                      fit: BoxFit.cover,
                      width: 68,
                      height: 68,
                    )

                    // CachedNetworkImage(
                    //   progressIndicatorBuilder:
                    //       (context, url, downloadProgress) =>
                    //           buildCircleIndicator(),
                    //   errorWidget: (context, url, error) =>
                    //       const Icon(Icons.error),
                    //   imageUrl: categoriesProductmap["${categorieslist[i]}"][0]
                    //       .thumbnail,
                    //   fit: BoxFit.cover,
                    // ),
                    ),
                Text(
                  categoriesTitel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
