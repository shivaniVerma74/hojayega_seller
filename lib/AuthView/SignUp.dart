
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hojayega_seller/AuthView/Verifyotp.dart';
import 'package:hojayega_seller/Helper/Loadingwidget.dart';
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
  final TextEditingController mobileEmailCtr = TextEditingController();

  // String? _validateEmail(value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter your email';
  //   } else if (!isValidEmail(value)) {
  //     return 'Please enter a valid email address';
  //   }
  //   return null;
  // }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  bool validateMobile(String value) {
    String pattern = r'^(?:[+0]9)?[0-9]{10}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validateEmail(String value) {
    String pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  sendOtp() async {
    setState(() {
      isLoading = true;
    });
    var headers = {
      'Cookie': 'ci_session=05bf1731f8a5f6bc9d9143b990a080085dfb8659'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.vendorsendOtp));
    request.fields.addAll({
      'mobile': mobileEmailCtr.text
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VerifyOtp(OTP: otp.toString(),
          isMobile: isNumeric(mobileEmailCtr.text),mobileEmail: mobileEmailCtr.text,)));
      } else {
        Fluttertoast.showToast(msg: "${finaResult['message']}");
      }
    }
    else {
      print(response.reasonPhrase);
    }
    setState(() {
      isLoading = false;
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset(
                        'assets/images/otp verification3.png',
                      ),
                    ),
                ),
                 Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Sign Up', style: TextStyle(fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                         ),
                        ),
                        const SizedBox(height: 8,),
                        const Text('Mobile verification', style: TextStyle(fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                           ),
                        ),
                        const SizedBox(height: 8,),
                        const Text(
                            'Please enter your valid mobile number or email id to receive OTP for further registration process..',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 8,),
                        Center(child: Image.asset("assets/images/SIGN UP.png", scale: 1.4)),
                        const SizedBox(height: 16,),
                        Container(
                          // margin: EdgeInsets.fromLTRB(20, 400, 20, 150),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 3),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                              controller: mobileEmailCtr,
                                              validator: (value) {
                                                if (value == null || value.isEmpty || value == "") {
                                                  return 'Mobile number or Email is required';
                                                }
                                                else if(isNumeric(value)){
                                                  if (!validateMobile(value)) {
                                                    return 'Invalid Mobile Number';
                                                  }
                                                }else{
                                                  if(!validateEmail(value)){
                                                    return 'Invalid Email';
                                                  }
                                                }
                                                return null;
                                              },
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
                                    height: 32,
                                  ),
                                  SizedBox(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // setState(() {
                                          //   isLoading = true;
                                          // });
                                          sendOtp();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: colors.secondary,
                                      ),
                                      child: !isLoading?
                                      const Text('Sign Up'): LoadingWidget(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 64,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                      ],
                    ),
                  ),
              ],
            ),
          ),
      ),
    );
  }
}
