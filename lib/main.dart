import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:nob/core/utils/Cubits/AddProductCubit/add_product_cubit.dart';
import 'package:nob/core/utils/Cubits/FitchProductCubit/fitch_product_cubit.dart';
import 'package:nob/features/login/presintaion/otb.dart';
import 'package:nob/features/main/presentation/MainView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/utils/Cubits/RegisterCubit/register_cubit.dart';
import 'features/AddProduct/presentation/AddProduct.dart';
import 'features/login/presintaion/validation.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/widget/customDropdownButton.dart';



late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox('myBox');
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  cameras = await availableCameras();
  runApp(
    MultiBlocProvider(
    providers: [
      // BlocProvider(
      //   create: (context) => UserCubit(),
      // ),
      BlocProvider(
        create: (context) => FitchProductCubit(),
      ),
      BlocProvider(
        create: (context) =>AddProductCubit(),
      ),
      BlocProvider(
        create: (context) => RegisterCubit(),
      ),
    ],
    child:
     MaterialApp(home:
    //  addProductView(),
    //  MyHomePage(),
    //  nn(items: ["hi","hsi","scacasc"],onChanged: (p0) {
       
    //  },titel: "hi"),
    //  OTPScreen(),
     PhoneSignInScreen(),
    //  MainView() ,
      debugShowCheckedModeBanner: false,

    )));
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, // Change this color to your desired color
  ));
  // ));
}