import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nob/features/Search/presentation/widget/search_app_bar.dart';

import '../../../core/ProdactWidget/saleItem.dart';
import '../../../core/utils/Cubits/FitchProductCubit/fitch_product_cubit.dart';
import '../../../core/utils/indicator.dart';
import '../../../core/widget/customtextFaild.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).nextFocus();
    List data = [];
    return BlocBuilder<FitchProductCubit, FitchProductState>(
        builder: (context, state) {
      if (BlocProvider.of<FitchProductCubit>(context).allProduct == null) {
        return buildCircleIndicator();
      }
      return Scaffold(
        appBar: searchAppBar(context),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: customTextfaild(
                  labelText: "Search",
                  onChanged: (value) async {
                    data.clear();
                    data.addAll(BlocProvider.of<FitchProductCubit>(context)
                        .search(value));
                  },
                ),
              ),
             data.isEmpty?LottieBuilder.asset("assets/empity.json"): SizedBox(
                width: double.infinity,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      mainAxisExtent: 285,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return SaleItem(
                        user: data[index]["user"],
                        product: data[index]["product"]);
                    //
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
