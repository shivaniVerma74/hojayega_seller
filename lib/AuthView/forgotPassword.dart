import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/Color.dart';
import '../Helper/api.path.dart';
import 'package:http/http.dart' as http;

import 'Login.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({super.key, this.userId});
  String? userId;
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  bool isChecked = false;
  bool isVisible = false;
  bool isVisible1 = false;

  String? _validateEmail(value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Your Email/Phone Number';
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

  @override
  initState() {
    super.initState();
    getData();
  }

  String? vendorId;
  getData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    vendorId = preferences.getString('vendor_id');
    // return getVendorOrder();
  }

  sendOtp() async {
    var headers = {
      'Cookie': 'ci_session=05bf1731f8a5f6bc9d9143b990a080085dfb8659'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiServicves.resetpassword));
    request.fields.addAll({
      'user_id': vendorId.toString(),
      'password': passwordcontroller.text.toString()
    });
    print("forhot passs ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finaResult = jsonDecode(result);
      print("===my technic=======${request.url}===============");
      print("===my technic=======${request.fields}===============");
      if (finaResult['status'] == 1) {
        Fluttertoast.showToast(msg: '${finaResult['msg']}');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false);
      } else {}
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                        )),
                  ],
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFE2EBFE)),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back,
                              color: colors.primary,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Positioned(
                    top: 65,
                    left: 20,
                    child: Text('Forgot Password',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
                Positioned(
                    top: MediaQuery.of(context).size.height / 9,
                    left: 50,
                    right: 50,
                    child: Image.asset("assets/images/SIGN UP.png", scale: 2)),
                Positioned(
                  top: 330,
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
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              children: [
                                Card(
                                  elevation: 5,
                                  child: Container(
                                      height: 40,
                                      color: Colors.grey.shade100,
                                      child: Image.asset(
                                        "assets/images/lock.png",
                                        height: 20,
                                      )
                                    // Icon(Icons.phone, size: 48,
                                    //   color: Colors.green,),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    elevation: 5,
                                    child: TextFormField(
                                      obscureText: isVisible ? false : true,
                                      maxLength: 10,
                                      controller: passwordcontroller,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          counterText: "",
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
                                          // suffixIcon: suffixIcons,
                                          contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          hintText: "Password"),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Password';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              children: [
                                Card(
                                  elevation: 5,
                                  child: Container(
                                    height: 40,
                                    color: Colors.grey.shade100,
                                    child: Image.asset(
                                      "assets/images/lock.png",
                                      height: 20,
                                    ),
                                    // Icon(Icons.phone, size: 48,
                                    //   color: Colors.green,),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    elevation: 5,
                                    child: TextFormField(
                                      obscureText: isVisible1 ? false : true,
                                      maxLength: 10,
                                      controller: conpasswordcontroller,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          counterText: "",
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isVisible1
                                                    ? isVisible1 = false
                                                    : isVisible1 = true;
                                              });
                                            },
                                            icon: Icon(
                                              isVisible1
                                                  ? Icons.remove_red_eye
                                                  : Icons.visibility_off,
                                              color: Colors.green,
                                            ),
                                          ),
                                          // suffixIcon: suffixIcons,
                                          contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          hintText: "New Password"),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Confirm Password';
                                        } else if (conpasswordcontroller.text
                                            .toString() !=
                                            passwordcontroller.text.toString()) {
                                          return 'Confirm Password Not Matched';
                                        }
                                        return null;
                                      },
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
                            width: 250,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  sendOtp();
                                  // Navigator.push(context, MaterialPageRoute(builder:(context)=>Otp()));
                                }
                                // Navigator.push(context, MaterialPageRoute(builder:(context)=>ForgetPassword()));
                              },
                              child: Text('Submit'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
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
          )),
    );
  }

  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController conpasswordcontroller = TextEditingController();
}
