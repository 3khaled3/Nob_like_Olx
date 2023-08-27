import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nob/core/utils/Cubits/RegisterCubit/register_cubit.dart';
import 'package:nob/core/widget/CustomElvationBottom.dart';
import 'package:nob/core/widget/tossetMassage.dart';

import '../../../core/utils/indicator.dart';

class PhoneSignInScreen extends StatefulWidget {
  const PhoneSignInScreen({super.key});

  @override
  State<PhoneSignInScreen> createState() => _PhoneSignInScreenState();
}

class _PhoneSignInScreenState extends State<PhoneSignInScreen> {
  final TextEditingController _phoneFiledController = TextEditingController();

  String countryCode = "+20";
  String phonenum = "0";

  GlobalKey<FormState> formkey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        if (state is Waitting) {
          return const Indicator();
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SvgPicture.asset("assets/mobile-auth-pic.svg",
                          height: MediaQuery.sizeOf(context).height * .4),
                      // Text(
                      //   "Enter Your Phone number",
                      //   style: GoogleFonts.outfit(
                      //     // color: ,
                      //     fontSize: 22,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      const SizedBox(height: 10),
                      Text(
                        "We Will send you the 6 digit verification Code",
                        style: GoogleFonts.outfit(
                          color: Colors.grey,
                          fontSize: 15,
                          // fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      IntlPhoneField(
                        validator: (p0) {
                          if (phonenum == "0") {
                            return 'Please enter a valid Phone Number';
                          }
                          return null;
                        },
                        controller: _phoneFiledController,
                        initialCountryCode: "EG",
                        onCountryChanged: (value) {
                          countryCode = value.dialCode;
                        },
                        showDropdownIcon:
                            false, // Hide the country dropdown icon
                        showCountryFlag: true, // Hide the country flag
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Enter your phone number",
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        onChanged: (value) {
                          phonenum = value.completeNumber;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: customElevationButtom(
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                await BlocProvider.of<RegisterCubit>(context)
                                    .verifyPhoneNumber(phonenum, context);
                                var state =
                                    // ignore: use_build_context_synchronously
                                    BlocProvider.of<RegisterCubit>(context)
                                        .state;
                                if (state is Error) {
                                  final errorMessage = (state).errorMessage;
                                  showToastMessage(errorMessage, Colors.red);
                                }
                              }
                            },
                            text: "Verify Phone Number"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
