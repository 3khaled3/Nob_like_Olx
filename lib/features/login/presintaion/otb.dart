// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nob/core/utils/Cubits/RegisterCubit/register_cubit.dart';
import 'package:nob/core/widget/tossetMassage.dart';
import 'package:nob/features/login/presintaion/validation.dart';
import 'package:nob/features/main/presentation/MainView.dart';

class PhoneSignInScreen extends StatefulWidget {
  PhoneSignInScreen({super.key});

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
    autoLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 0,
            elevation: 0,
            title: const Text('Phone Authentication'),
          ),
          body: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  SvgPicture.asset("assets/mobile-auth-pic.svg",
                      height: MediaQuery.sizeOf(context).height * .4),
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
                    showDropdownIcon: false, // Hide the country dropdown icon
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
                  ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        await BlocProvider.of<RegisterCubit>(context)
                            .verifyPhoneNumber(phonenum, context);
                        var state =
                            BlocProvider.of<RegisterCubit>(context).state;
                        if (state is Error) {
                          final errorMessage = (state).errorMessage;
                          showToastMessage(errorMessage, Colors.red);
                        }
                      }
                    },
                    child: const Text('Verify Phone Number'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

autoLogin(context) async {
  var box = Hive.box('myBox');
  final storedsmsCode = box.get('sms');
  final storedverificationId = box.get('verificationId');
  if (storedsmsCode != null && storedverificationId != null) {
    try {
      await BlocProvider.of<RegisterCubit>(context).autoLogin();
      final state = BlocProvider.of<RegisterCubit>(context).state;
      if (state is Success) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const MainView();
          },
        ));
      } else if (state is Error) {
        // GoRouter.of(context).pushReplacement(AppRouter.kregisterView);
      }
      // ignore: empty_catches
    } catch (e) {}
  }
}
