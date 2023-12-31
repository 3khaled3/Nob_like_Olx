import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:nob/core/utils/Cubits/UserOperationCubit/user_operation_cubit.dart';
import 'core/utils/Cubits/ContactCubit/contact_cubit.dart';
import 'core/utils/Cubits/RegisterCubit/register_cubit.dart';
import 'routes.dart';
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
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => UserOperationCubit(),
        ),
        BlocProvider(
          create: (context) => ContactCubit(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor:
          Colors.grey[100], // Change this color to your desired color
    ),
  );
}
