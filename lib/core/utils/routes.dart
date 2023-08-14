import 'package:go_router/go_router.dart';
import 'package:nob/features/AddProduct/presentation/AddProduct.dart';
import 'package:nob/features/home/presentation/home_view.dart';
import 'package:nob/features/login/presintaion/otb.dart';
import 'package:nob/features/login/presintaion/validation.dart';
import 'package:nob/features/main/presentation/MainView.dart';
import 'package:nob/features/productDetails/presentation/product_details_view.dart';


abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kloginview = '/loginView';
  static const kforgetPssView = '/forgetPssView';
  static const kallproductsView = '/productsView';
  static const kaddProductView = '/addProductView';
  static const kPhoneSignInScreen = '/PhoneSignInScreen';
  static const kvirtfienum = '/virtfienum';
  static const kprodctdetailsview="/ProdctDetailsView";

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kvirtfienum,
        builder: (context, state) => const OTPScreen(),
      ),
      GoRoute(
        path: kloginview,
        builder: (context, state) => const homeView(),
      ),
      GoRoute(
        path: kPhoneSignInScreen,
        builder: (context, state) =>  PhoneSignInScreen(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const MainView(),
      ),
       GoRoute(
        path: kprodctdetailsview,
        builder: (context, state) => const ProdctDetailsView(),
      ),
      // GoRoute(
      //   path: kIndicator,
      //   builder: (context, state) => const Indicator(),
      // ),
      GoRoute(
        path: '/',
        builder: (context, state) =>  PhoneSignInScreen(),
      ),
      // GoRoute(
      //   path: kproductView,
      //   builder: (context, state) {
      //     Product product = state.extra as Product;
      //     return productView(product: product);
      //   },
      // ),
      // GoRoute(
      //   path: kallproductsView,
      //   builder: (context, state) {
      //     String product = state.extra as String;
      //     return CategoriesFindView(Categorie: product);
      //   },
      // ),
      GoRoute(
        path: kaddProductView,
        builder: (context, state) {
          return const addProductView();
        },
      ),
    ],
  );
}
