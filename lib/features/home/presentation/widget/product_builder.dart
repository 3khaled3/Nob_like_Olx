import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nob/features/home/data/product.dart';
import 'package:nob/features/home/presentation/widget/titelCatogry.dart';

import '../../../../routes.dart';
import 'categoriy_list_view.dart';

class ProductBuilderListView extends StatelessWidget {
  const ProductBuilderListView({
    super.key,
    required this.finalOutput,
  });

  final List<List<Map<UserDataModel, ProductDataModel>>> finalOutput;
  

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: finalOutput.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Column(
            children: [
              titelcatogrey(
                titel: finalOutput[index][0].values.first.category,
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.kallproductsView,
                      extra: finalOutput[index][0].values.first.category);
                },
              ),
              saleListView(
                // List<Map<String,List<Map<UserDataModel, ProductDataModel>>>>
                products: finalOutput[index],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .01,
              ),
            ],
          ),
        );
      },
    );
  }
}
