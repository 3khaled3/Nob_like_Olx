// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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
              GoRouter.of(context).pop();

              BlocProvider.of<AddProductCubit>(context).selectedImages.clear();
            })
     ,Text("Add Your Product",style:  GoogleFonts.josefinSans(
            fontSize: 24.0,
            fontWeight: FontWeight.w800,
            color: Colors.blue[500],
          ),),
      ],
    );
  }
}
