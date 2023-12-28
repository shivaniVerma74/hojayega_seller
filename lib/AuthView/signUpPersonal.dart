import 'package:flutter/material.dart';
import '../Helper/color.dart';

class SignUpPersonal extends StatefulWidget {
  const SignUpPersonal({super.key});

  @override
  State<SignUpPersonal> createState() => _SignUpPersonalState();
}

class _SignUpPersonalState extends State<SignUpPersonal> {
  var i = 1;
  String _selectedOption = '1';
  String _selectedOption2 = 'user';
  String _selectedOption3 = 'service';
  var arrValue = ['Cake', 'fragile', 'Ready', 'Non'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      body: SingleChildScrollView(
          child: Stack(clipBehavior: Clip.none, children: [
        Container(child: Image.asset('assets/images/otp verification – 3.png')),
        Positioned(
            top: 55,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sign up",
                  style: TextStyle(
                      color: colors.lightWhite2,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                const Text(
                  "Please enter required information to complete signup.",
                  style: TextStyle(color: colors.lightWhite2, fontSize: 12),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio<String>(
                      value: '1',
                      activeColor: colors.secondary,
                      groupValue: _selectedOption,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                    const Text(
                      'Personal Information',
                      style: TextStyle(
                          color: colors.lightWhite2,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                    Radio<String>(
                      value: '2',
                      activeColor: colors.secondary,
                      groupValue: _selectedOption,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                    const Text('Address',
                        style: TextStyle(
                            color: colors.lightWhite2,
                            fontWeight: FontWeight.bold,
                            fontSize: 10)),
                    Radio<String>(
                      value: '3',
                      activeColor: colors.secondary,
                      groupValue: _selectedOption,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                    const Text('Account Details',
                        style: TextStyle(
                            color: colors.lightWhite2,
                            fontWeight: FontWeight.bold,
                            fontSize: 10)),
                  ],
                ),
                const Icon(
                  Icons.arrow_back,
                  color: colors.lightWhite2,
                ),
              ],
            ),
        ),
        Positioned(
            top: 180,
            left: 25,
            right: 25,
            child: SingleChildScrollView(
              child: Stack(
                  // clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      //   width:MediaQuery.of(context).size.width*.5 ,
                      height: i > 1
                          ? MediaQuery.of(context).size.height * .8
                          : MediaQuery.of(context).size.height * .35,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              CircleAvatar(
                                  backgroundColor: colors.primary,
                                  maxRadius: 8),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Personal Information",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: colors.primary),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              "Kindly complete the form below, specifying the\npurpose of your application",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 5),
                            child: Text(
                              "User Type",
                              style: TextStyle(
                                  color: colors.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black)),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // SizedBox(width: 5,),
                                Radio<String>(
                                  value: 'user',
                                  activeColor: Colors.green,
                                  groupValue: _selectedOption2,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedOption2 = value!;
                                    });
                                  },
                                ),
                                Text("User"),
                                SizedBox(
                                  width: 75,
                                ),
                                Radio<String>(
                                  value: 'merchant',
                                  activeColor: Colors.green,
                                  groupValue: _selectedOption2,
                                  onChanged: (String? value) {
                                    setState(() {
                                      i = 2;
                                      _selectedOption2 = value!;
                                    });
                                  },
                                ),
                                Text("Merchant")
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black)),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // SizedBox(width: 5,),
                                  Radio<String>(
                                    value: 'service',
                                    activeColor: Colors.green,
                                    groupValue: _selectedOption3,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedOption3 = value!;
                                      });
                                    },
                                  ),
                                  Text("Service Provider"),
                                  //  SizedBox(width: 5,),
                                  Radio<String>(
                                    value: 'shop',
                                    activeColor: Colors.green,
                                    groupValue: _selectedOption3,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedOption3 = value!;
                                      });
                                    },
                                  ),
                                  Text("Shopkeeper")
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Card(
                                      child: Container(
                                          width: 50,
                                          height: 50,
                                          // color: Colors.black,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: colors.lightgray),
                                          child: Image.asset(
                                            'assets/images/person.png',
                                            scale: 1.5,
                                          )),
                                    ),
                                    Card(
                                      child: Container(
                                        width: 220,
                                        height: 50,
                                        // color: Colors.black,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightgray),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              hintText: 'Name',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Card(
                                      child: Container(
                                          width: 50,
                                          height: 50,
                                          // color: Colors.black,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: colors.lightgray),
                                          child: Image.asset(
                                              'assets/images/shop name company name.png')),
                                    ),
                                    Card(
                                      child: Container(
                                        width: 220,
                                        height: 50,
                                        // color: Colors.black,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightgray),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText:
                                                  'Shop Name/Company Name',
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Card(
                                      child: Container(
                                          width: 50,
                                          height: 50,
                                          // color: Colors.black,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: colors.lightgray),
                                          child: Image.asset(
                                              'assets/images/year of experience.png')),
                                    ),
                                    Card(
                                      child: Container(
                                        width: 220,
                                        height: 50,
                                        // color: Colors.black,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightgray),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: 'Year of Experience',
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Card(
                                      child: Container(
                                          width: 50,
                                          height: 50,
                                          // color: Colors.black,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: colors.lightgray),
                                          child: Image.asset(
                                              'assets/images/phone number.png')),
                                    ),
                                    Card(
                                      child: Container(
                                        width: 220,
                                        height: 50,
                                        // color: Colors.black,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightgray),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: 'Pjone Number',
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Card(
                                      child: Container(
                                          width: 50,
                                          height: 50,
                                          // color: Colors.black,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: colors.lightgray),
                                          child: Image.asset(
                                              'assets/images/email address.png')),
                                    ),
                                    Card(
                                      child: Container(
                                        width: 220,
                                        height: 50,
                                        // color: Colors.black,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightgray),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: 'Email Address',
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Card(
                                      child: Container(
                                          width: 50,
                                          height: 50,
                                          // color: Colors.black,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: colors.lightgray),
                                          child: Image.asset(
                                              'assets/images/password.png')),
                                    ),
                                    Card(
                                      child: Container(
                                        width: 220,
                                        height: 50,
                                        // color: Colors.black,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightgray),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: 'Password',
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
            )),
      ])),
    );
  }
}
