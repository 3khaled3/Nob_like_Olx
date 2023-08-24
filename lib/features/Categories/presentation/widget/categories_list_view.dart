import 'package:flutter/material.dart';
import 'package:nob/constant.dart';

import 'categories_item.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: CategoriesItem(
              title: categories[index].keys.first,
              image: categories[index][categories[index].keys.first]!),
        );
      },
    );
  }
}
