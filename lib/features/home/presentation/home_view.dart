import 'package:flutter/material.dart';
import 'package:nob/core/widget/customtextFaild.dart';
import 'package:nob/features/home/presentation/widget/homeCatogrey.dart';
import 'package:nob/features/home/presentation/widget/titelCatogry.dart';

import 'widget/saleListview.dart';

// ignore: camel_case_types
class homeView extends StatelessWidget {
  const homeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: customTextfaild(
              labelText: "Gulberg Phase 4 , Lahore",
              inithialText: "Gulberg Phase 4 , Lahore",
              prefixIcon: Icon(Icons.location_on_outlined),
              suffixIcon: Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
          ),
          titelcatogrey(
            titelfontSize: 18,
            titel: "Browse Categories",
            onPressed: () {
              // GoRouter.of(context).push(AppRouter.kallproductsView,
              //     extra: "${categorieslist[index]}");
            },
          ),
          HomeCategory(
              //     // categoriesProductmap: categoriesProductmap,
              //     // categorieslist: categorieslist),
              ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  children: [
                    titelcatogrey(
                      titel: "hi",
                      onPressed: () {
                        // GoRouter.of(context).push(AppRouter.kallproductsView,
                        //     extra: "${categorieslist[index]}");
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: saleListView(
                          // products: List.empty(),
                          ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * .01,
                    ),
                  ],
                ),
              );
            },
          )
        ]),
      ),
    );
  }
}
