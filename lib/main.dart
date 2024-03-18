import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hojayega_seller/Helper/color.dart';

import 'SplashScreen.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HoJayega Seller',
      theme: ThemeData(textSelectionTheme: const TextSelectionThemeData(
        cursorColor: colors.primary,
      ),
        // focusColor: colors.primary,
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
