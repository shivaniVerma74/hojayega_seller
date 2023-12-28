import 'package:flutter/material.dart';
import 'package:hojayega_seller/AuthView/IntroScreen.dart';

import 'AuthView/Login.dart';

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
    // getValidation();
    _navigateToHome();
    super.initState();
  }

  // Future getValidation() async {
  //   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String? user_id = sharedPreferences.getString('user_id');
  //   print("user id in splash screen $user_id");
  //   finalOtp = user_id;
  //   _navigateToHome();
  // }

  _navigateToHome() {
    Future.delayed(const Duration(milliseconds: 35),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const IntroScreen()));
      // if (finalOtp == null || finalOtp ==  '') {
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
      // } else {
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  BottomNavBar()));
      //  }
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
