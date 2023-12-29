
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hojayega_seller/AuthView/Verifyotp.dart';
import '../Helper/api.path.dart';
import '../Helper/color.dart';
import 'Login.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  var mobileCtr = TextEditingController();
  var password = TextEditingController();
  bool isChecked = false;
  bool isVisible = false;

  // String? _validateEmail(value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter your email';
  //   } else if (!isValidEmail(value)) {
  //     return 'Please enter a valid email address';
  //   }
  //   return null;
  // }

  bool validateMobile(String value) {
    String pattern = r'^[0-9]{10}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  sendOtp() async {
    var headers = {
      'Cookie': 'ci_session=05bf1731f8a5f6bc9d9143b990a080085dfb8659'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.vendorsendOtp));
    request.fields.addAll({
      'mobile': mobileCtr.text
    });
    print("send otp parameter ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finaResult = jsonDecode(result);
      print("resonse $finaResult");
      if (finaResult['error'] == false) {
        int otp = finaResult['otp'];
        print('____otp___${otp}___');
        Fluttertoast.showToast(msg: '${finaResult['message']}');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VerifyOtp(OTP: otp.toString())));
      } else {
        Fluttertoast.showToast(msg: "${finaResult['message']}");
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset(
                          'assets/images/otp verification – 3.png',
                        ),
                      ),
                  ),
                ],
              ),
              const Positioned(
                  top: 30,
                  left: 20,
                  child: Text('Sign Up', style: TextStyle(fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                   ),
                  ),
              ),
              const Positioned(
                  top: 120,
                  left: 20,
                  child: Text('Mobile verification', style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                     ),
                  ),
              ),
              const Positioned(
                  top: 80,
                  left: 20,
                  right: 20,
                  child: Text(
                      'Please enter your valid mobile number to receive OTP for further registration process..',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
              ),
              Positioned(
                  top: 150,
                  left: 50,
                  right: 50,
                  child: Image.asset("assets/images/SIGN UP.png", scale: 1.4),
              ),
              Positioned(
                bottom: 55,
                left: 65,
                // right: 50,
                child: Row(
                  children: [
                    const Text("Already registered ?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
                     },
                        child: const Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: colors.secondary),
                        ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 390,
                bottom: 160,
                left: 20,
                right: 20,
                child: Container(
                  // margin: EdgeInsets.fromLTRB(20, 400, 20, 150),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Row(
                            children: [
                              Card(
                                elevation: 5,
                                child: Container(
                                    height: 40,
                                    color: Colors.grey.shade100,
                                    child: Image.asset("assets/images/email address.png", height: 20),
                                  // Icon(Icons.phone, size: 48,
                                  //   color: Colors.green,),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  elevation: 5,
                                  child: TextFormField(
                                    controller: mobileCtr,
                                    maxLength: 10,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Mobile number is required';
                                      }
                                      if (!validateMobile(value)) {
                                        return 'Invalid Mobile Number';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      hintText: "Email/Phone Number",
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.grey.shade100 ,
                                      // labelText: 'Email/Phone Number',
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.grey.shade100)
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.grey.shade100)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width/1.6,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                sendOtp();
                              }
                            },
                            child: Text('Sign Up'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
