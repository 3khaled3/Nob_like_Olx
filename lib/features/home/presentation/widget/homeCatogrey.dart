// ignore_for_file: file_names, camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeCategory extends StatelessWidget {
  // final List categorieslist;
  // final Map categoriesProductmap;
  const HomeCategory({
    super.key,
    // required this.categorieslist,
    // required this.categoriesProductmap,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [];
    for (var i = 0; i < 30; i++) {
      items.add(homeCard(
          // categoriesProductmap: categoriesProductmap,
          // categorieslist: categorieslist,
          // i: i,
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
              itemCount: 20,
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
    // required this.categoriesProductmap,
    // required this.categorieslist,
    // required this.i,
  });

  // final Map categoriesProductmap;
  // final List categorieslist;
  // final int i;

  @override
  Widget build(BuildContext context) {
    // if (!categoriesProductmap.containsKey(categorieslist[i])) {
    //   return buildCircleIndicator();
    // }

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(120.0),
                    child: Image.asset(
                      "assets/te.jpg",
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
                const Text(
                  "MobilesMobilesMobiles",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
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
