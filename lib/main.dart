import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'features/home/presentation/home_view.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';



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
    // MultiBlocProvider(
    // providers: [
      // BlocProvider(
      //   create: (context) => UserCubit(),
      // ),
      // BlocProvider(
      //   create: (context) => ApiCubit(),
      // ),
      // BlocProvider(
      //   create: (context) => BagCubit(),
      // ),
      // BlocProvider(
      //   create: (context) => FavCubit(),
      // ),
    // ],
    // child:
     MaterialApp(home:homeView() ,
      debugShowCheckedModeBanner: false,

    ));
  // ));
}