// ignore_for_file: file_names, non_constant_identifier_names
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../constant.dart';
import '../../../core/ProdactWidget/saleItem.dart';
import '../../../core/utils/Cubits/FitchProductCubit/fitch_product_cubit.dart';
import '../../home/data/product.dart';
import 'widget/CategorieFindAppBar.dart';
import 'package:flutter/material.dart';
import 'widget/tabstogel.dart';

class CategoriesFindView extends StatelessWidget {
  final String Categorie;
  const CategoriesFindView({Key? key, required this.Categorie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ProductDataModel>? allProduct =
        BlocProvider.of<FitchProductCubit>(context).allProduct;

    final users = BlocProvider.of<FitchProductCubit>(context).users;
    List categorieslist =
        categories.map((categoryData) => categoryData.keys.first).toList();

    List<ProductDataModel> productlist = [];
    List<UserDataModel> userslist = [];
    int initial = 0;
    for (var i = 0; i < categorieslist.length; i++) {
      if (categorieslist[i] == Categorie) {
        initial = i + 1;
        for (var x = 0; x < allProduct!.length; x++) {
          if (allProduct[x].category == categorieslist[i]) {
            productlist.add(allProduct[x]);
            userslist.add(users![x]);
          }
        }
      } else if ("All" == Categorie) {
        for (var x = 0; x < allProduct!.length; x++) {
          productlist.add(allProduct[x]);
          userslist.add(users![x]);
        }
        break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CategorieFindAppBar(
          titel: Categorie,
          ontapArrow: () {
            GoRouter.of(context).pop();
          }),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: tabstogel(initial: initial),
            ),
            const Divider(height: 0),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    mainAxisExtent: 300,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: productlist.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                      height: 290,
                      width: 170,
                      child: SaleItem(
                        product: productlist[index],
                        user: userslist[index],
                      ));
                  //
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
