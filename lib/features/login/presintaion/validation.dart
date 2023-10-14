// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nob/core/utils/Cubits/RegisterCubit/register_cubit.dart';
import 'package:nob/core/widget/CustomElvationBottom.dart';

import '../../../core/utils/indicator.dart';
import '../../../core/utils/styles.dart';
import '../../../routes.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<String> _otpDigits = List.generate(6, (_) => '');
  final GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        if (state is Waitting) {
          return const Indicator();
        }
        return Scaffold(
          backgroundColor: Styles.backgroundColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/verify-code-pic.svg",
                        height: MediaQuery.sizeOf(context).height * .4,
                      ),
                      Text(
                        "Please Enter Code Sent To You",
                        style: GoogleFonts.outfit(
                          color: Colors.grey,
                          fontSize: 15,
                          // fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          6,
                          (index) => smsFaild(index, context),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: customElevationButtom(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              String enteredOTP = _otpDigits.join('');
                              if (enteredOTP.length == 6) {
                                await BlocProvider.of<RegisterCubit>(context)
                                    .signInWithPhoneNumber(enteredOTP);
                                final state =
                                    BlocProvider.of<RegisterCubit>(context)
                                        .state;
    
                                if (state is Success) {
                                  GoRouter.of(context).pop();
                                  GoRouter.of(context)
                                      .pushReplacement(AppRouter.kuserdata);
                                }
                              }
                            }
                          },
                          text: "VERIFY & CONTINUE",
                        ),
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

  SizedBox smsFaild(int index, BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "";
          }
          return null;
        },
        controller: _otpControllers[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
          setState(() {
            _otpDigits[index] = value;
          });
        },
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18),
        decoration: const InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
