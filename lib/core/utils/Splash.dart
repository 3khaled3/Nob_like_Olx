// // ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Splasher extends StatefulWidget {
//   const Splasher({super.key});

//   @override
//   State<Splasher> createState() => _SplasherState();
// }

// class _SplasherState extends State<Splasher> {
//   @override
//   void initState() {
//     super.initState();
//     // loginAuto(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SizedBox(
//         width: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Spacer(
//               flex: 2,
//             ),
//             SizedBox(
//                 width: MediaQuery.sizeOf(context).width,
//                 child: LottieBuilder.asset("assets/shop.json")),
//             const Spacer(),
//             Text(
//               "4YOU",
//               style: GoogleFonts.lobsterTwo(
//                   color: Colors.black,
//                   fontSize: 23,
//                   fontWeight: FontWeight.w900),
//             ),
//             const Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
// }
