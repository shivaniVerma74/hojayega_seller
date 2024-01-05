import 'package:flutter/material.dart';
import 'package:hojayega_seller/AuthView/Login.dart';

import 'Verifyotp.dart';

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  bool isChecked = false;
  bool isVisible = false;
  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return "Please enter an Email/Phone number ";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset(
                      'assets/images/otp verification – 3.png',
                    ),
                  )),
            ],
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(8),
          //     color: Colors.white,
          //   ),
          //   margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          //   height: 35,
          //   width: 38,
          //   child: IconButton(
          //     icon: const Center(
          //         child: Icon(
          //       Icons.arrow_back,
          //       color: Colors.green,
          //     )),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          // ),
          const Positioned(
              top: 60,
              left: 20,
              child: Text(
                'Forget Password',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
          const Positioned(
              top: 110,
              left: 20,
              right: 20,
              child: Text(
                'Please enter your number you are registered with to receive OTP to reset password. ',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
          ),
          Positioned(
              top: 140,
              left: 50,
              right: 50,
              child: Image.asset(
                "assets/images/forgetpassword.png",
                scale: 1.4,
              ),
          ),
          Positioned(
            top: 380,
            bottom: 50,
            left: 20,
            right: 20,
            child: SingleChildScrollView(
              child: Container(
                // margin: EdgeInsets.fromLTRB(20, 400, 20, 150),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                        child: Row(
                          children: [
                            Card(
                              elevation: 5,
                              child: Container(
                                width: 50,
                                height: 50,
                                color: Colors.grey.shade100,
                                child: const Icon(
                                  Icons.phone,
                                  size: 25,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
                                elevation: 5,
                                child: TextFormField(
                                  controller: email,
                                  validator: _validateEmail,
                                  // keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: "Email/Phone Number",
                                    isDense: true,
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    // labelText: 'Email/Phone Number',
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade100)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade100)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        height: 45,
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtp()));
                            }
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text(
                            'Send OTP',
                          ),
                        ),
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
