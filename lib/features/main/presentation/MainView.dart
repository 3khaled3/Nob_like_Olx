// // ignore_for_file: library_private_types_in_public_api, file_names

// import 'package:flutter/material.dart';
// import 'package:foryou/features/Categories/presentation/categories_view.dart';
// import 'package:foryou/features/Favorite/presentation/Favorite_view.dart';
// import 'package:foryou/features/home/presentation/home_view.dart';
// import '../../Bag/presentation/Bag_view.dart';
// import '../../Profil/presentation/profil_View.dart';

// class MainView extends StatefulWidget {
//   const MainView({super.key});

//   @override
//   _MainViewState createState() => _MainViewState();
// }

// class _MainViewState extends State<MainView> {
//   int _currentIndex = 0;

//   final List<Widget> _screens = [
//     const homeView(),
//     const CategoriesView(),
//     const BagView(),
//     const favoriteView(),
//     const ProfilView(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _currentIndex,
//         children: _screens,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         showSelectedLabels: true,
//         showUnselectedLabels: true,
//         selectedLabelStyle:
//             const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
//         selectedItemColor: Colors.red,
//         unselectedItemColor: Colors.grey,
//         unselectedLabelStyle:
//             const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             activeIcon: Icon(
//               Icons.home,
//             ),
//             icon: Icon(Icons.home_outlined),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             activeIcon: Icon(Icons.shopping_cart),
//             icon: Icon(Icons.shopping_cart_outlined),
//             label: "Shop",
//           ),
//           BottomNavigationBarItem(
//             activeIcon: Icon(Icons.shopping_bag),
//             icon: Icon(Icons.shopping_bag_outlined),
//             label: 'Bag',
//           ),
//           BottomNavigationBarItem(
//             activeIcon: Icon(Icons.favorite_rounded),
//             icon: Icon(Icons.favorite_border_rounded),
//             label: 'Favorites',
//           ),
//           BottomNavigationBarItem(
//             activeIcon: Icon(Icons.person),
//             icon: Icon(Icons.person_2_outlined),
//             label: 'Profile',
//           )
//         ],
//       ),
//     );
//   }
// }
