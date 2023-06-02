import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/routes/app_routes.dart';
import 'package:anime_fandom/firebase_options.dart';
import 'package:anime_fandom/utils/common_methods/notification_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: AndroidProvider.playIntegrity,
  );
  await Hive.initFlutter();
  await Hive.openBox('animeFandom');
  NotificationController().initializeNotification();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    NotificationController().notificationPermission();
    NotificationController().setNotificationListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return OrientationBuilder(
              builder: (context, orientation) {
                SizeConfig().init(constraints, orientation);
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Anime Fandom',
                  theme: ThemeData(
                    fontFamily: 'SF-Pro',
                    scaffoldBackgroundColor: AppColors.bgColor,
                  ),
                  initialRoute: AppRoutes.splashScreen,
                  onGenerateRoute: GenerateRoutes.generateRoute,
                );
              },
            );
          },
        );
      },
    );
  }
}
