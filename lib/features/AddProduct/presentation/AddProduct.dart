import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/core/utils/Cubits/AddProductCubit/add_product_cubit.dart';
import 'package:nob/core/widget/customtextFaild.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
  @override
  void initState() {
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
          appBar: AppBar(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Product Titel",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
              customTextfaild(labelText: "Product Titel"),
              Row(
                children: [
                  Text(
                    "Product Description",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
              customTextfaild(
                labelText: "Product Description",
                maxLines: 4,
              ),
              SizedBox(width: MediaQuery.sizeOf(context).width,
                child: CustomDrob(
                  items: categorie,
                  titel: "Select  Category",
                  onChanged: (p0) {
                    print("a");
                  },
                ),
              ),
              AddImageButtom(
                onTap: () async {
                  await BlocProvider.of<AddProductCubit>(context)
                      .uploadImageFromGallery();
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    await BlocProvider.of<AddProductCubit>(context).uploadAds();
                  },
                  child: Text("Save")),
            ],
          ),
        );
      },
    );
  }
}
