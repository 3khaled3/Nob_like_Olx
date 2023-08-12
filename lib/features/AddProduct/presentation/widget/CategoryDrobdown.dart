// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nob/constant.dart';
import 'package:nob/core/widget/customDropdownButton.dart';

class SelectCategoryDrobdown extends StatelessWidget {
  final void Function(String?)? onChanged;
  const SelectCategoryDrobdown({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> categorie =
        categories.map((categoryData) => categoryData.keys.first).toList();
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: CustomDrob(
        items: categorie,
        titel: "Select Category",
        onChanged: onChanged,
        validator: (value) {
          if (value == null) {
            return 'please  Select Category .';
          }
          return null;
        },
      ),
    );
  }
}
