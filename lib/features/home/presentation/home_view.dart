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
              child: Text('Error loading data'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          } else {
            final Map<String, List> productsMap = snapshot.data!;
            final List<String> categories =
                productsMap.keys.toList(); //All categories

            return BlocBuilder<FitchProductCubit, FitchProductState>(
                builder: (context, state) {
              List<List<Map<UserDataModel, ProductDataModel>>> finalOutput = [];

// Iterate through each category
              for (String category in categories) {
                List<Map<UserDataModel, ProductDataModel>> categoryOutput = [];

                // Iterate through the data points in the current category
                for (var data in productsMap[category] ?? []) {
                  Map<String, dynamic>? product = data['product'];
                  Map<String, dynamic>? user = data['user'];

                  // Skip this data point if either product or user is null
                  if (product == null || user == null) {
                    continue;
                  }

                  // Extract product data from the current data point
                  ProductDataModel productData = ProductDataModel.empty()
                    ..title = product['titel'] ?? ''
                    ..description = product['description'] ?? ''
                    ..category = product['category'] ?? ''
                    ..price = product['Price'] ?? 0
                    ..status = product['status'] ?? ''
                    ..images = product['AdImage'] ?? 
                    []..rating=product['rating']??"" ;

                  // Extract user data from the current data point
                  UserDataModel userData = UserDataModel(
                    uid: user['title'] ?? '',
                    displayName: user['displayName'] ?? '',
                    phoneNumber: user['phoneNumber'] ?? '',
                    profileImage: user['profileImage'] ?? '',
                  );

                  // Create a map with user data as the key and product data as the value
                  categoryOutput.add({
                    userData: productData,
                  });
                }

                // Add the list of user-product data pairs for the current category to the final output
                finalOutput.add(categoryOutput);
              }

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
                                    saleListView(
                                      // List<Map<String,List<Map<UserDataModel, ProductDataModel>>>>
                                      products: finalOutput[index],
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
