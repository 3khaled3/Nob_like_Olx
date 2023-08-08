// ignore_for_file: camel_case_types, file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/core/utils/Cubits/AddProductCubit/add_product_cubit.dart';
import 'package:nob/core/widget/customtextFaild.dart';
import 'package:nob/features/AddProduct/presentation/widget/ShowImage.dart';
import 'package:nob/features/AddProduct/presentation/widget/addProductAppBar.dart';
import 'package:nob/features/home/data/product.dart';
import '../../../constant.dart';
import '../../../core/widget/CustomElvationBottom.dart';
import '../../../mmmm.dart';
import 'widget/AddImageButtom.dart';

class addProductView extends StatelessWidget {
  const addProductView({super.key});

  @override
  Widget build(BuildContext context) {
    ProductDataModel product = ProductDataModel.empty();
    return BlocBuilder<AddProductCubit, AddProductState>(
      builder: (context, state) {
        final List<String> categorie =
            categories.map((categoryData) => categoryData.keys.first).toList();
        final List<String> rateing =
            List.generate(10, (index) => '${index + 1} / 10');
        final List<String> status = ["New", "Used"];
        if (state is Waitting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SafeArea(child: addProductAppBar()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Product Titel", style: widgetTitelStyle()),
                    ),
                    customTextfaild(
                      labelText: "Product Titel",
                      elevation: 4,
                      onChanged: (value) {
                        product.title = value;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Product Description",
                          style: widgetTitelStyle()),
                    ),
                    customTextfaild(
                      elevation: 4,
                      labelText: "Product Description",
                      maxLines: 4,
                      onChanged: (value) {
                        product.description = value;
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
                          product.category = value!;
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
                            product.rating = value;
                          },
                        ),
                        CustomDrob(
                          items: status,
                          titel: "status",
                          onChanged: (value) {
                            product.status = value!;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Product Price", style: widgetTitelStyle()),
                    ),
                    customTextfaild(
                      elevation: 4,
                      keyboardType: TextInputType.number,
                      suffixIcon: SizedBox(
                        width: 20,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text("L.E", style: widgetTitelStyle()),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        product.price = double.parse(value);
                      },
                      labelText: "Product Price",
                      // maxLines: 4,
                    ),
                    const SizedBox(height: 20),
                    const AddImageButtom(),
                    const SizedBox(height: 20),
                    // ignore: prefer_const_constructors
                    ImageLIst(
                        selectedImages:
                            BlocProvider.of<AddProductCubit>(context)
                                .selectedImages),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: customElevationButtom(
                        text: "Save",
                        onPressed: () async {
                          await BlocProvider.of<AddProductCubit>(context)
                              .uploadAds(Product: product);
                          Navigator.pop(context);
                          BlocProvider.of<AddProductCubit>(context)
                              .selectedImages
                              .clear();
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

  TextStyle widgetTitelStyle() {
    return const TextStyle(
        color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16);
  }
}
