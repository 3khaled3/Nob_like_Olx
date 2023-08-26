import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nob/core/utils/funcation/lunch_phone_num.dart';
import 'package:nob/features/Profile/presentation/widget/profile_image.dart';
import '../../../../core/ProdactWidget/saleItem.dart';
import '../../../home/data/product.dart';


class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.user,
  });

  final UserDataModel user;

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
             await lunchPhoneNum(user.phoneNumber);
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
          height: 4,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
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
            itemCount: 9,
            itemBuilder: (context, index) {
              return SaleItem(
                  user: const UserDataModel(
                      fcmToken:
                          "fB-1m7snSPWivCJVnP9GFl:APA91bEuLNP8-Ki-N3diKRngVWoAJZH0fqRDeN-Pbxn2icCwBuTA9o6TFhOPJj_TUvPMoTunBJrCQ5arbDHObgOoOVH37Vsjy_bAJJaOw9v1EwScR1Gk9ebyfEADBtTKNrzpaAjWJcPL",
                      uid: "uzeCpT8SUFWHc3Jkmpo4Ky4rtzs2",
                      displayName: "Khaled tarek",
                      phoneNumber: "+201234567890",
                      profileImage: null),
                  product: ProductDataModel(
                      favorte: false,
                      id: "uzeCpT8SUFWHc3Jkmpo4Ky4rtzs2",
                      title: "new",
                      description: "new",
                      price: 500,
                      rating: "4 / 10",
                      category: "Electronics & Home Appliances",
                      status: "Used",
                      images: [
                        "https://firebasestorage.googleapis.com/v0/b/nob-d0c2f.appspot.com/o/ads%2FuzeCpT8SUFWHc3Jkmpo4Ky4rtzs2%2F2023-08-25-02-50-08-IMG_20230712_091049.jpg?alt=media&token=5214d7e8-7e9a-4a8e-be95-ef46dc983db4"
                      ]));
              //
            },
          ),
        ),
      ],
    );
  }

}
