import 'package:flutter/material.dart';
import 'package:nob/core/widget/CustomElvationBottom.dart';
import 'package:nob/features/Categories/presentation/widget/categories_app_bar.dart';
import 'package:nob/features/Categories/presentation/widget/categories_list_view.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: categoriesAppBar(onPressed: () {},context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: SizedBox(
                width: double.infinity,
                child: customElevationButtom(
                  text: "VIEW ALL ITEMS",
                  onPressed: () {
                    // GoRouter.of(context)
                    //     .push(AppRouter.kallproductsView, extra: "All");
                  },
                ),
              ),
            ),
            CategoriesListView(),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}