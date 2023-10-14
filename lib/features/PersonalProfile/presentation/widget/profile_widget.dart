import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nob/core/utils/funcation/lunch_phone_num.dart';
import 'package:nob/features/PersonalProfile/presentation/widget/profile_image.dart';
import '../../../../core/ProdactWidget/saleItem.dart';
import '../../../home/data/product.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.user,
    required this.allproduct,
  });

  final UserDataModel user;
  final List<ProductDataModel> allproduct;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileImage(profileImage: user.profileImage),
        Text(
          user.displayName!,
          style: GoogleFonts.josefinSans(
            fontSize: 22.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        TextButton(
          onPressed: () async {
            await lunchPhoneNum(user.phoneNumber!);
          },
          child: Text(
            user.phoneNumber!,
            style: GoogleFonts.josefinSans(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.blue[600]),
          ),
        ),
        const Divider(
          thickness: .8,
          indent: 4,
          endIndent: 4,
          height: 4,
        ),
        const SizedBox(height: 8,),
        SizedBox(
          width: double.infinity,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                mainAxisExtent: 250,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: allproduct.length,
            itemBuilder: (context, index) {
              return SaleItem(user: user, product: allproduct[index]);
              //
            },
          ),
        ),
      ],
    );
  }
}
