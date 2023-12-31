import 'package:go_router/go_router.dart';
import 'package:nob/features/AddProduct/presentation/AddProduct.dart';
import 'package:nob/features/Categories/presentation/categories_view.dart';
import 'package:nob/features/Chat/presentation/widget/masseges_bubles.dart';
import 'package:nob/features/Settings/presentation/settings_view.dart';
import 'package:nob/features/home/data/product.dart';
import 'package:nob/features/home/presentation/home_view.dart';
import 'package:nob/features/login/presintaion/phone_signin.dart';
import 'package:nob/features/login/presintaion/validation.dart';
import 'package:nob/features/main/presentation/MainView.dart';
import 'package:nob/features/productDetails/presentation/product_details_view.dart';
import 'core/utils/Splash.dart';
import 'features/Search/presentation/search_view.dart';
import 'features/SeeMoreProduct/presentation/categoriesFind_view.dart';
import 'features/Chat/presentation/chat_view.dart';
import 'features/Settings/presentation/about_us.dart';
import 'features/Settings/presentation/edit_profile.dart';
import 'features/Userprofile/presentation/profile_view.dart';
import 'features/contacts/presentation/contacts_view.dart';
import 'features/login/presintaion/user_data.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kloginview = '/loginView';
  // static const kforgetPssView = '/forgetPssView';
  static const kallproductsView = '/productsView';
  static const kaddProductView = '/addProductView';
  static const kPhoneSignInScreen = '/PhoneSignInScreen';
  static const kvirtfienum = '/virtfienum';
  static const kprodctdetailsview = "/ProdctDetailsView";
  static const kcategoriesview = "/kcategoriesview";
  static const kcontactsview = "/kcontactsview";
  static const kchatview = "/kchatview";
  static const kuserdata = "/kuserdata";
  static const kSplasher = "/";
  // static const start = "kPhoneSignInScreen";
  static const kimageviewscreen = "/kimageviewscreen";
  static const kuserprofileView = "/kuserprofileView";
  static const kSettingsView = "/kSettingsView";
  static const kEditProfile = "/kEditProfile";
  static const kaboutus = "/kaboutus";
  static const kSearchView = "/kSearchView";

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
      // GoRoute(
      //   path: kPhoneSignInScreen,
      //   builder: (context, state) => PhoneSignInScreen(),
      // ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const MainView(),
      ),
      GoRoute(
          path: kprodctdetailsview,
          builder: (context, state) {
            Map<String, dynamic> extras = state.extra as Map<String, dynamic>;
            ProductDataModel product = extras['product'] as ProductDataModel;
            UserDataModel user = extras['user'] as UserDataModel;
            return ProdctDetailsView(product: product, user: user);
          }),
      GoRoute(
        path: kcategoriesview,
        builder: (context, state) => const CategoriesView(),
      ),
      GoRoute(
        path: kPhoneSignInScreen,
        builder: (context, state) => const PhoneSignInScreen(),
      ),
      GoRoute(
        path: kSplasher,
        builder: (context, state) => const Splasher(),
      ),
      GoRoute(
        path: kuserdata,
        builder: (context, state) => const UserData(),
      ),
      GoRoute(
        path: kSearchView,
        builder: (context, state) => const SearchView(),
      ),
      GoRoute(
        path: kchatview,
        builder: (context, state) {
          UserDataModel user = state.extra as UserDataModel;
          return ChatView(
            user: user,
          );
        },
      ),
      GoRoute(
        path: kimageviewscreen,
        builder: (context, state) {
          String url = state.extra as String;
          return ImageViewScreen(
            url: url,
          );
        },
      ),
      GoRoute(
        path: kcontactsview,
        builder: (context, state) => const ContactsView(),
      ),
      GoRoute(
        path: kaboutus,
        builder: (context, state) => const appinfo(),
      ),
      GoRoute(
        path: kEditProfile,
        builder: (context, state) => const EditProfile(),
      ),
      GoRoute(
        path: kallproductsView,
        builder: (context, state) {
          String product = state.extra as String;
          return CategoriesFindView(Categorie: product);
        },
      ),
      GoRoute(
        path: kuserprofileView,
        builder: (context, state) {
          UserDataModel user = state.extra as UserDataModel;
          return Userprofile(user: user);
        },
      ),
      GoRoute(
        path: kaddProductView,
        builder: (context, state) {
          return const addProductView();
        },
      ),
      GoRoute(
        path: kSettingsView,
        builder: (context, state) {
          return const SettingsView();
        },
      ),
    ],
  );
}
