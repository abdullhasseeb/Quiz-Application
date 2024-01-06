import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quiz/screens/home.dart';
import 'package:quiz/screens/splash_screen.dart';

import 'constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor myCustomSwatch = const MaterialColor(
        0xffED7D31,
        {
          50: Color(0xFFFFF3E0),
          100: Color(0xFFFFE0B2),
          200: Color(0xFFFFCC80),
          300: Color(0xFFFFB74D),
          400: Color(0xFFFFA726),
          500: Color(0xffED7D31), // Primary color
          600: Color(0xFFFF6F0D),
          700: Color(0xFFFF6100),
          800: Color(0xFFFF5100),
          900: Color(0xFFFF2E00),
        }
    );

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'MainFonts',
        primaryColor: orange,
        primarySwatch: myCustomSwatch,
        iconTheme: IconThemeData(
          color: orange
        )
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen()
    );
  }
}
