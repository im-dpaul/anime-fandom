import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/routes/app_routes.dart';
import 'package:anime_fandom/features/authentication/controllers/signup_provider.dart';
import 'package:anime_fandom/features/authentication/controllers/signin_provider.dart';
import 'package:anime_fandom/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart' as p;

final signupProvider = StateNotifierProvider<SignupNotifier, SignupProvider>(
  (ref) => SignupNotifier(),
);

final signinProvider = StateNotifierProvider<SigninNotifier, SigninProvider>(
  (ref) => SigninNotifier(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await Hive.openBox('animeFandom');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return p.MultiProvider(
      providers: [
        p.ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        builder: (context, child) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return OrientationBuilder(
                builder: (context, orientation) {
                  SizeConfig().init(constraints, orientation);
                  return MaterialApp(
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
      ),
    );
  }
}
