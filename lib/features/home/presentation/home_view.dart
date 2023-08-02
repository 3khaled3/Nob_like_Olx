import 'package:flutter/material.dart';
import 'package:nob/features/home/presentation/widget/titelCatogry.dart';

import 'widget/saleListview.dart';

// ignore: camel_case_types
class homeView extends StatelessWidget {
  const homeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          // HomeCategory(
          //     categoriesProductmap: categoriesProductmap,
          //     categorieslist: categorieslist),
          SafeArea(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * .03,
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  titelcatogrey(
                    titel: "hi",
                    onPressed: () {
                      // GoRouter.of(context).push(AppRouter.kallproductsView,
                      //     extra: "${categorieslist[index]}");
                    },
                  ),
                  saleListView(
                    products: List.empty(),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .01,
                  ),
                ],
              );
            },
          )
        ]),
      ),
    );
  }
}
