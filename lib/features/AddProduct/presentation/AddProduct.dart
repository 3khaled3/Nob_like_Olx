
// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/core/utils/Cubits/AddProductCubit/add_product_cubit.dart';
import 'package:nob/core/widget/customtextFaild.dart';
import 'package:nob/features/AddProduct/presentation/widget/ShowImage.dart';
import '../../../constant.dart';
import '../../../mmmm.dart';
import 'widget/AddImageButtom.dart';

class addProductView extends StatelessWidget {
  const addProductView({super.key});

  @override
  Widget build(BuildContext context) {
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
          appBar: AppBar(toolbarHeight: 0, elevation: 0),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Product Titel",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const customTextfaild(labelText: "Product Titel"),
                const SizedBox(
                  height: 40,
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Product Description",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const customTextfaild(
                  labelText: "Product Description",
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: CustomDrob(
                    items: categorie,
                    titel: "Select  Category",
                    onChanged: (p0) {},
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
                      onChanged: (p0) {},
                    ),
                    CustomDrob(
                      items: status,
                      titel: "status",
                      onChanged: (p0) {},
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const AddImageButtom(),
                const SizedBox(height: 40),
                // ignore: prefer_const_constructors
                ImageLIst(),
                ElevatedButton(
                    onPressed: () async {
                      await BlocProvider.of<AddProductCubit>(context)
                          .uploadAds();
                    },
                    child: const Text("Save")),
                const SizedBox(height: 50),
              ],
            ),
          ),
        );
      },
    );
  }
}
