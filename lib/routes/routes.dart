import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/view/AuthenticationScreens/login_screen.dart';
import 'package:citta_23/view/AuthenticationScreens/loginorSignup.dart';
import 'package:citta_23/view/AuthenticationScreens/otp_screen.dart';
import 'package:citta_23/view/AuthenticationScreens/registration_screen.dart';
import 'package:citta_23/view/AuthenticationScreens/rest_screen.dart';
import 'package:citta_23/view/Checkout/check_out.dart';
import 'package:citta_23/view/Checkout/done_screen.dart';
import 'package:citta_23/view/Favourite/favourite_list.dart';
import 'package:citta_23/view/HomeScreen/DashBoard/tapBar.dart';
import 'package:citta_23/view/HomeScreen/HomeScreen.dart';
import 'package:citta_23/view/HomeScreen/Search/search_screen.dart';
import 'package:citta_23/view/HomeScreen/bundle_product_screen.dart';
import 'package:citta_23/view/HomeScreen/create_myown_pack_screen.dart';
import 'package:citta_23/view/HomeScreen/new_items.dart';
import 'package:citta_23/view/HomeScreen/order_details/address_details_screen.dart';
import 'package:citta_23/view/HomeScreen/product_detail_screen.dart';
import 'package:citta_23/view/card/card_screen.dart';
import 'package:citta_23/view/onBordingScreens/onboarding_screen2.dart';
import 'package:citta_23/view/onBordingScreens/onboarding_screen3.dart';
import 'package:citta_23/view/onBordingScreens/splash_screen.dart';
import 'package:citta_23/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import '../view/AuthenticationScreens/login_or_signin_screen.dart';
import '../view/HomeScreen/popular_pack_screen.dart';
import '../view/onBordingScreens/onbording_screen1.dart';
import '../view/review/review.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreen(),
        );
      case RoutesName.onboarding1:
        return MaterialPageRoute(
          builder: (BuildContext context) => const OnBordingScreen1(),
        );
      case RoutesName.onboarding2:
        return MaterialPageRoute(
          builder: (BuildContext context) => const OnBordingScreen2(),
        );
      case RoutesName.onboarding3:
        return MaterialPageRoute(
          builder: (BuildContext context) => const OnBordingScreen3(),
        );
      case RoutesName.loginOrSignup:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginOrSignUp(),
        );
      case RoutesName.loginorsiginscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginOrSigninScreen(),
        );

      case RoutesName.loginscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        );
      case RoutesName.restscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const RestScreen(),
        );
      case RoutesName.otpscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const OtpScreen(),
        );
      case RoutesName.registerScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const RegisterScreen(),
        );
      case RoutesName.homeScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),
        );
      case RoutesName.productdetailscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ProductDetailScreen(),
        );
      case RoutesName.newitemsscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const NewItemsScreen(),
        );
      case RoutesName.popularpackscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const PopularPackScreen(),
        );
      case RoutesName.bundleproductdetail:
        return MaterialPageRoute(
          builder: (BuildContext context) => const BundleProductScreen(),
        );
      case RoutesName.favouriteList:
        return MaterialPageRoute(
          builder: (BuildContext context) => const FavouriteList(),
        );
      case RoutesName.cartScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const CardScreen(),
        );
      case RoutesName.profileScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ProfileScreen(),
        );
      case RoutesName.checkOutScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const CheckOutScreen(),
        );
      case RoutesName.dashboardScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const DashBoardScreen(),
        );
      case RoutesName.createmyownpackscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const CreateOwnPackScreen(),
        );
      case RoutesName.searchscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SearchScreen(),
        );
      case RoutesName.addressdetailscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const AddressDetailSceen(),
        );
      case RoutesName.checkoutdonescreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const CheckOutDoneScreen(),
        );
      case RoutesName.ratingscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => Rating(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('No routes define'),
              ),
            );
          },
        );
    }
  }
}
