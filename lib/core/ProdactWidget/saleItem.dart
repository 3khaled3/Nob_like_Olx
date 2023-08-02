// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../features/home/data/product.dart';
import '../widget/CustomcircleIconButtom.dart';

class SaleItem extends StatelessWidget {
  // final Product product;

  const SaleItem({
    super.key,
    // required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        color: Colors.white,
        child: GestureDetector(
          onTap: () {},
          child: Stack(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * .35,
                width: MediaQuery.sizeOf(context).width * .43,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/te.jpg",
                        fit: BoxFit.cover,
                        width: MediaQuery.sizeOf(context).width * .43,
                        height: MediaQuery.sizeOf(context).height * .19,
                      ),
                    )
                        //      CachedNetworkImage(
                        //   fit: BoxFit.cover,
                        //   width: 162,
                        //   height: 184,
                        //   imageUrl: product.thumbnail,
                        //   progressIndicatorBuilder:
                        //       (context, url, downloadProgress) =>
                        //           Text("wait"),
                        //   errorWidget: (context, url, error) =>
                        //       const Icon(Icons.error),
                        // )
                        ),
                    Text(
                      "Iphone 14 Pro Max",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "215 \$",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 24,
                          decoration: BoxDecoration(
                              color: Color(0xffEFEFEF),
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: Text(
                              "Used",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 40,
                          height: 24,
                          decoration: BoxDecoration(
                              color: Color(0xffEFEFEF),
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: Text(
                              "08/10",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .3,
                          child: Text(
                            "Gulberg Phase 4, LahGulberg Phase Gulberg Phase Gulberg Phase   ",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "22 Sep",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                right: 16,
                top: 10,
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: circleIconButtom(
                    iconColor: Colors.white,
                    icon: Icons.favorite_border_rounded,
                    onTap: () async {
                      // await favCubit.addTofav(product.id, context);
                      // ignore: use_build_context_synchronously
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
