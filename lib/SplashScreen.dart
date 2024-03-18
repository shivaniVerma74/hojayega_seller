import 'package:flutter/material.dart';
import 'package:hojayega_seller/AuthView/IntroScreen.dart';
import 'package:hojayega_seller/Screen/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AuthView/Login.dart';
import 'Screen/BottomBar.dart';

String? finalOtp;
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getValidation();
    super.initState();
  }

  Future getValidation() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? vendor_id = sharedPreferences.getString('vendor_id');
    bool? isLogIn = sharedPreferences.getBool("isLogIn");
    bool? isFirstTime = sharedPreferences.getBool("isFirstTime");
    print("vendor id in splash screen $vendor_id");
    finalOtp = vendor_id;
    _navigateToHome(isLogIn?? false, isFirstTime??true);
  }

  _navigateToHome(bool isLogIn, bool isFirstTime) {
    Future.delayed(const Duration(milliseconds: 350),() {
      if (finalOtp == null || finalOtp ==  '' || !isLogIn) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> isFirstTime ?const IntroScreen():LoginPage()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  BottomNavBar()));
      }
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset('assets/images/splassh.png', fit: BoxFit.fill),
      ),
    );
  }
}
