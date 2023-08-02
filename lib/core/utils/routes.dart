// import 'package:foryou/core/utils/Splash.dart';
// import 'package:go_router/go_router.dart';

// import '../../features/CategoriesFind/presentation/categoriesFind_view.dart';
// import '../../features/Settings/presentation/Settings_view.dart';
// import '../../features/register/presentation/register_view.dart';
// import 'indicator.dart';

// abstract class AppRouter {
//   static const kHomeView = '/homeView';
//   static const kloginview = '/loginView';
//   static const kforgetPssView = '/forgetPssView';
//   static const kproductView = '/productView';
// static const kallproductsView='/productsView';
// static const kSettingsView='/SettingsView';
// static const kIndicator='/Indicator';
// static const kregisterView='/kSplasher';

//   static final router = GoRouter(
//     routes: [
//       GoRoute(
//         path: kregisterView,
//         builder: (context, state) => const registerView(),
//       ),
//       GoRoute(
//         path: kloginview,
//         builder: (context, state) => const loginView(),
//       ),
//       GoRoute(
//         path: kforgetPssView,
//         builder: (context, state) => const forgetPssView(),
//       ),
//       GoRoute(
//         path: kHomeView,
//         builder: (context, state) => const MainView(),
//       ),
//       GoRoute(
//         path: kIndicator,
//         builder: (context, state) => const Indicator(),
//       ),
//        GoRoute(
//         path: '/',
//         builder: (context, state) => const Splasher(),
//       ),
//       GoRoute(
//         path: kproductView,
//         builder: (context, state) {
//           Product product = state.extra as Product;
//           return productView(product: product);
//         },
//       ),
//       GoRoute(
//         path: kallproductsView,
//         builder: (context, state) {
//           String product = state.extra as String;
//           return CategoriesFindView(Categorie: product);
//         },
//       ),
//        GoRoute(
//         path: kSettingsView,
//         builder: (context, state) {
          
//           return  const SettingsView();
//         },
//       ),
//     ],
//   );
// }
