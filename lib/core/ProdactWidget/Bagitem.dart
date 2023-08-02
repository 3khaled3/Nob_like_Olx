// // ignore_for_file: file_names

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:line_icons/line_icons.dart';
// import '../utils/indicator.dart';
// import '../utils/routes.dart';
// import '../widget/CustomcircleIconButtom.dart';

// // ignore: camel_case_types
// class BagItem extends StatelessWidget {
//   final Map<String, dynamic> item;
//   final void Function()? plusonTap;
//   final void Function()? minusonTap;
//   final void Function()? delonTap;
//   const BagItem({required this.plusonTap,required this.minusonTap,required this.delonTap,
//     required this.item,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         GoRouter.of(context)
//             .push(AppRouter.kproductView, extra: item["product"]);
//       },
//       child: Container(
//         width: double.infinity,
//         height: 104,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               spreadRadius: .001,
//               blurRadius: 1,
//               offset: const Offset(0, 1),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(20),
//                   topLeft: Radius.circular(20)),
//                child: CachedNetworkImage(
//                       fit: BoxFit.cover,
//                 height: 104,
//                 width: 104,
//                       imageUrl: item["product"].thumbnail,
//                       progressIndicatorBuilder:
//                           (context, url, downloadProgress) =>
//                               buildCircleIndicator(),
//                       errorWidget: (context, url, error) =>
//                           const Icon(Icons.error),
//                     )
//             ),
//             const SizedBox(
//               width: 11,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(item["product"].title,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600,
//                       )),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Text(item["product"].brand,
//                       style: const TextStyle(
//                           color: Colors.grey,
//                           fontWeight: FontWeight.w400,
//                           fontSize: 11)),
//                    Text("\$ ${item["product"].price}",
//                       style: const TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14)),
//                   const Spacer(),
//                   Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       circleIconButtom(
//                         icon: LineIcons.plus,
//                         onTap: plusonTap,
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Text("${item["qu"]}",
//                           style: const TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14)),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       circleIconButtom(
//                         icon: LineIcons.minus,
//                         onTap: minusonTap,
//                       ),
//                       const Spacer(),
//                       IconButton(
//                           onPressed: delonTap,
//                           icon: const Icon(
//                             Icons.delete,
//                             color: Color.fromARGB(111, 0, 0, 0),
//                           ))
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
