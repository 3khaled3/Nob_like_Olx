import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nob/core/utils/Cubits/FitchProductCubit/fitch_product_cubit.dart';
import 'package:nob/core/widget/customtextFaild.dart';
import 'package:nob/features/home/data/product.dart';
import 'package:nob/features/home/presentation/widget/homeCatogrey.dart';
import 'package:nob/features/home/presentation/widget/titelCatogry.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/indicator.dart';
import '../../../routes.dart';
import 'widget/iconButtom.dart';
import 'widget/saleListview.dart';

// ignore: camel_case_types
class homeView extends StatelessWidget {
  const homeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<Map<UserDataModel, ProductDataModel>>>>(
        future: BlocProvider.of<FitchProductCubit>(context).getdata(context),
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
            List<List<Map<UserDataModel, ProductDataModel>>> finalOutput =
                snapshot.data!;

            return BlocBuilder<FitchProductCubit, FitchProductState>(
                builder: (context, state) {
              return Scaffold(
                  appBar: AppBar(
                      toolbarHeight: 0,
                      backgroundColor: Colors.white,
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
                              GoRouter.of(context)
                                  .push(AppRouter.kcategoriesview);
                              //     extra: "${categorieslist[index]}");
                            },
                          ),
                          const HomeCategory(

                              ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: finalOutput.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Column(
                                  children: [
                                    titelcatogrey(
                                      titel:
                                           finalOutput[index][0].values.first.category,
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
