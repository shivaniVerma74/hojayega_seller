import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hojayega_seller/Helper/api.path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import '../Helper/color.dart';
import '../Screen/CreateOnlineStore.dart';
import '../Screen/ThankYouScreen.dart';

class SignUpPersonal extends StatefulWidget {
  const SignUpPersonal({super.key});

  @override
  State<SignUpPersonal> createState() => _SignUpPersonalState();
}

class _SignUpPersonalState extends State<SignUpPersonal> {
  TextEditingController nameCtr =  TextEditingController();
  TextEditingController shopnameCtr =  TextEditingController();
  TextEditingController comapnynameCtr =  TextEditingController();
  TextEditingController yearOfExperianceCtr =  TextEditingController();
  TextEditingController mobileCtr =  TextEditingController();
  TextEditingController passwordCtr =  TextEditingController();
  TextEditingController confirmPasswordCtr =  TextEditingController();
  TextEditingController referalCtr =  TextEditingController();
  TextEditingController addresCtr =  TextEditingController();
  TextEditingController emailCtr =  TextEditingController();
  TextEditingController banknameCtr =  TextEditingController();
  TextEditingController accountNumberCtr =  TextEditingController();
  TextEditingController ifsccodeCtr =  TextEditingController();
  TextEditingController upiIdCtr =  TextEditingController();
  TextEditingController landmarkCtr =  TextEditingController();
  TextEditingController friendcodeCtr =  TextEditingController();


