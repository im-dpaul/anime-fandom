import 'package:anime_fandom/features/authentication/views/signin_password_screen.dart';
import 'package:anime_fandom/features/authentication/views/signin_otp_screen.dart';
import 'package:anime_fandom/features/authentication/views/signup_screen.dart';
import 'package:anime_fandom/features/authentication/views/user_details_screen.dart';
import 'package:anime_fandom/features/dashboard/views/home_screen.dart';
import 'package:anime_fandom/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splashScreen = '/splashScreen';
  static const String userDetailsScreen = '/userDetailsScreen';
  static const String signupScreen = '/signupScreen';
  static const String signinOtpScreen = '/signinOtpScreen';
  static const String signinPasswordScreen = '/signinPasswordScreen';
  static const String homeScreen = '/homeScreen';
}

class GenerateRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final route = settings.name;
    final arguments = settings.arguments;

    switch (route) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case AppRoutes.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case AppRoutes.signinOtpScreen:
        return MaterialPageRoute(
          builder: (context) => const SigninOtpScreen(),
        );

      case AppRoutes.signinPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => const SigninPasswordScreen(),
        );

      case AppRoutes.signupScreen:
        return MaterialPageRoute(
          builder: (context) => const SignupScreen(),
        );

      case AppRoutes.userDetailsScreen:
        return MaterialPageRoute(
          builder: (context) => const UserDetailsScreen(),
        );

      case AppRoutes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const SigninOtpScreen(),
        );
    }
  }
}
