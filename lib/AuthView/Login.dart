import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hojayega_seller/AuthView/SignUpPersonal.dart';
import 'package:hojayega_seller/Screen/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/api.path.dart';
import '../Helper/color.dart';
import '../Screen/BottomBar.dart';
import 'SignUp.dart';
import 'forgotPassword.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  bool isChecked = false;
  bool isVisible = false;
  String? _validateEmail(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!isValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  bool isValidEmail(String email) {
    // Simple email validation using a regular expression
    // You can customize the regular expression based on your requirements
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  String? vendor_id;


  vendorLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=f26b98128123d8304685b8bd593560b8d95aef80'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.login));
    request.fields.addAll(
        {'email': email.text, 'password': password.text, });
     print("login parraaa ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finaResult = jsonDecode(result);
      print("responseee $finaResult");
      if (finaResult['error'] == false) {
        vendor_id = finaResult['data']['id'];
        vendor_name = finaResult['data']['username'];
        vendor_mobile = finaResult['data']['mobile'];
        vendor_email = finaResult['data']['email'];
        await prefs.setString('vendor_id', finaResult['data']['id'].toString());
        print('____vendor data is___$vendor_id $vendor_email $vendor_mobile ${vendor_name}___');
        setState(() {});
        Fluttertoast.showToast(msg: '${finaResult['message']}');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
      } else {
        Fluttertoast.showToast(msg: "${finaResult['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/introimage.png',
                fit: BoxFit.fill,
              )),
          const Positioned(
              top: 30,
              left: 20,
              child: Text(
                'Login',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
          const Positioned(
              top: 80,
              left: 20,
              right: 20,
              child: Text(
                ' Please enter email address or mobile number and password if you are already registered. if not the signup for new account.  ',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
          Positioned(
            top: 100,
            left: 50,
            right: 50,
            child: Image.asset(
              "assets/images/LOGIN.png",
              scale: 2,
            ),
          ),
          Positioned(
            top: 320,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Container(
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
                          padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                          child: Row(
                            children: [
                              Card(
                                elevation: 5,
                                child: Container(
                                  width: 50,
                                  height: 55,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey.shade200),
                                 // color: Colors.grey.shade200,
                                  child: const Icon(
                                    Icons.phone,
                                    size: 25,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              Expanded(
                                child:
                                Card(
                                  color: Colors.grey.shade200,
                                  elevation: 5,
                                  child: TextFormField(
                                    controller: email,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Fill This Field';
                                      }
                                      return null;
                                    },
                                    // keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      hintText: "Email/Phone Number",
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      // labelText: 'Email/Phone Number',
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade200)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade200)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                          child: Row(
                            children: [
                              Card(
                                elevation: 5,
                                child: Container(
                                  width: 50,
                                  height: 55,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey.shade200,),
                                //  color: Colors.grey.shade200,
                                  child: const Icon(
                                    Icons.lock,
                                    size: 25,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  color: Colors.grey.shade200,
                                  elevation: 5,
                                  child: TextFormField(
                                    obscureText: isVisible ? false : true,
                                    controller: password,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'enter password';
                                      } else if (value.length < 6) {
                                        return 'At least 6 char required';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      //labelText: 'Password',
                                      hintText: "Password",
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isVisible
                                                ? isVisible = false
                                                : isVisible = true;
                                          });
                                        },
                                        icon: Icon(
                                          isVisible
                                              ? Icons.remove_red_eye
                                              : Icons.visibility_off,
                                          color: Colors.green,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade200),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade200)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    value: isChecked,
                                    activeColor: Colors.green,
                                    side: const BorderSide(
                                      color: Colors.green,
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        isChecked = val!;
                                      });
                                    }),
                                const Text('Remember me'),
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Forget()));
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          height: 40,
                          width: 250,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                vendorLogin();
                                // Navigator.push(context, MaterialPageRoute(builder:(context)=> SignUpPersonal()));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: colors.secondary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: const Text('Login'),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Center(
                  child: Text(
                    ' Login with ',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //width: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/facebook.png",
                        scale: 1.6,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'Facebook',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account ?",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));
                        },
                        child: const Text('Sign Up',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