  vendorRegister() async {
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.Vendorregister));
    request.fields.addAll({
      'name': nameCtr.text,
      'shop_name': shopnameCtr.text,
      'company_name': comapnynameCtr.text,
      'year_of_experience': yearOfExperianceCtr.text,
      'mobile': mobileCtr.text,
      'email': emailCtr.text,
      'password': passwordCtr.text,
      'dob': dobCtr.text,
      'refferal_code': referalCtr.text,
      'address': addresCtr.text,
      'land_mark': landmarkCtr.text,
      'friend_code': friendcodeCtr.text,
      'bank_name': banknameCtr.text,
      'account_number': accountNumberCtr.text,
      'ifsc_code': ifsccodeCtr.text,
      'upi_id': upiIdCtr.text
    });
    print("register parameter ${request.fields}");
    request.files.add(await http.MultipartFile.fromPath('upload_location', '42zDBVcm_/Mask_Group_4.png'));
    request.files.add(await http.MultipartFile.fromPath('shop_image', _image!.path.toString()));
    request.files.add(await http.MultipartFile.fromPath('pan_image', _image2!.path.toString()));
    request.files.add(await http.MultipartFile.fromPath('adhar_front', _image3!.path.toString()));
    request.files.add(await http.MultipartFile.fromPath('adhar_back', _image4!.path.toString()));
    request.files.add(await http.MultipartFile.fromPath('adhar_back', _image5!.path.toString()));
    request.files.add(await http.MultipartFile.fromPath('qr_code', _image6!.path.toString()));
    print("register imagesss ${request.files}");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finaResult = jsonDecode(result);
      print("resonse $finaResult");
      if (finaResult['error'] == false) {
        Fluttertoast.showToast(msg: '${finaResult['message']}');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ThankYou()));
      } else {
        Fluttertoast.showToast(msg: "${finaResult['message']}");
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }


  String? _dropItem1;
  List<String> items = ['North', 'South', 'East', 'West'];
  String? _dropItem2;
  List<String> items2 = ['Maddhya Pradesh', 'Rajisthan', 'Gujarat', 'U.P'];
  String? _dropItem3;
  List<String> items3 = ['Indore', 'Bhopal', 'jaipur', 'Ujjain'];


  var i = 1;
  String _selectedOption = '1';
  final _formKey = GlobalKey<FormState>();
  var arNames = ['1', '2', '3', '4']; // Your items
  var data = [
    'Personal Information',
    'Address',
    'Account Details',
    'Upload Documents',
  ];
  bool isChecked = false;
  bool isVisible = false;
  bool isVisibleConfirm = false;

  String _selectedOption2 = 'user';
  String _selectedOption3 = 'service';
  var arrValue = ['Cake', 'fragile', 'Ready', 'Non'];
  TextEditingController dobCtr = TextEditingController();

  File? _image;
  File? _image2;
  File? _image3;
  File? _image4;
  File? _image5;
  File? _image6;
  final picker = ImagePicker();

  var imageCode;
  Future getImageGallery() async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null && imageCode == 1) {
        _image = File(pickedFile.path);
      } else if (pickedFile != null && imageCode == 2) {
        _image2 = File(pickedFile.path);
      } else if (pickedFile != null && imageCode == 3) {
        _image3 = File(pickedFile.path);
      } else if (pickedFile != null && imageCode == 4) {
        _image4 = File(pickedFile.path);
      } else if (pickedFile != null && imageCode == 5) {
        _image5 = File(pickedFile.path);
      } else if (pickedFile != null && imageCode == 6) {
        _image6 = File(pickedFile.path);
      } else {
        print('no image picked');
      }
    });
  }

  Widget _getStepCard(String step) {
    switch (step) {
      case '1':
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                          backgroundColor: colors.primary, maxRadius: 8),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Personal Information",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: colors.primary),
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
                          color: colors.secondary, fontWeight: FontWeight.bold),
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
                          activeColor: colors.secondary,
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
                          activeColor: colors.secondary,
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
                            activeColor: colors.secondary,
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
                            activeColor: colors.secondary,
                            groupValue: _selectedOption3,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedOption3 = value!;
                              });
                            },
                          ),
                          const Text("Shopkeeper")
                        ],
                      ),
                    ),
                  ),
                  if (i == 2)
                    Form(
                      key: _formKey,
                      child: Padding(
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
                                          borderRadius: BorderRadius.circular(10),
                                          color: colors.lightgray),
                                      child: Image.asset(
                                          'assets/images/person.png')),
                                ),
                                SizedBox(width: 10,),
                                Card(
                                  child: Container(
                                    width: 220,
                                    height: 50,
                                    // color: Colors.black,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your name';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Name',
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
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Card(
                                  child: Container(
                                      width: 50,
                                      height: 50,
                                      // color: Colors.black,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: colors.lightgray),
                                      child: Image.asset(
                                          'assets/images/shopname.png')),
                                ),
                                SizedBox(width: 10,),
                                Card(
                                  child: Container(
                                    width: 220,
                                    height: 50,
                                    // color: Colors.black,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your shop name';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Shop Name/Company Name',
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
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Card(
                                  child: Container(
                                      width: 50,
                                      height: 50,
                                      // color: Colors.black,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: colors.lightgray),
                                      child: Image.asset(
                                          'assets/images/yearofexperience.png')),
                                ),
                                SizedBox(width: 10,),
                                Card(
                                  child: Container(
                                    width: 220,
                                    height: 50,
                                    // color: Colors.black,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter Year of Experience';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
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
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Card(
                                  child: Container(
                                      width: 50,
                                      height: 50,
                                      // color: Colors.black,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: colors.lightgray),
                                      child: Image.asset(
                                          'assets/images/phonenumber.png')),
                                ),
                                SizedBox(width: 10,),
                                Card(
                                  child: Container(
                                    width: 220,
                                    height: 50,
                                    // color: Colors.black,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter number';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Phone Number',
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
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Card(
                                  child: Container(
                                      width: 50,
                                      height: 50,
                                      // color: Colors.black,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: colors.lightgray),
                                      child: Image.asset(
                                          'assets/images/email address.png')),
                                ),
                                SizedBox(width: 10,),
                                Card(
                                  child: Container(
                                    width: 220,
                                    height: 50,
                                    // color: Colors.black,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter address';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
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
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Card(
                                  child: Container(
                                      width: 50,
                                      height: 50,
                                      // color: Colors.black,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: colors.lightgray),
                                      child: Image.asset(
                                          'assets/images/password.png')),
                                ),
                                SizedBox(width: 10,),
                                Card(
                                  child: Container(
                                    width: 220,
                                    height: 50,
                                    // color: Colors.black,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter password';
                                        }
                                        return null;
                                      },
                                      obscureText: isVisible ? false : true,
                                      decoration: InputDecoration(
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
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Card(
                                  child: Container(
                                      width: 50,
                                      height: 50,
                                      // color: Colors.black,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: colors.lightgray),
                                      child: Image.asset(
                                          'assets/images/password.png')),
                                ),
                                SizedBox(width: 10,),
                                Card(
                                  child: Container(
                                    width: 220,
                                    height: 50,
                                    // color: Colors.black,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter confirm password';
                                        }
                                        return null;
                                      },
                                      obscureText: isVisibleConfirm ? false : true,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isVisibleConfirm
                                                    ? isVisibleConfirm = false
                                                    : isVisibleConfirm = true;
                                              });
                                            },
                                            icon: Icon(
                                              isVisibleConfirm
                                                  ? Icons.remove_red_eye
                                                  : Icons.visibility_off,
                                              color: Colors.green,
                                            ),
                                          ),
                                          hintText: 'Confirm Password',
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
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Card(
                                  child: Container(
                                      width: 50,
                                      height: 50,
                                      // color: Colors.black,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: colors.lightgray),
                                      child: Image.asset(
                                          'assets/images/daetofbirth.png')),
                                ),
                                SizedBox(width: 10,),
                                Card(
                                  child: Container(
                                    width: 220,
                                    height: 50,
                                    // color: Colors.black,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter date of birth';
                                        }
                                        return null;
                                      },
                                      controller: dobCtr,
                                      onTap: () async {
                                        DateTime? datePicked =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2024));
                                        if (datePicked != null) {
                                          print(
                                              'Date Selected:${datePicked.day}-${datePicked.month}-${datePicked.year}');
                                          String formettedDate =
                                              DateFormat('dd-MM-yyyy')
                                                  .format(datePicked);
                                          setState(() {
                                            dobCtr.text = formettedDate;
                                          });
                                        }
                                      },
                                      decoration: const InputDecoration(
                                        hintText: 'Date of Birth',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Card(
                                  child: Container(
                                      width: 50,
                                      height: 50,
                                      // color: Colors.black,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: colors.lightgray),
                                      child: Image.asset(
                                          'assets/images/refferalcode.png')),
                                ),
                                SizedBox(width: 10,),
                                Card(
                                  child: Container(
                                    width: 220,
                                    height: 50,
                                    // color: Colors.black,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter refferal code';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Refferal Code',
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
                                Checkbox(
                                    value: isChecked,
                                    activeColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    onChanged: (val) {
                                      setState(() {
                                        isChecked = val!;
                                      });
                                    }),
                                const Text(
                                  'I agree to all',
                                  style: TextStyle(fontSize: 8),
                                ),
                                TextButton(
                                    onPressed: () {
                                    },
                                    child: const Text(
                                      'terms & condition',
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500),
                                    ),
                                ),
                                const Text('and', style: TextStyle(fontSize: 12)),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'privacy policy',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap:  () {
                                if (_formKey.currentState!.validate()) {
                                  // Navigator.push(context, MaterialPageRoute(builder:(context)=> BottomNavBar()));
                                }
                              },
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width / 1.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: colors.secondary),
                                child: Center(
                                  child: Text(
                                    "Next",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: colors.whiteTemp),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      case '2':
        return
          Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child:
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: colors.primary, maxRadius: 8),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Address",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: colors.primary),
                        ),
                      ],
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
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child:
                                    Image.asset('assets/images/current address.png')),
                              ),
                              Card(
                                child: Container(
                                  width: 220,
                                  height: 50,
                                  // color: Colors.black,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: colors.lightgray),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        suffixIcon:Icon(Icons.location_searching_sharp,color:colors.secondary,),
                                        hintText: 'Current Address',
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
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: Image.asset(
                                        'assets/images/landmark.png')),
                              ),
                              Card(
                                child: Container(
                                  width: 220,
                                  height: 50,
                                  // color: Colors.black,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: colors.lightgray),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        hintText: 'Land Mark',
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
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: Image.asset(
                                        'assets/images/region.png')),
                              ),
                              Card(
                                child:Container(
                                  width: 220,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButton(

                                    isExpanded: true,
                                    value: _dropItem1,
                                    hint: const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text('Region'),
                                    ),
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    // Array list of items
                                    items: items.map((items) {
                                      return
                                        DropdownMenuItem(

                                            value: items,
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Text(items),
                                              ),
                                            )  );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _dropItem1 = newValue;
                                        //stateValue = value!;
                                        //getCity("${stateValue!.id}");
                                        //stateName = stateValue!.name;
                                        //print("name herererb $stateName");
                                      });
                                    },
                                    underline: Container(),
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
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: Image.asset(
                                        'assets/images/state.png')),
                              ),
                              Card(

                                child:Container(
                                  width: 220,
                                  height: 50,
                                  decoration: BoxDecoration(

                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButton(

                                    isExpanded: true,
                                    value: _dropItem2,
                                    hint: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text('State'),
                                    ),
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    // Array list of items
                                    items: items.map((items) {
                                      return DropdownMenuItem(
                                            value: items,
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Text(items),
                                              ),
                                            ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _dropItem2 = newValue;
                                        //stateValue = value!;
                                        //getCity("${stateValue!.id}");
                                        //stateName = stateValue!.name;
                                        //print("name herererb $stateName");
                                      });
                                    },
                                    underline: Container(),
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
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: Image.asset('assets/images/state.png')),
                              ),
                              Card(
                                child:Container(
                                  width: 220,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: _dropItem1,
                                    hint: const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text('Region'),
                                    ),
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    // Array list of items
                                    items: items.map((items) {
                                      return
                                        DropdownMenuItem(

                                            value: items,
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Text(items),
                                              ),
                                            )  );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _dropItem1 = newValue;
                                        //stateValue = value!;
                                        //getCity("${stateValue!.id}");
                                        //stateName = stateValue!.name;
                                        //print("name herererb $stateName");
                                      });
                                    },
                                    underline: Container(),
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
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: Image.asset(
                                        'assets/images/pincode.png')),
                              ),
                              Card(
                                child: Container(
                                  width: 220,
                                  height: 50,
                                  // color: Colors.black,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: colors.lightgray),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        hintText: 'Pincode',
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
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: Image.asset(
                                        'assets/images/upload current location.png')),
                              ),
                              Card(
                                child: Container(
                                  width: 220,
                                  height: 50,
                                  // color: Colors.black,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: colors.lightgray),
                                  child: TextFormField(
                                    // style: (color: Colors.red
                                    //  ),
                                    decoration: const InputDecoration(
                                        suffixIcon: Icon(Icons.file_upload_outlined,color: colors.grad1Color,),
                                        hintText: 'upload current location',hintStyle: TextStyle(color: colors.grad1Color),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Card(
                            child: Container(
                              child: Center(child: Text('Next',style: TextStyle(color: Colors.white, ),),),
                              decoration: BoxDecoration(color: colors.secondary,
                                borderRadius:  BorderRadius.circular(10),
                              ),
                              //   width: MediaQuery.of(context),
                              // decoration: BoxDecoration(borderRadius: ),
                              height:MediaQuery.of(context).size.height *0.05,
                              width: MediaQuery.of(context).size.width *.6,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
      case '3':
        return Column(
          children: [
            Card(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          CircleAvatar(
                              backgroundColor: colors.primary, maxRadius: 8),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Account Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: colors.primary),
                          ),
                        ],
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
                                          borderRadius: BorderRadius.circular(10),
                                          color: colors.lightgray),
                                      child:
                                      Image.asset('assets/images/bank name.png')),
                                ),
                                Card(
                                  child: Container(
                                    width: 220,
                                    height: 50,
                                    // color: Colors.black,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          hintText: 'Bank Name',
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
                                          borderRadius: BorderRadius.circular(10),
                                          color: colors.lightgray),
                                      child: Image.asset(
                                          'assets/images/account number.png')),
                                ),
                                Card(
                                  child: Container(
                                    width: 220,
                                    height: 50,
                                    // color: Colors.black,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          hintText: 'Account Number',
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
                                          borderRadius: BorderRadius.circular(10),
                                          color: colors.lightgray),
                                      child: Image.asset(
                                          'assets/images/IFSC code.png')),
                                ),
                                Card(
                                  child: Container(
                                    width: 220,
                                    height: 50,
                                    // color: Colors.black,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          hintText: 'IFSC code',
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
                ),
              ),
            ), Card(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                                          borderRadius: BorderRadius.circular(10),
                                          color: colors.lightgray),
                                      child:
                                      Image.asset('assets/images/upi id.png')),
                                ),
                                Card(
                                  child: Container(
                                    width: 220,
                                    height: 50,
                                    // color: Colors.black,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          hintText: 'Upi Id',
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
                                          borderRadius: BorderRadius.circular(10),
                                          color: colors.lightgray),
                                      child: Image.asset(
                                          'assets/images/upload qr code.png')),
                                ),
                                Card(
                                  child: Container(
                                    width: 220,
                                    height: 50,
                                    // color: Colors.black,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          hintText: 'Upload Qr Code',
                                          suffixIcon: Icon(Icons.file_upload_outlined,color: colors.secondary,),
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
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *0.05,
            ),
            Card(
              child: Container(
                child: Center(child: Text('Next',style: TextStyle(color: Colors.white, ),),),
                decoration: BoxDecoration(color: colors.secondary,
                  borderRadius:  BorderRadius.circular(10),
                ),
                //   width: MediaQuery.of(context),
                // decoration: BoxDecoration(borderRadius: ),
                height:MediaQuery.of(context).size.height *0.05,
                width: MediaQuery.of(context).size.width *.6,

              ),
            ),
          ],
        );
      case '4':
        return Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 2)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                          backgroundColor: colors.primary, maxRadius: 8),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Upload Document",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: colors.primary),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, left: 6),
                    child: Text(
                      "Shop Image",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: colors.text),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      imageCode = 1;
                      getImageGallery();
                    },
                    child: Card(
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          // image: DecorationImage(image:FileImage(_image!.absolute) )
                        ),
                        child: _image != null
                            ? Image.file(
                          _image!.absolute,
                          fit: BoxFit.fill,
                        )
                            : Icon(
                          Icons.file_upload_outlined,
                          color: colors.secondary,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 6),
                    child: Text(
                      "Pen Card",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: colors.text),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      imageCode = 2;
                      getImageGallery();
                    },
                    child: Card(
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          // image: DecorationImage(image:FileImage(_image!.absolute) )
                        ),
                        child: _image2 != null
                            ? Image.file(
                          _image2!.absolute,
                          fit: BoxFit.fill,
                        )
                            : Icon(
                          Icons.file_upload_outlined,
                          color: colors.secondary,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 6),
                    child: Text(
                      "Aadhar Card Front",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: colors.text),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      imageCode = 3;
                      getImageGallery();
                    },
                    child: Card(
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          // image: DecorationImage(image:FileImage(_image!.absolute) )
                        ),
                        child: _image3 != null
                            ? Image.file(
                          _image3!.absolute,
                          fit: BoxFit.fill,
                        )
                            : Icon(
                          Icons.file_upload_outlined,
                          color: colors.secondary,
                        ),
                      ),
                    ),
                  ),    Padding(
                    padding: const EdgeInsets.only(top: 10, left: 6),
                    child: Text(
                      "Aadhar Card Back",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: colors.text),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      imageCode = 4;
                      getImageGallery();
                    },
                    child: Card(
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          // image: DecorationImage(image:FileImage(_image!.absolute) )
                        ),
                        child: _image4 != null
                            ? Image.file(
                          _image4!.absolute,
                          fit: BoxFit.fill,
                        )
                            : Icon(
                          Icons.file_upload_outlined,
                          color: colors.secondary,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 6),
                    child: Text(
                      "GST Number(Optional)",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: colors.text),
                    ),
                  ),
                  Card(
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      // color: Colors.black,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colors.lightgray),
                      child: TextFormField(
                        // style: (color: Colors.red
                        //  ),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.white))),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 6),
                    child: Text(
                      "Shop At",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: colors.text),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      imageCode = 5;
                      getImageGallery();
                    },
                    child: Card(
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          // image: DecorationImage(image:FileImage(_image!.absolute) )
                        ),
                        child: _image5 != null
                            ? Image.file(
                          _image5!.absolute,
                          fit: BoxFit.fill,
                        )
                            : Icon(
                          Icons.file_upload_outlined,
                          color: colors.secondary,
                        ),
                      ),
                    ),
                  ),Padding(
                    padding: const EdgeInsets.only(top: 10, left: 6),
                    child: Row(
                      children: const [
                        CircleAvatar(
                            backgroundColor: colors.grad1Color, maxRadius: 8),
                        SizedBox(
                          width: 5,
                        ) ,
                        Text(
                          "Selfi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: colors.text),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      imageCode = 6;
                      getImageGallery();
                    },
                    child: Card(
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          // image: DecorationImage(image:FileImage(_image!.absolute) )
                        ),
                        child: _image6 != null
                            ? Image.file(
                          _image6!.absolute,
                          fit: BoxFit.fill,
                        ): const Icon(
                          Icons.file_upload_outlined,
                          color: colors.secondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateOnlineStore()));
                    },
                    child: Center(
                      child: Card(
                        child: Container(
                          child: Center(
                              child: Text('Next',style: TextStyle(color: Colors.white))),
                          decoration: BoxDecoration(color: colors.secondary,
                            borderRadius:  BorderRadius.circular(5),
                          ),
                          height:MediaQuery.of(context).size.height *0.05,
                          width: MediaQuery.of(context).size.width *.6,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      default:
        return Container(); // Empty container for no card
    }
  }

  Widget details() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: arNames.map((name) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<String>(
                value: name,
                groupValue: _selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                },
              ),
              Text(
                name,
                style: TextStyle(color: Colors.white),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final defaultPinTheme = PinTheme(
    //   width: 56,
    //   height: 56,
    //   textStyle: const TextStyle(fontSize: 20, color:Colors.white, fontWeight: FontWeight.w600),
    //   decoration: BoxDecoration(
    //     color: const Color(0xFF112C48),
    //     border: Border.all(color: const Color(0xFF112C48)),
    //     borderRadius: BorderRadius.circular(6),
    //   ),
    // );
    //
    // final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    //   border: Border.all(color: const Color(0xFF112C48)),
    //   borderRadius: BorderRadius.circular(6),
    // );
    //
    // final submittedPinTheme = defaultPinTheme.copyWith(
    //   decoration: defaultPinTheme.decoration?.copyWith(
    //     color: const Color(0xFF112C48),
    //   ),
    // );

    return Scaffold(
      backgroundColor: colors.appbarColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              "assets/images/otp verification – 3.png",
            ),
          ),
        ),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Sign up",
                      style: TextStyle(
                          color: colors.lightWhite2,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    Text(
                      "Please enter required information to complete signup.",
                      style: TextStyle(color: colors.lightWhite2, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
                child: ListView.builder(
                  scrollDirection:
                      Axis.horizontal, // Set the direction to horizontal
                  itemCount: arNames.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio<String>(
                          value: arNames[index],
                          groupValue: _selectedOption,
                          activeColor: colors.secondary,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedOption = value!;
                            });
                          },
                        ),
                        Text(
                          data[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              _getStepCard(_selectedOption),
              ///dfghjkl;
              // Card(
              //  shape: RoundedRectangleBorder(
              //    borderRadius: BorderRadius.circular(10)
              //  ),
              //   child: Container(
              //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black,width: 2)),
              //     child: Padding(
              //       padding: const EdgeInsets.all(10.0),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Row(
              //             children: [
              //               CircleAvatar(backgroundColor: colors.primary,maxRadius: 8),
              //               SizedBox(width: 5,),
              //               Text("Personal Information",style: TextStyle(fontWeight: FontWeight.bold,color: colors.primary),),
              //             ],
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(top: 5),
              //             child: Text("Kindly complete the form below, specifying the\npurpose of your application",style: TextStyle(fontSize: 12),),
              //           ),
              //
              //           Padding(
              //             padding: const EdgeInsets.only(top:8,bottom: 5 ),
              //             child: Text("User Type",style: TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),),
              //           ),
              //           Container(
              //             width: double.infinity,
              //             height: 40,
              //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
              //             child: Row(
              //               // mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 // SizedBox(width: 5,),
              //                 Radio<String>(
              //                   value: 'user',
              //                   activeColor: Colors.green,
              //                   groupValue: _selectedOption2,
              //                   onChanged: (String? value) {
              //                     setState(() {
              //                       _selectedOption2 = value!;
              //                     });
              //                   },
              //                 ),
              //                 Text("User"),
              //                 SizedBox(width: 75,),
              //                 Radio<String>(
              //                   value: 'merchant',
              //
              //                   activeColor: Colors.green,
              //                   groupValue: _selectedOption2,
              //                   onChanged: (String? value) {
              //                     setState(() {
              //                       i=2;
              //                       _selectedOption2 = value!;
              //                     });
              //                   },
              //                 ),
              //                 Text("Merchant")
              //               ],
              //             ),
              //           ) ,
              //           Padding(
              //             padding: const EdgeInsets.only(top: 10),
              //             child: Container(
              //               width: double.infinity,
              //               height: 40,
              //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
              //               child: Row(
              //                 // mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   // SizedBox(width: 5,),
              //                   Radio<String>(
              //                     value: 'service',
              //                     activeColor: Colors.green,
              //                     groupValue: _selectedOption3,
              //                     onChanged: (String? value) {
              //                       setState(() {
              //                         _selectedOption3 = value!;
              //                       });
              //                     },
              //                   ),
              //                   Text("Service Provider"),
              //                   //  SizedBox(width: 5,),
              //                   Radio<String>(
              //                     value: 'shop',
              //
              //                     activeColor: Colors.green,
              //                     groupValue: _selectedOption3,
              //                     onChanged: (String? value) {
              //                       setState(() {
              //                         _selectedOption3 = value!;
              //                       });
              //                     },
              //                   ),
              //                   Text("Shopkeeper")
              //                 ],
              //               ),
              //
              //             ),
              //           ),
              //           if(i==2)
              //
              //             Padding(
              //               padding: const EdgeInsets.only(top:5),
              //               child: Column(
              //                 children: [
              //                   Row(
              //                     children: [
              //                       Card(
              //                         child: Container(
              //                             width: 50,
              //                             height: 50,
              //                             // color: Colors.black,
              //                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.lightgray),
              //                             child: Image.asset('assets/images/name.png')
              //                         ),
              //                       ), Card(
              //                         child: Container(
              //                           width: 220,
              //                           height: 50,
              //                           // color: Colors.black,
              //                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.lightgray),
              //                           child: TextFormField(
              //                             decoration: InputDecoration(hintText: 'Name',
              //                                 enabledBorder: OutlineInputBorder(
              //                                     borderSide: BorderSide(
              //                                         color: Colors.white
              //                                     )
              //                                 ),focusedBorder: OutlineInputBorder(
              //                                     borderSide: BorderSide(
              //                                         color: Colors.white
              //                                     )
              //                                 )
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),Row(
              //                     children: [
              //                       Card(
              //                         child: Container(
              //                             width: 50,
              //                             height: 50,
              //                             // color: Colors.black,
              //                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.lightgray),
              //                             child: Image.asset('assets/images/shop name company name.png')
              //
              //                         ),
              //                       ), Card(
              //                         child: Container(
              //                           width: 220,
              //                           height: 50,
              //                           // color: Colors.black,
              //                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.lightgray),
              //                           child: TextFormField(
              //                             decoration: InputDecoration(hintText: 'Shop Name/Company Name',
              //                                 enabledBorder: OutlineInputBorder(
              //                                     borderSide: BorderSide(
              //                                         color: Colors.white
              //                                     )
              //                                 ),focusedBorder: OutlineInputBorder(
              //                                     borderSide: BorderSide(
              //                                         color: Colors.white
              //                                     )
              //                                 )
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),Row(
              //                     children: [
              //                       Card(
              //                         child: Container(
              //                             width: 50,
              //                             height: 50,
              //                             // color: Colors.black,
              //                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.lightgray),
              //                             child: Image.asset('assets/images/year of experience.png')
              //                         ),
              //                       ), Card(
              //                         child: Container(
              //                           width: 220,
              //                           height: 50,
              //                           // color: Colors.black,
              //                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.lightgray),
              //                           child: TextFormField(
              //                             decoration: InputDecoration(hintText: 'Year of Experience',
              //                                 enabledBorder: OutlineInputBorder(
              //                                     borderSide: BorderSide(
              //                                         color: Colors.white
              //                                     )
              //                                 ),focusedBorder: OutlineInputBorder(
              //                                     borderSide: BorderSide(
              //                                         color: Colors.white
              //                                     )
              //                                 )
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),Row(
              //                     children: [
              //                       Card(
              //                         child: Container(
              //                             width: 50,
              //                             height: 50,
              //                             // color: Colors.black,
              //                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.lightgray),
              //                             child: Image.asset('assets/images/phone number.png')
              //                         ),
              //                       ), Card(
              //                         child: Container(
              //                           width: 220,
              //                           height: 50,
              //                           // color: Colors.black,
              //                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.lightgray),
              //                           child: TextFormField(
              //                             decoration: InputDecoration(hintText: 'Pjone Number',
              //                                 enabledBorder: OutlineInputBorder(
              //                                     borderSide: BorderSide(
              //                                         color: Colors.white
              //                                     )
              //                                 ),focusedBorder: OutlineInputBorder(
              //                                     borderSide: BorderSide(
              //                                         color: Colors.white
              //                                     )
              //                                 )
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //
              //                   Row(
              //                     children: [
              //                       Card(
              //                         child: Container(
              //                             width: 50,
              //                             height: 50,
              //                             // color: Colors.black,
              //                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.lightgray),
              //                             child: Image.asset('assets/images/email address.png')
              //                         ),
              //                       ), Card(
              //                         child: Container(
              //                           width: 220,
              //                           height: 50,
              //                           // color: Colors.black,
              //                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.lightgray),
              //                           child: TextFormField(
              //                             decoration: InputDecoration(hintText: 'Email Address',
              //                                 enabledBorder: OutlineInputBorder(
              //                                     borderSide: BorderSide(
              //                                         color: Colors.white
              //                                     )
              //                                 ),
              //                                 focusedBorder: OutlineInputBorder(
              //                                     borderSide: BorderSide(
              //                                         color: Colors.white
              //                                     )
              //                                 )
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),  Row(
              //                     children: [
              //                       Card(
              //                         child: Container(
              //                             width: 50,
              //                             height: 50,
              //                             // color: Colors.black,
              //                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.lightgray),
              //                             child: Image.asset('assets/images/password.png')
              //                         ),
              //                       ), Card(
              //                         child: Container(
              //                           width: 220,
              //                           height: 50,
              //                           // color: Colors.black,
              //                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.lightgray),
              //                           child: TextFormField(
              //                             decoration: InputDecoration(hintText: 'Password',
              //                                 enabledBorder: OutlineInputBorder(
              //                                     borderSide: BorderSide(
              //                                         color: Colors.white
              //                                     )
              //                                 ),focusedBorder: OutlineInputBorder(
              //                                     borderSide: BorderSide(
              //                                         color: Colors.white
              //                                     )
              //                                 )
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),  Row(
              //                     children: [
              //                       Card(
              //                         child: Container(
              //                             width: 50,
              //                             height: 50,
              //                             // color: Colors.black,
              //                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.lightgray),
              //                             child: Image.asset('assets/images/password.png')
              //                         ),
              //                       ), Card(
              //                         child: Container(
              //                           width: 220,
              //                           height: 50,
              //                           // color: Colors.black,
              //                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.lightgray),
              //                           child: TextFormField(
              //                             decoration: InputDecoration(hintText: 'Confirm Password',
              //                                 enabledBorder: OutlineInputBorder(
              //                                     borderSide: BorderSide(
              //                                         color: Colors.white
              //                                     )
              //                                 ),focusedBorder: OutlineInputBorder(
              //                                     borderSide: BorderSide(
              //                                         color: Colors.white
              //                                     )
              //                                 )
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),  Row(
              //                     children: [
              //                       Card(
              //                         child: Container(
              //                             width: 50,
              //                             height: 50,
              //                             // color: Colors.black,
              //                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.lightgray),
              //                             child: Image.asset('assets/images/password.png')
              //                         ),
              //                       ), Card(
              //                         child: Container(
              //                           width: 220,
              //                           height: 50,
              //                           // color: Colors.black,
              //                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.lightgray),
              //                           child: TextFormField(
              //                             decoration: InputDecoration(hintText: 'Date of Birth',
              //                                 enabledBorder: OutlineInputBorder(
              //                                     borderSide: BorderSide(
              //                                         color: Colors.white
              //                                     )
              //                                 ),focusedBorder: OutlineInputBorder(
              //                                     borderSide: BorderSide(
              //                                         color: Colors.white
              //                                     )
              //                                 )
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),  Row(
              //                     children: [
              //                       Card(
              //                         child: Container(
              //                             width: 50,
              //                             height: 50,
              //                             // color: Colors.black,
              //                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.lightgray),
              //                             child: Image.asset('assets/images/password.png')
              //                         ),
              //                       ), Card(
              //                         child: Container(
              //                           width: 220,
              //                           height: 50,
              //                           // color: Colors.black,
              //                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.lightgray),
              //                           child: TextFormField(
              //                             decoration: InputDecoration(hintText: 'Refferal Code',
              //                                 enabledBorder: OutlineInputBorder(
              //                                     borderSide: BorderSide(
              //                                         color: Colors.white
              //                                     )
              //                                 ),focusedBorder: OutlineInputBorder(
              //                                     borderSide: BorderSide(
              //                                         color: Colors.white
              //                                     )
              //                                 )
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        )),
      ),
    );
  }
}
