import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/api.path.dart';
import '../Helper/color.dart';
import '../Model/GetAreaModel.dart';
import '../Model/GetCityModel.dart';
import '../Model/StateModel.dart';
import '../Screen/ThankYouScreen.dart';

class SignUpPersonal extends StatefulWidget {
  const SignUpPersonal({super.key});

  @override
  State<SignUpPersonal> createState() => _SignUpPersonalState();
}

class _SignUpPersonalState extends State<SignUpPersonal> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownController.text = items[0];
    getstate();
  }

  var nameController = TextEditingController();
  var shopController = TextEditingController();
  var yearController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var dobController = TextEditingController();
  var refferalcodeController = TextEditingController();
  var friendcodeController = TextEditingController();
  var addressController = TextEditingController();
  var landController = TextEditingController();

  //var regionController =TextEditingController();
  var dropdownController = TextEditingController();

  var stateController = TextEditingController();
  var cityController = TextEditingController();
  var pincodeController = TextEditingController();
  var currentlocationController = TextEditingController();

  var banknameController = TextEditingController();
  var accountNumberController = TextEditingController();
  var ifscController = TextEditingController();
  var upiidContoler = TextEditingController();
  var qrCodeController = TextEditingController();

  var shopimageController = TextEditingController();
  var penCardController = TextEditingController();
  var aadharCardContoller = TextEditingController();
  var aadharCardBackContoller = TextEditingController();
  var gstNumberController = TextEditingController();
  var shopAtContoller = TextEditingController();
  var selfiContoller = TextEditingController();


  String? vendor_name;
  String? vendor_email;
  String? roll;
  String? vendor_id;

  vendorRegister() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=1933939351e474eec93704742fca8b88967a1584'
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiServicves.vendorregister));
    request.fields.addAll({
      'name': nameController.text,
      'shop_name': shopController.text,
      // 'company_name': comapnynameCtr.text,
      'year_of_experience': yearController.text,
      'mobile': phoneController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'dob': dobController.text,
      'refferal_code': refferalcodeController.text,
      'address': currentlocationController.text,
      'land_mark': landController.text,
      'friend_code': friendcodeController.text,
      'bank_name': banknameController.text,
      'account_number': accountNumberController.text,
      'ifsc_code': ifscController.text,
      'upi_id': upiidContoler.text,
      'roll': _selectedOption3 == "service" ? "1" : "2",
      'city': cityId.toString(),
      'state': stateId.toString(),
      'region': countryId.toString(),
      "shop_type": _selectedOption3 == "service" ? "1" : "2",
      "gst_no": gstNumberController.text
    });
    print("register parameter ${request.fields}");
    request.files.add(
      await http.MultipartFile.fromPath(
          'upload_location', _currentlocationimage?.path ?? ""),
    );
    request.files.add(
        await http.MultipartFile.fromPath('shop_image', _image?.path ?? ""));
    request.files.add(
        await http.MultipartFile.fromPath('pan_image', _image2?.path ?? ""));
    request.files.add(
        await http.MultipartFile.fromPath('adhar_front', _image3?.path ?? ""));
    request.files.add(
        await http.MultipartFile.fromPath('adhar_back', _image4?.path ?? ""));
    request.files.add(
        await http.MultipartFile.fromPath('adhar_back', _image5?.path ?? ""));
    request.files.add(
        await http.MultipartFile.fromPath('selfi_image', _image6?.path ?? ""));
    request.files.add(
        await http.MultipartFile.fromPath('qr_code', _qrimage?.path ?? ""));
    print("register imagesss ${request.files}");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("resonse-------${response.statusCode}");
      var result = await response.stream.bytesToString();
      var finaResult = jsonDecode(result);
      print("resonse===== $finaResult");
      if (finaResult['response_code'] == '1') {
        vendor_id = finaResult['data']['id'];
        await prefs.setString('vendor_id', finaResult['data']['id'].toString());
        await prefs.setString('vendor_name', finaResult['data']['username'].toString());
        await prefs.setString('vendor_email', finaResult['data']['email'].toString());
        await prefs.setString('roll', finaResult['data']['roll'].toString());
        vendor_name = finaResult['data']['username'];
        vendor_email = finaResult['data']['email'];
        roll = finaResult['data']['roll'];
        print("ggghhhhhjjff");
        Fluttertoast.showToast(msg: '${finaResult['message']}');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ThankYou()));
        nameController.clear();
        shopController.clear();
        yearController.clear();
        passwordController.clear();
        emailController.clear();
        dobController.clear();
        refferalcodeController.clear();
        currentlocationController.clear();
        landController.clear();
        banknameController.clear();
        accountNumberController.clear();
        ifscController.clear();
        upiidContoler.clear();
        friendcodeController.clear();
      } else {
        Fluttertoast.showToast(msg: "${finaResult['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  var i = 1;
  String _selectedOption = '1';
  var arNames = ['1', '2', '3', '4']; // Your items

  String errorText = '';

  void validateDropdown() {
    if (dropdownController.text.isEmpty) {
      setState(() {
        errorText = 'Please select an item';
      });
    } else {
      setState(() {
        errorText = '';
      });
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isVisible = true;
  bool isVisibleTwo = true;
  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return "Please enter an email";
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return "Please enter a valid email";
    }
  }

  var data = [
    'Personal Information',
    'Address',
    'Account Details',
    'Upload Document',
  ];

  String? _dropItem1;
  List<String> items = ['North', 'South', 'East', 'West'];
  String? _dropItem2;
  List<String> items2 = ['Maddhya Pradesh', 'Rajisthan', 'Gujarat', 'U.P'];
  String? _dropItem3;
  List<String> items3 = ['Indore', 'Bhopal', 'jaipur', 'Ujjain'];

  String _selectedOption2 = 'user';
  String _selectedOption3 = 'service';
  var arrValue = ['Cake', 'fragile', 'Ready', 'Non'];

  File? _qrimage;
  File? _currentlocationimage;
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
      } else if (pickedFile != null && imageCode == 7) {
        _currentlocationimage = File(pickedFile.path);
      } else if (pickedFile != null && imageCode == 8) {
        _qrimage = File(pickedFile.path);
      } else {
        print('no image picked');
      }
    });
  }

  Future _getImageFromCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
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
      } else if (pickedFile != null && imageCode == 7) {
        _currentlocationimage = File(pickedFile.path);
      } else if (pickedFile != null && imageCode == 8) {
        _qrimage = File(pickedFile.path);
      } else {
        print('no image picked');
      }
    });
  }

  List<CityData> cityList = [];
  List<CountryData> countryList = [];
  List<StataData> stateList = [];
  CityData? cityValue;
  CountryData? countryValue;
  StataData? stateValue;
  String? stateName;
  String? stateId;
  String? cityId;
  String? countryId;
  String? cityName;

  bool showPassword = false;
  bool showPasswordNew = false;

  getstate() async {
    print("state apiii isss");
    var headers = {
      'Cookie': 'ci_session=95bbd5f6f543e31f65185f824755bcb57842c775'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getState));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (mounted) {
        setState(() {
          stateList = StateModel.fromJson(userData).data!;
          print("state list is $stateList");
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  getCity(String? sId) async{
    var headers = {
      'Cookie': 'ci_session=95bbd5f6f543e31f65185f824755bcb57842c775'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getCities));
    request.fields.addAll({
      'state_id': sId.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (mounted) {
        setState(() {
          cityList = GetCityModel.fromJson(userData).data!;
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  getArea(String? city_Id) async {
    var headers = {
      'Cookie': 'ci_session=cb5a399c036615bb5acc0445a8cd39210c6ca648'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getArea));
    request.fields.addAll({
      'city_id': city_Id.toString()
    });
    print("get aresaa ${request.fields}");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (mounted) {
        setState(() {
          countryList = GetAreaModel.fromJson(userData).data!;
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  String _dateValue = '';
  var dateFormate;

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  Future _selectDate1() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: colors.primary,
                // accentColor: Colors.black,
                colorScheme: ColorScheme.light(primary: colors.primary),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        dateFormate = DateFormat("dd/MM/yyyy").format(DateTime.parse(_dateValue ?? ""));
      });
    setState(() {
      dobController = TextEditingController(text: _dateValue);
    });
  }


  Future<void> _showPickerOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () {
                getImageGallery();
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () {
                _getImageFromCamera();
                // _getImage(ImageSource.camera);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _getStepCard(String step) {
    switch (step) {
      case '1':
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
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
                    // const Padding(
                    //   padding: EdgeInsets.only(top: 8, bottom: 5),
                    //   child: Text(
                    //     "User Type",
                    //     style: TextStyle(
                    //         color: colors.secondary,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    // Container(
                    //   width: double.infinity,
                    //   height: 40,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       border: Border.all(color: Colors.black)),
                    //   child: Row(
                    //     // mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       // SizedBox(width: 5,),
                    //       Radio<String>(
                    //         value: 'user',
                    //         activeColor: Colors.green,
                    //         groupValue: _selectedOption2,
                    //         onChanged: (String? value) {
                    //           setState(() {
                    //             _selectedOption2 = value!;
                    //           });
                    //         },
                    //       ),
                    //       Text("User"),
                    //       SizedBox(
                    //         width: 75,
                    //       ),
                    //       Radio<String>(
                    //         value: 'merchant',
                    //         activeColor: Colors.green,
                    //         groupValue: _selectedOption2,
                    //         onChanged: (String? value) {
                    //           setState(() {
                    //             i = 2;
                    //             _selectedOption2 = value!;
                    //           });
                    //         },
                    //       ),
                    //       Text("Merchant")
                    //     ],
                    //   ),
                    // ),
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
                            const Text("Service Provider"),
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
                            const Text("Shopkeeper")
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
                                          'assets/images/person.png')),
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
                                      controller: nameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter  Name';
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
                                          'assets/images/shopname.png')),
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
                                      controller: shopController,
                                      decoration: const InputDecoration(
                                          hintText: 'Shop Name/Company Name',
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white))),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter shop name';
                                        }
                                        return null;
                                      },
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
                                          'assets/images/yearofexperience.png')),
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
                                      controller: yearController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          hintText: 'Year of Experience',
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white))),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter your experience';
                                        }
                                        return null;
                                      },
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
                                          'assets/images/phonenumber.png')),
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
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                      controller: phoneController,
                                      decoration: const InputDecoration(
                                        counterText: "",
                                          hintText: 'Phone Number',
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white))),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter Phone Number';
                                        } else if (value.length < 10) {
                                          return 'At least 10 characters required';
                                        }
                                        return null;
                                      },
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

                                  // height: 50,
                                    // color: Colors.black,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: TextFormField(

                                      controller: emailController,
                                      validator: _validateEmail,
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                          hintText: 'Email Address',

                                          enabledBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(


                                                  color: Colors.white)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white))
                                      ),
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
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: TextFormField(
                                      controller: passwordController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter password';
                                        } else if (value.length < 8) {
                                          return 'At least 8 characters required';
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
                                              color: colors.secondary,
                                            ),
                                          ),
                                          hintText: 'Password',
                                          enabledBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white))
                                      ),
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
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: TextFormField(
                                      controller: confirmPasswordController,
                                      obscureText: isVisibleTwo ? false : true,
                                      validator: (value) {
                                        if (value != passwordController.text
                                                .toString()) {
                                          return 'Enter Not Match';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isVisibleTwo
                                                    ? isVisibleTwo = false
                                                    : isVisibleTwo = true;
                                              });
                                            },
                                            icon: Icon(
                                              isVisibleTwo
                                                  ? Icons.remove_red_eye
                                                  : Icons.visibility_off,
                                              color: colors.secondary,
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
                                          'assets/images/daetofbirth.png')),
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
                                      onTap: () {
                                        _selectDate1();
                                      },
                                      controller: dobController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter DOB';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Date of Birth',
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
                                          'assets/images/refferalcode.png')),
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
                                      controller: refferalcodeController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter Refferal Code';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
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
                            // Row(
                            //   children: [
                            //     Card(
                            //       child: Container(
                            //           width: 50,
                            //           height: 50,
                            //           // color: Colors.black,
                            //           decoration: BoxDecoration(
                            //               borderRadius:
                            //               BorderRadius.circular(10),
                            //               color: colors.lightgray),
                            //           child: Image.asset(
                            //               'assets/images/refferalcode.png')),
                            //     ),
                                // Card(
                                //   child: Container(
                                //     width: 220,
                                //     height: 50,
                                //     // color: Colors.black,
                                //     decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(10),
                                //         color: colors.lightgray),
                                //     child: TextFormField(
                                //       controller: friendcodeController,
                                //       validator: (value) {
                                //         if (value == null || value.isEmpty) {
                                //           return 'Enter Friend Code';
                                //         }
                                //         return null;
                                //       },
                                //       decoration: InputDecoration(
                                //           hintText: 'Friend Code',
                                //           enabledBorder: OutlineInputBorder(
                                //               borderSide: BorderSide(
                                //                   color: Colors.white)),
                                //           focusedBorder: OutlineInputBorder(
                                //               borderSide: BorderSide(
                                //                   color: Colors.white))),
                                //     ),
                                //   ),
                                // ),
                            //   ],
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                child: InkWell(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _selectedOption = '2';
                                      });
                                      print(nameController.text.toString());
                                      print(shopController.text.toString());
                                      print(yearController.text.toString());
                                      print(phoneController.text.toString());
                                      print(emailController.text.toString());
                                      print(passwordController.text.toString());
                                      print(confirmPasswordController.text.toString());
                                      print(dobController.text.toString());
                                      print(refferalcodeController.text.toString());
                                      print(friendcodeController.text.toString());
                                    }
                                  },
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        'Next',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: colors.secondary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    //   width: MediaQuery.of(context),
                                    // decoration: BoxDecoration(borderRadius: ),
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    width:
                                        MediaQuery.of(context).size.width * .6,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      case '2':
        return Form(
          key: _formKey,
          child: Card(
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
                      children: [
                        CircleAvatar(
                            backgroundColor: colors.primary, maxRadius: 8),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Address",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colors.primary),
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
                                    child: Image.asset('assets/images/current address.png')),
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
                                    controller: addressController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter Current Address';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.location_searching_sharp,
                                          color: colors.secondary,
                                        ),
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
                                        'assets/images/landmark.png'),
                                ),
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
                                    controller: landController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter Land Mark';
                                      }
                                      return null;
                                    },
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
                                    child: Image.asset('assets/images/state.png')),
                              ),
                              Card(
                                child: Container(
                                  width: 220,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child:
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      value: stateValue,
                                      hint: const Text('State'),
                                      // Down Arrow Icon
                                      icon: const Icon(Icons.keyboard_arrow_down),
                                      // Array list of items
                                      items: stateList.map((items) {
                                        return
                                          DropdownMenuItem(
                                            value: items,
                                            child: Container(
                                                child: Text(items.name.toString())),
                                          );
                                      }).toList(),
                                      onChanged: (StataData? value) {
                                        setState(() {
                                          stateValue = value!;
                                          getCity("${stateValue!.id}");
                                          stateName = stateValue!.name;
                                          stateId = stateValue!.id;
                                          print("name herererb $stateName $stateId" );
                                        });
                                      },
                                      underline: Container(),
                                    ),
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
                                    child:
                                    Image.asset('assets/images/state.png')),
                              ),
                              Card(
                                child: Container(
                                  width: 220,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      value: cityValue,
                                      hint: const Text('City'),
                                      // Down Arrow Icon
                                      icon: const Icon(Icons.keyboard_arrow_down),
                                      // Array list of items
                                      items: cityList.map((items) {
                                        return DropdownMenuItem(value: items, child: Container(child: Text(items.name.toString())),
                                        );
                                      }).toList(),
                                      onChanged: (CityData? value) {
                                        setState(() {
                                          cityValue = value!;
                                          getArea("${cityValue!.id}");
                                          cityId = cityValue!.id;
                                          // stateName = stateValue!.name;
                                          print("name herererb $cityValue $cityId");
                                        });
                                      },
                                      underline: Container(),
                                    ),
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
                                    child:
                                    Image.asset('assets/images/region.png')),
                              ),
                              Card(
                                child: Container(
                                  width: 220,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      value: countryValue,
                                      hint: const Text('Region'),
                                      // Down Arrow Icon
                                      icon: const Icon(Icons.keyboard_arrow_down),
                                      // Array list of items
                                      items: countryList.map((items) {
                                        return
                                          DropdownMenuItem(
                                            value: items,
                                            child: Container(
                                                child: Text(items.name.toString())),
                                          );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged: (CountryData? value) {
                                        setState(() {
                                          countryValue = value!;
                                          countryId = countryValue!.id;
                                          // getstate("${countryValue!.id}");
                                          // ("${stateValue!.id}");
                                          // stateName = stateValue!.name;
                                          print("name herererb $countryId");
                                        });
                                      },
                                      underline: Container(),
                                    ),
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
                                    maxLength: 6,
                                    controller: pincodeController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter Pin code';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      counterText: "",
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
                                    height: 75,
                                    // color: Colors.black,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.lightgray),
                                    child: Image.asset(
                                        'assets/images/uploadcurrentlocation.png'),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  imageCode = 7;
                                  //  getImageGallery();
                                  _showPickerOptions();
                                },
                                child: Card(
                                  child: Container(
                                    height: 80,
                                    width: 220,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: colors.primary),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                      // image: DecorationImage(image:FileImage(_image!.absolute) )
                                    ),
                                    child: _currentlocationimage != null
                                        ? Image.file(
                                            _currentlocationimage!.absolute,
                                            fit: BoxFit.fill,
                                          )
                                        : Icon(

                                            Icons.file_upload_outlined,
                                            color: colors.secondary,
                                      size: 50,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Card(
                            child: InkWell(
                              onTap: () {
                                if (countryValue== null) {
                                  Fluttertoast.showToast(msg: "Slect Region");
                                }
                                if (stateValue == null) {
                                  Fluttertoast.showToast(msg: "Slect state");
                                }

                                if (_formKey.currentState!.validate() && stateValue != null && cityValue != null) {
                                  print(addressController.text.toString());
                                  print(landController.text.toString());
                                  print(countryValue);
                                  print(stateValue);
                                  print(pincodeController.text.toString());
                                  print(currentlocationController.text
                                      .toString());
                                  // validateDropdown();
                                  // showToast();
                                  setState(() {
                                    _selectedOption = '3';
                                  });
                                }
                              },
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'Next',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: colors.secondary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                //   width: MediaQuery.of(context),
                                // decoration: BoxDecoration(borderRadius: ),
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * .6,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      case '3':
        return Form(
          key: _formKey,
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
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
                                  fontWeight: FontWeight.bold,
                                  color: colors.primary),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightgray),
                                        child: Image.asset(
                                            'assets/images/bankname.png')),
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
                                        controller: banknameController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter Bank Name';
                                          }
                                          return null;
                                        },
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightgray),
                                        child: Image.asset(
                                            'assets/images/accountnumber.png')),
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
                                        keyboardType: TextInputType.number,
                                        controller: accountNumberController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter Accoutn Number';
                                          } else if (value.length < 10) {
                                            return 'At least 10 characters required';
                                          }
                                          return null;
                                        },
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightgray),
                                        child: Image.asset(
                                            'assets/images/IFSCcode.png')),
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
                                        controller: ifscController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter IFSC Code';
                                          } else if (value.length < 10) {
                                            return 'At least 10 characters required';
                                          }
                                          return null;
                                        },
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
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightgray),
                                        child: Image.asset(
                                            'assets/images/upiid.png')),
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
                                        controller: upiidContoler,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter UPI ID';
                                          }
                                          return null;
                                        },
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
                                        height: 75,
                                        // color: Colors.black,
                                        decoration: BoxDecoration(

                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightgray),
                                        child: Image.asset(
                                            'assets/images/uploadqrcode.png')),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      imageCode = 8;
                                      //  getImageGallery();
                                      _showPickerOptions();
                                    },
                                    child: Card(
                                      child: Container(
                                        height: 80,
                                        width: 220,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: colors.primary),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          // image: DecorationImage(image:FileImage(_image!.absolute) )
                                        ),
                                        child: _qrimage != null
                                            ? Image.file(
                                                _qrimage!.absolute,
                                                fit: BoxFit.fill,
                                              )
                                            : const Icon(
                                                Icons.file_upload_outlined,
                                                color: colors.secondary,
                                          size: 50,
                                              ),
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
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Card(
                child: InkWell(
                  onTap: () {
                    validateDropdown();
                    if (_formKey.currentState!.validate()) {
                      setState(() {

                        _selectedOption = '4';
                      });
                    }
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: colors.secondary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    //   width: MediaQuery.of(context),
                    // decoration: BoxDecoration(borderRadius: ),
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * .6,
                  ),
                ),
              )
            ],
          ),
        );
      case '4':
        return Form(
          key: _formKey,
          child: Card(
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
                              fontWeight: FontWeight.bold,
                              color: colors.primary),
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
                        _showPickerOptions();
                        // getImageGallery();
                        // _getImageFromCamera();
                      },
                      child: Card(
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: colors.primary),
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
                            size: 50,
                                ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 6),
                      child: Text(
                        "Pen Card",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: colors.text),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        imageCode = 2;
                        //  getImageGallery();
                        _showPickerOptions();
                      },
                      child: Card(
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: colors.primary),
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
                            size: 50,
                                ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 6),
                      child: Text(
                        "Aadhar Card (Front)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: colors.text),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        imageCode = 3;
                        //  getImageGallery();
                        _showPickerOptions();
                      },
                      child: Card(
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: colors.primary),
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
                            size: 50,
                                ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 6),
                      child: Text(
                        "Aadhar Card (Back)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: colors.text),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        imageCode = 4;
                        //  getImageGallery();
                        _showPickerOptions();
                      },
                      child: Card(
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: colors.primary),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            // image: DecorationImage(image:FileImage(_image!.absolute) )
                          ),
                          child: _image4 != null
                              ? Image.file(
                                  _image4!.absolute,
                                  fit: BoxFit.fill,
                                )
                              : const Icon(
                                  Icons.file_upload_outlined,
                                  color: colors.secondary,
                            size: 50,
                                ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 6),
                      child: Text(
                        "GST Number(Optional)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: colors.text),
                      ),
                    ),
                    Card(
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        // color: Colors.black,
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(10),
                            color: colors.lightgray),
                        child: TextFormField(
                          controller: gstNumberController,
                          // style: (color: Colors.red
                          //  ),
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 6),
                      child: Text(
                        "Shop At",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: colors.text),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        imageCode = 5;
                        //  getImageGallery();
                        _showPickerOptions();
                      },
                      child: Card(
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: colors.primary),
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
                            size: 50,
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 6),
                      child: Row(
                        children: const [
                          CircleAvatar(
                              backgroundColor: colors.grad1Color, maxRadius: 8),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Selfi",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colors.text),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        imageCode = 6;
                        //  getImageGallery();
                        _showPickerOptions();
                      },
                      child: Card(
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: colors.primary),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            // image: DecorationImage(image:FileImage(_image!.absolute) )
                          ),
                          child: _image6 != null
                              ? Image.file(
                                  _image6!.absolute,
                                  fit: BoxFit.fill,
                                )
                              : Icon(
                                  Icons.file_upload_outlined,
                                  color: colors.secondary,
                              size: 50,

                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            if (_image == null || _image2 == null || _image3 == null || _image4 == null || _image5 == null || _image6 == null) {
                              Fluttertoast.showToast(msg: "Select All Images");
                            }
                            vendorRegister();
                            // if (_formKey.currentState!.validate()) {
                            //   vendorRegister();
                            // }
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ThankYou()));
                          },
                          child: Container(
                            child: Center(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: colors.secondary,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            //   width: MediaQuery.of(context),
                            // decoration: BoxDecoration(borderRadius: ),
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * .6,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      default:
        return Container(); // Empty container for no card
    }
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colors.appbarColor,
      body: Container(
        decoration: BoxDecoration(
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
                  children: [
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
                              // _selectedOption = value!;
                              // _selectedOption = value!;
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
            ],
          ),
        )),
      ),
    );
  }
}
