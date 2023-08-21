// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nob/core/utils/Cubits/FavCubit/fav_cubit.dart';
import 'package:nob/core/utils/indicator.dart';
import '../../features/home/data/product.dart';
import '../../routes.dart';
import '../utils/Cubits/FitchProductCubit/fitch_product_cubit.dart';
import '../widget/CustomcircleIconButtom.dart';

class SaleItem extends StatelessWidget {
  final ProductDataModel product;
  final UserDataModel user;

  const SaleItem({
    super.key,
    required this.product,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavCubit, FavState>(
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
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
                            child:
                                //   Image.asset(
                                //     "assets/te.jpg",
                                //     fit: BoxFit.cover,
                                //     width: MediaQuery.sizeOf(context).width * .43,
                                //     height: MediaQuery.sizeOf(context).height * .19,
                                //   ),
                                // )
                                CachedNetworkImage(
                              fit: BoxFit.cover,
                              width: MediaQuery.sizeOf(context).width * .43,
                              height: MediaQuery.sizeOf(context).height * .19,
                              imageUrl: product.images[0],
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      buildCircleIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Center(child: Icon(Icons.error)),
                            )),
                      ),
                      Text(
                        product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "${product.price}",
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
                                color: const Color(0xffEFEFEF),
                                borderRadius: BorderRadius.circular(16)),
                            child: Center(
                              child: Text(
                                product.status,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 40,
                            height: 24,
                            decoration: BoxDecoration(
                                color: const Color(0xffEFEFEF),
                                borderRadius: BorderRadius.circular(16)),
                            child: Center(
                              child: Text(
                                "${product.rating}",
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
                            child: const Text(
                              "Gulberg Phase 4, LahGulberg Phase Gulberg Phase Gulberg Phase   ",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Expanded(
                            child: Text(
                              "22 Sep",
                              style: TextStyle(
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
                Positioned.fill(child: MaterialButton(onPressed: () {
                  GoRouter.of(context).push(
                    AppRouter.kprodctdetailsview,
                    extra: {
                      'product': product,
                      'user': user,
                    },
                  );
                })),
                Positioned(
                  right: 16,
                  top: 10,
                  child: SizedBox(
                    height: 32,
                    width: 32,
                    child: circleIconButtom(
                      iconColor: product.favorte ? Colors.red : Colors.white,
                      icon: product.favorte
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      onTap: () async {
                        product.favorte = !product.favorte;
                        await BlocProvider.of<FavCubit>(context)
                            .addToFav(product.id);
                        List<ProductDataModel> x =
                            // ignore: use_build_context_synchronously
                            BlocProvider.of<FitchProductCubit>(context)
                                .allProduct;
                        for (var i = 0; i < x.length; i++) {
                          if (x[i].id == product.id) {
                            x[i].favorte = !x[i].favorte;
                            break;
                          }
                        }
                      },
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
