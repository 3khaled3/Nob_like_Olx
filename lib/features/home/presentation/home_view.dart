import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/core/utils/Cubits/FitchProductCubit/fitch_product_cubit.dart';
import 'package:nob/core/widget/customtextFaild.dart';
import 'package:nob/features/home/data/product.dart';
import 'package:nob/features/home/presentation/widget/homeCatogrey.dart';
import 'package:nob/features/home/presentation/widget/titelCatogry.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/indicator.dart';
import 'widget/iconButtom.dart';
import 'widget/saleListview.dart';

// ignore: camel_case_types
class homeView extends StatelessWidget {
  const homeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, List>>(
        future: BlocProvider.of<FitchProductCubit>(context).getdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildCircleIndicator();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading data'), // Handle the error case
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                  'No data available'), // Handle the case when no data is available
            );
          } else {
            final Map<String, List> productsMap = snapshot.data!;
            final List<String> categories = productsMap.keys.toList();

            return BlocBuilder<FitchProductCubit, FitchProductState>(
                builder: (context, state) {
              List<Map<String, List<Map<UserDataModel, ProductDataModel>>>>
                  products = [];

              for (var i = 0; i < productsMap.length; i++) {
                List<ProductDataModel> productData = [];
                List<UserDataModel> userData = [];
                for (var x = 0; x < productsMap[categories[i]]!.length; x++) {
                  ProductDataModel a = ProductDataModel.empty();
                  a.title = productsMap[categories[i]]![x]["product"]["titel"];
                  a.description =
                      productsMap[categories[i]]![x]["product"]["describiton"];
                  a.category =
                      productsMap[categories[i]]![x]["product"]["categore"];
                  a.price = productsMap[categories[i]]![x]["product"]["Price"];
                  a.status =
                      productsMap[categories[i]]![x]["product"]["status"];
                  a.images =
                      productsMap[categories[i]]![x]["product"]["AdImage"];
                  productData.add(a);
                }
                for (var x = 0; x < productsMap[categories[i]]!.length; x++) {
                  UserDataModel a = UserDataModel(
                    uid: productsMap[categories[i]]![x]["user"]["titel"],
                    displayName: productsMap[categories[i]]![x]["user"]
                        ["displayName"],
                    phoneNumber: productsMap[categories[i]]![x]["user"]
                        ["phoneNumber"],
                    profileImage: productsMap[categories[i]]![x]["user"]
                        ["profileimage"],
                  );

                  userData.add(a);
                }
                for (var x = 0; x < userData.length; x++) {
// List<Map<String, List<Map<UserDataModel, ProductDataModel>>>>
                  print({userData[x]: productData[x]});
                  products.add({
                    categories[i]: [
                      {userData[x]: productData[x]}
                    ]
                  });
                  print("==================================================");
                }
                print(
                    "************************************************************");
                print(products);
              }
              List<List<Map<UserDataModel, ProductDataModel>>> finalout = [];

              for (var i = 0; i < categories.length; i++) {
                List<Map<UserDataModel, ProductDataModel>> outputList = [];
                products.forEach((map) {
                  if (map.containsKey(categories[i])) {
                    List<Map<UserDataModel, ProductDataModel>> vehicleList =
                        map[categories[i]]!
                            .map<Map<UserDataModel, ProductDataModel>>(
                                (entry) => entry)
                            .toList();
                    outputList.addAll(vehicleList);
                  }
                });
                finalout.add(outputList);
              }

              // print("\n\n\n\n============================================\n\n\n\n");
              //  for (var i = 0; i < productsMap.length; i++) {
              //   print(products[i][categories[i]]);

              // }

              return Scaffold(
                  appBar: AppBar(
                      toolbarHeight: 0,
                      backgroundColor: Colors.white,
                      shadowColor: Colors.white,
                      elevation: 0),
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Text("noble",
                                  style: GoogleFonts.lobsterTwo(
                                      fontSize: 43, color: Colors.blue)),
                              const Spacer(),
                              iconButtom(
                                icon: Icons.search,
                                onTap: () {},
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
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
                          const HomeCategory(
                              //     // categoriesProductmap: categoriesProductmap,
                              //     // categorieslist: categorieslist),
                              ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: productsMap.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Column(
                                  children: [
                                    titelcatogrey(
                                      titel: categories[index],
                                      onPressed: () {
                                        // GoRouter.of(context).push(AppRouter.kallproductsView,
                                        //     extra: "${categorieslist[index]}");
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: saleListView(
                                        // List<Map<String,List<Map<UserDataModel, ProductDataModel>>>>
                                        products: finalout[index],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              .01,
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ]),
                  ));
            });
          }
        });
  }
}
