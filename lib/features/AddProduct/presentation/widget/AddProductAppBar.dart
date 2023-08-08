// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/core/utils/Cubits/AddProductCubit/add_product_cubit.dart';

import '../../../home/presentation/widget/iconButtom.dart';

class addProductAppBar extends StatelessWidget {
  const addProductAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        iconButtom(
            elvation: 2,
            icon: Icons.arrow_back_ios_new,
            onTap: () {
              Navigator.pop(context);
              BlocProvider.of<AddProductCubit>(context).selectedImages.clear();
            })
      ],
    );
  }
}
