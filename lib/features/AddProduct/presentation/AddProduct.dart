import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/core/utils/Cubits/AddProductCubit/add_product_cubit.dart';
import 'package:nob/core/widget/customtextFaild.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:nob/features/AddProduct/presentation/widget/ShowImage.dart';

import '../../../constant.dart';
import '../../../mmmm.dart';
import 'widget/AddImageButtom.dart';

class addProductView extends StatefulWidget {
  const addProductView({super.key});

  @override
  State<addProductView> createState() => _addProductViewState();
}

class _addProductViewState extends State<addProductView> {
  final List<String> categorie = [];
  final List<String> rateing = [];
  final List<String> status = ["New", "Used"];
  @override
  void initState() {
    for (var i = 0; i < 9; i++) {
      rateing.add("$i /10");
    }
    for (var categoryData in categories) {
      String categoryName = categoryData.keys.first;
      categorie.add(categoryName);
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocBuilder<AddProductCubit, AddProductState>(
      builder: (context, state) {
        if (state is Waitting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(toolbarHeight: 0, elevation: 0),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              physics: BouncingScrollPhysics(),
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Product Titel",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                customTextfaild(labelText: "Product Titel"),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Product Description",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                customTextfaild(
                  labelText: "Product Description",
                  maxLines: 4,
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: CustomDrob(
                    items: categorie,
                    titel: "Select  Category",
                    onChanged: (p0) {
                      print("a");
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDrob(
                      items: rateing,
                      titel: "rateing",
                      onChanged: (p0) {
                        print("a");
                      },
                    ),
                    CustomDrob(
                      items: status,
                      titel: "status",
                      onChanged: (p0) {
                        print("a");
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    AddImageButtom(
                      onTap: () async {
                        await BlocProvider.of<AddProductCubit>(context)
                            .uploadImageFromGallery();
                      },
                    ),
                  ],
                ),
                ImageLIst(imagelist: 
                    BlocProvider.of<AddProductCubit>(context).selectedImages),
                ElevatedButton(
                    onPressed: () async {
                      await BlocProvider.of<AddProductCubit>(context)
                          .uploadAds();
                    },
                    child: Text("Save")),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
 