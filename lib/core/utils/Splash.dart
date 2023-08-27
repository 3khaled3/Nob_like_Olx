// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'Cubits/RegisterCubit/register_cubit.dart';

class Splasher extends StatefulWidget {
  const Splasher({super.key});

  @override
  State<Splasher> createState() => _SplasherState();
}

class _SplasherState extends State<Splasher> {
  @override
  void initState() {
    super.initState();

    _initializeState();
  }

  Future<void> _initializeState() async {
    await BlocProvider.of<RegisterCubit>(context).autoLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: LottieBuilder.asset("assets/nobel.json")),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
