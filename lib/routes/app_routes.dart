import 'package:anime_fandom/features/authentication/views/signin_password_screen.dart';
import 'package:anime_fandom/features/authentication/views/signin_otp_screen.dart';
import 'package:anime_fandom/features/authentication/views/signup_screen.dart';
import 'package:anime_fandom/features/authentication/views/user_details_screen.dart';
import 'package:anime_fandom/features/chat/views/chat_screen.dart';
import 'package:anime_fandom/features/dashboard/views/home_screen.dart';
import 'package:anime_fandom/features/favourite/views/favourite_screen.dart';
import 'package:anime_fandom/features/new_post/views/create_post_screen.dart';
import 'package:anime_fandom/features/notifications/views/notifications_screen.dart';
import 'package:anime_fandom/features/profile/views/profile_screen.dart';
import 'package:anime_fandom/features/search/views/search_screen.dart';
import 'package:anime_fandom/features/settings/views/settings_screen.dart';
import 'package:anime_fandom/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splashScreen = '/splashScreen';

  static const String userDetailsScreen = '/userDetailsScreen';
  static const String signupScreen = '/signupScreen';
  static const String signinOtpScreen = '/signinOtpScreen';
  static const String signinPasswordScreen = '/signinPasswordScreen';

  static const String homeScreen = '/homeScreen';
  static const String profileScreen = '/profileScreen';
  static const String createPostScreen = '/createPostScreen';
  static const String favouriteScreen = '/favouriteScreen';
  static const String searchScreen = '/searchScreen';
  static const String settingsScreen = '/settingsScreen';

  static const String chatScreen = '/chatScreen';
  static const String notificationScreen = '/notificationScreen';
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

      case AppRoutes.userDetailsScreen:
        return MaterialPageRoute(
          builder: (context) => const UserDetailsScreen(),
        );

      case AppRoutes.signupScreen:
        return MaterialPageRoute(
          builder: (context) => const SignupScreen(),
        );

      case AppRoutes.signinOtpScreen:
        return MaterialPageRoute(
          builder: (context) => const SigninOtpScreen(),
        );

      case AppRoutes.signinPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => const SigninPasswordScreen(),
        );

      case AppRoutes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      case AppRoutes.profileScreen:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        );

      case AppRoutes.createPostScreen:
        return MaterialPageRoute(
          builder: (context) => const CreatePostScreen(),
        );

      case AppRoutes.favouriteScreen:
        return MaterialPageRoute(
          builder: (context) => const FavouriteScreen(),
        );

      case AppRoutes.searchScreen:
        return MaterialPageRoute(
          builder: (context) => const SearchScreen(),
        );

      case AppRoutes.chatScreen:
        return MaterialPageRoute(
          builder: (context) => const ChatScreen(),
        );

      case AppRoutes.settingsScreen:
        return MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
        );

      case AppRoutes.notificationScreen:
        return MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const SigninOtpScreen(),
        );
    }
  }
}
