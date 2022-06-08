import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haffez/utils/assets.dart';
import 'package:haffez/view/splash_view.dart';
import 'package:haffez/view/widgets/custom_loader.dart';
import 'core/view_model/loader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await Firebase.initializeApp().then((_) {
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: false);
  });

  runApp(const MyApp());
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: ScreenUtilInit(
        builder: () {
          return Stack(
            children: [
              GetMaterialApp(
                localizationsDelegates: const [
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale("ar"),
                ],
                locale: const Locale("ar"),
                debugShowCheckedModeBanner: false,
                title: "حفز",
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  primaryColor: Assets.shared.primaryColor,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: Assets.shared.primaryColor,
                    secondary: Assets.shared.secondaryColor,
                  ),
                  appBarTheme: AppBarTheme(
                    color: Assets.shared.primaryColor,
                  ),
                  fontFamily: Assets.shared.primaryFont,
                  textSelectionTheme: TextSelectionThemeData(
                      cursorColor: Assets.shared.primaryColor),
                ),
                home: const SplashView(),
              ),
              GetBuilder<LoaderViewModel>(
                init: LoaderViewModel(),
                builder: (controller) {
                  return Visibility(
                    visible: controller.isActiveLoader,
                    child: const CustomLoader(),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
