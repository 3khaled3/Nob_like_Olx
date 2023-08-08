// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/core/utils/Cubits/AddProductCubit/add_product_cubit.dart';
import 'package:nob/core/widget/customtextFaild.dart';
import 'package:nob/features/AddProduct/presentation/widget/ShowImage.dart';
import 'package:nob/features/home/data/product.dart';
import 'package:nob/features/home/presentation/widget/iconButtom.dart';
import '../../../constant.dart';
import '../../../core/widget/CustomElvationBottom.dart';
import '../../../mmmm.dart';
import 'widget/AddImageButtom.dart';

class addProductView extends StatelessWidget {
  const addProductView({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "";
    String description = "";
    double price = 0;
    String? rate = "0";
    String categor = "";
    String stat = "";
    return BlocBuilder<AddProductCubit, AddProductState>(
      builder: (context, state) {
        final List<String> categorie = [];
        final List<String> rateing = [];
        final List<String> status = ["New", "Used"];
        for (var i = 1; i <= 10; i++) {
          rateing.add("$i /10");
        }
        for (var categoryData in categories) {
          String categoryName = categoryData.keys.first;
          categorie.add(categoryName);
        }
        if (state is Waitting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SafeArea(
                child: Row(
                  children: [
                    iconButtom(
                        elvation: 2,
                        icon: Icons.arrow_back_ios_new,
                        onTap: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Product Titel",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                    ),
                    customTextfaild(
                      labelText: "Product Titel",
                      elevation: 4,
                      onChanged: (value) {
                        title = value;
                        print(title);
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Product Description",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                    ),
                    customTextfaild(
                      elevation: 4,
                      labelText: "Product Description",
                      maxLines: 4,
                      onChanged: (value) {
                        description = value;
                                                    print(description );

                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: CustomDrob(
                        items: categorie,
                        titel: "Select Category",
                        onChanged: (value) {
                          categor = value!;
                                                      print(categor );

                        },
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomDrob(
                          items: rateing,
                          titel: "rateing",
                          onChanged: (value) {
                            rate = value ;
                                                        print(rate );

                          },
                        ),
                        CustomDrob(
                          items: status,
                          titel: "status",
                          onChanged: (value) {
                            stat = value!;
                            print(stat );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Product Price",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                    ),
                    customTextfaild(
                      elevation: 4,
                      keyboardType: TextInputType.number,
                      suffixIcon: const SizedBox(width: 20,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Text("L.E",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16)),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        price = double.parse(value)  ;
                        print(value);
                      },
                      labelText: "Product Price",
                      // maxLines: 4,
                    ),
                    const SizedBox(height: 20),
                    const AddImageButtom(),
                    const SizedBox(height: 20),
                    // ignore: prefer_const_constructors
                    ImageLIst(),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: customElevationButtom(
                        text: "Save",
                        onPressed: () async {
                          ProductDataModel product = ProductDataModel(
                              title: title,
                              description: description,
                              price: price,
                              rating: rate,
                              category: categor,
                              status: stat);
                          await BlocProvider.of<AddProductCubit>(context)
                              .uploadAds(Product: product);
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
