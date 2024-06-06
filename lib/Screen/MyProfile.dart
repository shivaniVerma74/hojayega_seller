import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hojayega_seller/Helper/color.dart';
import 'package:hojayega_seller/Model/GetAreaModel.dart';
import 'package:hojayega_seller/Model/GetCityModel.dart';
import 'package:hojayega_seller/Model/StateModel.dart';
// import 'package:ho_jayega_seller/screen/Calender.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AuthView/SignUpPersonal.dart';
import '../Helper/api.path.dart';
import '../Model/GetProfileModel.dart';
import 'Calender.dart';

// import '../utils/utils.dart';
class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var shopController = TextEditingController();
  var yearController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var dobController = TextEditingController();
  var refferalcodeController = TextEditingController();
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

  String _selectedOption = '1';
  String _selectedOption2 = 'user';
  String _selectedOption3 = 'service';
  List<String> items = ['North', 'South', 'East', 'West'];
  List<StataData> stateList = [];
  List<CityData> cityList = [];
  List<CountryData> countryList = [];
  CityData? cityValue;
  CountryData? countryValue;
  StataData? stateValue;
  String? stateName;
  String? stateId;
  String? cityId;
  String? countryId;
  String? cityName;
  String? countryName;
  String? adhaarFront;
  String? adhaarBack;
  String? panImage;
  String? selfiImage;
  String? customerLocationImage;
  String? shopImage;

  List<String> items3 = ['Indore', 'Bhopal', 'jaipur', 'Ujjain'];

  File? _qrimage;
  File? _currentlocationimage;
  File? _image;
  File? _image2;
  File? _image3;
  File? _image4;
  File? _image5;
  File? _image6;
  bool isVisible = true;
  bool isVisible2 = true;
  bool isLoading = true;

  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return "Please enter an email";
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return "Please enter a valid email";
    }
  }

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

  loading() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  String errorText = '';
  void initState() {
    loading();
    dropdownController.text = items[0];
    super.initState();
    getUserCurrentLocation();
    getProfile().then((val) {
      nameController.text = profileData?.data?.first.uname ?? "";
      shopController.text = profileData?.data?.first.shopName ?? "";
      yearController.text = profileData?.data?.first.yearOfExperience ?? "";
      phoneController.text = profileData?.data?.first.mobile ?? "";
      emailController.text = profileData?.data?.first.email ?? "";
      addressController.text = profileData?.data?.first.address ?? "";
      refferalcodeController.text = profileData?.data?.first.refferalCode ?? "";
      dobController.text = profileData?.data?.first.dob ?? "";
      currentlocationController.text = profileData?.data?.first.address ?? "";
      landController.text = profileData?.data?.first.landMark ?? "";
      stateId = profileData?.data?.first.state ?? "";
      cityId = profileData?.data?.first.city ?? "";
      countryId = profileData?.data?.first.region ?? "";
      banknameController.text = profileData?.data?.first.bandDetails ?? "";
      selfiImage = profileData?.data?.first.selfiImage;
      adhaarBack = profileData?.data?.first.adharBack;
      adhaarFront = profileData?.data?.first.adharFront;
      customerLocationImage = profileData?.data?.first.customerLocation;
      panImage = profileData?.data?.first.panImage;
      shopImage = profileData?.data?.first.shopImage;
      getState();
      getCity(stateId);
      getArea(cityId);
    });
  }

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

  getState() async {
    print("state apiii isss");
    var headers = {
      'Cookie': 'ci_session=95bbd5f6f543e31f65185f824755bcb57842c775'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getState));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (mounted) {
        setState(() {
          stateList = StateModel.fromJson(userData).data!;
          if (stateId != null) {
            for (var stateValue in stateList) {
              if (stateValue.id == stateId) {
                this.stateValue = stateValue;
              }
            }
          }
          print("state list is $stateList");
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  getCity(String? sId) async {
    var headers = {
      'Cookie': 'ci_session=95bbd5f6f543e31f65185f824755bcb57842c775'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getCities));
    request.fields.addAll({'state_id': sId.toString()});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (mounted) {
        setState(() {
          cityList = GetCityModel.fromJson(userData).data!;
          print("city list is $stateList");
        });
        if (cityId != null) {
          for (var cityValue in cityList) {
            if (cityValue.id == cityId) {
              this.cityValue = cityValue;
            }
          }
        }
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  getArea(String? city_Id) async {
    var headers = {
      'Cookie': 'ci_session=cb5a399c036615bb5acc0445a8cd39210c6ca648'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getArea));
    request.headers.addAll(headers);
    request.fields.addAll({'city_id': city_Id.toString()});
    print("get aresaa ${request.fields}");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (mounted) {
        setState(() {
          countryList = GetAreaModel.fromJson(userData).data!;
        });
        print("region list is $countryList");
        if (countryId != null) {
          for (var countryValue in countryList) {
            if (countryValue.id == countryId) {
              this.countryValue = countryValue;
            }
          }
        }
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  String? vendorId;
  GetProfileModel? profileData;
  getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    vendorId = prefs.getString("vendor_id");
    var headers = {
      'Cookie': 'ci_session=1826473be67eeb9329a8e5393f7907573d116ca1'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getProfile));
    request.fields.addAll({'user_id': vendorId.toString()});
    debugPrint("get profile parametersssss ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = GetProfileModel.fromJson(json.decode(finalResponse));
      print("profile data responsee $finalResult");
      setState(() {
        profileData = finalResult;
        setState(() {});
      });
    } else {
      print(response.reasonPhrase);
    }
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

  updateProfile() async {
    var headers = {
      'Cookie': 'ci_session=e4642f1868d270720612d7de7ba4c0ab33b140ed'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.updateProfile));
    request.fields.addAll({
      'name': nameController.text,
      'shop_name': shopController.text,
      'year_of_experience': yearController.text,
      'mobile': phoneController.text,
      'email': emailController.text,
      'dob': dobController.text,
      'refferal_code': refferalcodeController.text,
      'address': addressController.text,
      'land_mark': landController.text,
      'bank_name': banknameController.text,
      'account_number': accountNumberController.text,
      'ifsc_code': ifscController.text,
      'upi_id': upiidContoler.text,
      'roll': _selectedOption3 == "shop" ? "1" : "2",
      'city': cityId.toString(),
      'state': stateId.toString(),
      'region': countryId.toString(),
      "shop_type": _selectedOption3 == "shop" ? "1" : "2",
      "gst_no": gstNumberController.text,
      "latitude": currentLocation!.latitude.toString(),
      "longitude": currentLocation!.longitude.toString(),
    });
    print("update profile ${request.fields}");
    request.headers.addAll(headers);
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
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Position? currentLocation;

  getUserCurrentLocation() async {
    var status = await Permission.location.request();
    print("location status $status");
    if (status.isDenied) {
      Fluttertoast.showToast(msg: "Permision is requiresd");
    } else if (status == PermissionStatus.granted) {
      print("workingggggg");
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((position) {
        print("current location isss ${position.latitude}");
        if (mounted) {
          setState(() {
            currentLocation = position;
            print("current location isss ${currentLocation!.latitude}");
            homelat = currentLocation!.latitude;
            homeLong = currentLocation!.longitude;
            print("home lat long is $homeLong &&& $homelat");
          });
        }
      });
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          foregroundColor: colors.whiteTemp,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          title: const Text('MyProfile'),
          backgroundColor: colors.primary),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, right: 5),
                            child: Column(
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightgray),
                                        child: TextFormField(
                                          controller: nameController,
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightgray),
                                        child: TextFormField(
                                          controller: shopController,
                                          decoration: const InputDecoration(
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
                                              'assets/images/yearofexperience.png')),
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
                                          controller: yearController,
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightgray),
                                        child: TextFormField(
                                          controller: phoneController,
                                          decoration: const InputDecoration(
                                              hintText: 'Phone Number',
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white))),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
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
                                        height: 50,
                                        // color: Colors.black,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightgray),
                                        child: TextFormField(
                                          controller: emailController,
                                          validator: _validateEmail,
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightgray),
                                        child: TextFormField(
                                          controller: dobController,
                                          decoration: const InputDecoration(
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightgray),
                                        child: TextFormField(
                                          controller: refferalcodeController,
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
                                // Padding(
                                //   padding: const EdgeInsets.all(10.0),
                                //   child: Card(
                                //     child: InkWell(
                                //       onTap: (){
                                //         if (_formKey.currentState!.validate()) {
                                //           setState(() {
                                //             _selectedOption = '2';
                                //           });
                                //
                                //           // Navigator.pushReplacement(
                                //           //   context,
                                //           //   MaterialPageRoute(builder: (context) => HomeScreen()),
                                //           // );
                                //           print(nameController.text.toString());
                                //           print(shopController.text.toString());
                                //           print(yearController.text.toString());
                                //           print(phoneController.text.toString());
                                //           print(emailController.text.toString());
                                //           print(passwordController.text.toString());
                                //           print(confirmPasswordController.text.toString());
                                //           print(dobController.text.toString());
                                //           print(refferalcodeController.text.toString());
                                //         }
                                //         // print(nameController.text.toString());
                                //         // print(shopController.text.toString());
                                //         // print(yearController.text.toString());
                                //         // print(phoneController.text.toString());
                                //         // print(emailController.text.toString());
                                //         // print(passwordController.text.toString());
                                //         // print(confirmPasswordController.text.toString());
                                //         // print(dobController.text.toString());
                                //         // print(refferalcodeController.text.toString());
                                //
                                //
                                //
                                //       },
                                //       child: Container(
                                //         child: Center(
                                //           child: Text(
                                //             'Next',
                                //             style: TextStyle(
                                //               color: Colors.white,
                                //             ),
                                //           ),
                                //         ),
                                //         decoration: BoxDecoration(
                                //           color: colors.secondary,
                                //           borderRadius: BorderRadius.circular(10),
                                //         ),
                                //         //   width: MediaQuery.of(context),
                                //         // decoration: BoxDecoration(borderRadius: ),
                                //         height: MediaQuery.of(context).size.height * 0.05,
                                //         width: MediaQuery.of(context).size.width * .6,
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Padding(
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: colors.lightgray),
                                                child: Image.asset(
                                                    'assets/images/current address.png')),
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
                                                controller: addressController,
                                                decoration:
                                                    const InputDecoration(
                                                        suffixIcon: Icon(
                                                          Icons
                                                              .location_searching_sharp,
                                                          color:
                                                              colors.secondary,
                                                        ),
                                                        hintText:
                                                            'Current Address',
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .white))),
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
                                                        BorderRadius.circular(
                                                            10),
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
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: colors.lightgray),
                                              child: TextFormField(
                                                controller: landController,
                                                decoration: const InputDecoration(
                                                    hintText: 'Land Mark',
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .white))),
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
                                                        BorderRadius.circular(
                                                            10),
                                                    color: colors.lightgray),
                                                child: Image.asset(
                                                    'assets/images/state.png')),
                                          ),
                                          Card(
                                            child: Container(
                                              width: 220,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: DropdownButton(
                                                isExpanded: true,
                                                value: stateValue,
                                                hint: const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text('State'),
                                                ),
                                                // Down Arrow Icon
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                // Array list of items
                                                items: stateList.map((items) {
                                                  return DropdownMenuItem(
                                                      value: items,
                                                      child: Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(items.name
                                                              .toString()),
                                                        ),
                                                      ));
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    stateValue = newValue;
                                                    getCity(
                                                        "${stateValue!.id}");
                                                    stateName =
                                                        stateValue!.name;
                                                    stateId = stateValue!.id;
                                                    debugPrint(
                                                        "name herererb $stateName $stateId");
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: colors.lightgray),
                                                child: Image.asset(
                                                    'assets/images/state.png')),
                                          ),
                                          Card(
                                            child: Container(
                                              width: 220,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                // boxShadow: const [
                                                //   BoxShadow(
                                                //     color: Colors.grey,
                                                //     offset: Offset(
                                                //       1.0,
                                                //       1.0,
                                                //     ),
                                                //     blurRadius: 0.2,
                                                //     spreadRadius: 0.5,
                                                //   ),
                                                // ],
                                              ),
                                              child: DropdownButton(
                                                isExpanded: true,
                                                value: cityValue,
                                                hint: const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text('City'),
                                                ),
                                                // Down Arrow Icon
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                // Array list of items
                                                items: cityList.map((items) {
                                                  return DropdownMenuItem(
                                                      value: items,
                                                      child: Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(items.name
                                                              .toString()),
                                                        ),
                                                      ));
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    cityValue = newValue;
                                                    getArea("${cityValue!.id}");
                                                    cityName = cityValue!.name;
                                                    cityId = cityValue!.id;
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: colors.lightgray),
                                                child: Image.asset(
                                                    'assets/images/region.png')),
                                          ),
                                          Card(
                                            child: Container(
                                              width: 220,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                // boxShadow: const [
                                                //   BoxShadow(
                                                //     color: Colors.grey,
                                                //     offset: Offset(
                                                //       1.0,
                                                //       1.0,
                                                //     ),
                                                //     blurRadius: 0.2,
                                                //     spreadRadius: 0.5,
                                                //   ),
                                                // ],
                                              ),
                                              child: DropdownButton(
                                                isExpanded: true,
                                                value: countryValue,
                                                hint: const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text('Region'),
                                                ),
                                                // Down Arrow Icon
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                // Array list of items
                                                items: countryList.map((items) {
                                                  return DropdownMenuItem(
                                                      value: items,
                                                      child: Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(items.name
                                                              .toString()),
                                                        ),
                                                      ));
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    countryValue = newValue;
                                                    countryId =
                                                        countryValue!.id;
                                                    print(
                                                        "name herererb $countryId");
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: colors.lightgray),
                                              child: TextFormField(
                                                controller: pincodeController,
                                                decoration: const InputDecoration(
                                                    hintText: 'Pincode',
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .white))),
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
                                                height: 80,
                                                // color: Colors.black,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: colors.lightgray),
                                                child: Image.asset(
                                                    'assets/images/uploadcurrentlocation.png')),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: colors.primary)
                                                    // image: DecorationImage(image:FileImage(_image!.absolute) )
                                                    ),
                                                child: _currentlocationimage !=
                                                        null
                                                    ? Image.file(
                                                        _currentlocationimage!
                                                            .absolute,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : const Icon(
                                                        Icons
                                                            .file_upload_outlined,
                                                        color: colors.secondary,
                                                        size: 50,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Card(
                                      //   child: InkWell(
                                      //     onTap: (){
                                      //
                                      //       if(_dropItem1==null)
                                      //       {
                                      //         Utils().toastMessage("select region ");
                                      //       }
                                      //       if(_dropItem2==null)
                                      //       {
                                      //         Utils().toastMessage("select state");
                                      //       }
                                      //
                                      //
                                      //
                                      //       if (_formKey.currentState!.validate()&&_dropItem1!=null &&_dropItem2!=null ) {
                                      //
                                      //         print(addressController.text.toString());
                                      //         print(landController.text.toString());
                                      //         print(_dropItem1);
                                      //         print(_dropItem2);
                                      //         print(pincodeController.text.toString());
                                      //         print(currentlocationController.text.toString());
                                      //         // validateDropdown();
                                      //         // showToast();
                                      //         setState(() {
                                      //           _selectedOption = '3';
                                      //         });
                                      //       }
                                      //
                                      //     },
                                      //
                                      //
                                      //     child: Container(
                                      //       child: Center(
                                      //         child: Text(
                                      //           'Next',
                                      //           style: TextStyle(
                                      //             color: Colors.white,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //       decoration: BoxDecoration(
                                      //         color: colors.secondary,
                                      //         borderRadius: BorderRadius.circular(10),
                                      //       ),
                                      //       //   width: MediaQuery.of(context),
                                      //       // decoration: BoxDecoration(borderRadius: ),
                                      //       height: MediaQuery.of(context).size.height * 0.05,
                                      //       width: MediaQuery.of(context).size.width * .6,
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Padding(
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
                                                        BorderRadius.circular(
                                                            10),
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
                                                decoration: const InputDecoration(
                                                    hintText: 'Bank Name',
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .white))),
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
                                                        BorderRadius.circular(
                                                            10),
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
                                                keyboardType:
                                                    TextInputType.number,
                                                controller:
                                                    accountNumberController,
                                                decoration: const InputDecoration(
                                                    hintText: 'Account Number',
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .white))),
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
                                                        BorderRadius.circular(
                                                            10),
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
                                                decoration: const InputDecoration(
                                                    hintText: 'IFSC code',
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .white))),
                                              ),
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black, width: 2)),
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
                                                        BorderRadius.circular(
                                                            10),
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
                                                // validator: (value) {
                                                //   if (value == null || value.isEmpty) {
                                                //     return 'Enter UPI ID';
                                                //   }
                                                //   return null;
                                                // },
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: 'Upi Id',
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .white))),
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
                                                        BorderRadius.circular(
                                                            10),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: colors.primary),
                                                    color: Colors.white,
                                                    // image: DecorationImage(image:FileImage(_image!.absolute) )
                                                  ),
                                                  child: _qrimage != null
                                                      ? Image.file(
                                                          _qrimage!.absolute,
                                                          fit: BoxFit.fill,
                                                        )
                                                      : Image.network(
                                                      "https://developmentalphawizz.com/hojayega${selfiImage!}",
                                                          fit: BoxFit.fill,
                                                        )),
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
                    ),

                    // Card(
                    //   child: InkWell(
                    //     onTap: (){
                    //       validateDropdown();
                    //
                    //       if (_formKey.currentState!.validate()) {
                    //         setState(() {
                    //           _selectedOption = '4';
                    //         });
                    //
                    //       }
                    //
                    //     },
                    //     child: Container(
                    //       child: Center(
                    //         child: Text(
                    //           'Next',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //       ),
                    //       decoration: BoxDecoration(
                    //         color: colors.secondary,
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       //   width: MediaQuery.of(context),
                    //       // decoration: BoxDecoration(borderRadius: ),
                    //       height: MediaQuery.of(context).size.height * 0.05,
                    //       width: MediaQuery.of(context).size.width * .6,
                    //     ),
                    //   ),
                    //
                    //
                    //   ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Padding(
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
                                        fontWeight: FontWeight.bold,
                                        color: colors.text),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: colors.primary)
                                            // image: DecorationImage(image:FileImage(_image!.absolute) )
                                            ),
                                        child: _image != null
                                            ? Image.file(
                                                _image!.absolute,
                                                fit: BoxFit.fill,
                                              )
                                            : Image.network(
                                                "https://developmentalphawizz.com/hojayega${shopImage!}",
                                                fit: BoxFit.fill,
                                              )),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10, left: 6),
                                  child: Text(
                                    "Pan Card",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colors.text),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: colors.primary)
                                            // image: DecorationImage(image:FileImage(_image!.absolute) )
                                            ),
                                        child: _image2 != null
                                            ? Image.file(
                                                _image2!.absolute,
                                                fit: BoxFit.fill,
                                              )
                                            : Image.network(
                                              "https://developmentalphawizz.com/hojayega${panImage!}",
                                                fit: BoxFit.fill,
                                              )),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10, left: 6),
                                  child: Text(
                                    "Aadhaar Card (Front)",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colors.text),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: colors.primary)
                                            // image: DecorationImage(image:FileImage(_image!.absolute) )
                                            ),
                                        child: _image3 != null
                                            ? Image.file(
                                                _image3!.absolute,
                                                fit: BoxFit.fill,
                                              )
                                            : Image.network(
                                             "https://developmentalphawizz.com/hojayega$adhaarFront",
                                                fit: BoxFit.fill,
                                              )),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10, left: 6),
                                  child: Text(
                                    "Aadhaar Card (Back)",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colors.text),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: colors.primary)
                                            // image: DecorationImage(image:FileImage(_image!.absolute) )
                                            ),
                                        child: _image4 != null
                                            ? Image.file(
                                                _image4!.absolute,
                                                fit: BoxFit.fill,
                                              )
                                            : Image.network(
                                          "https://developmentalphawizz.com/hojayega${adhaarBack!}",
                                                fit: BoxFit.fill,
                                              ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10, left: 6),
                                  child: Text(
                                    "GST Number(Optional)",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colors.text),
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
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white))),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10, left: 6),
                                  child: Text(
                                    "Shop At",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colors.text),
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
                                          border:
                                              Border.all(color: colors.primary),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          // image: DecorationImage(image:FileImage(_image!.absolute) )
                                        ),
                                        child: _image5 != null
                                            ? Image.file(
                                                _image5!.absolute,
                                                fit: BoxFit.fill,
                                              )
                                            : Image.network(
                                            "https://developmentalphawizz.com/hojayega${customerLocationImage!}",
                                                fit: BoxFit.fill)),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 6),
                                  child: Row(
                                    children: const [
                                      CircleAvatar(
                                          backgroundColor: colors.grad1Color,
                                          maxRadius: 8),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Selfie",
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: colors.primary)
                                            // image: DecorationImage(image:FileImage(_image!.absolute) )
                                            ),
                                        child: _image6 != null
                                            ? Image.file(
                                                _image6!.absolute,
                                                fit: BoxFit.fill,
                                              )
                                            : Image.network(
                                          "https://developmentalphawizz.com/hojayega${selfiImage!}",
                                                fit: BoxFit.fill,
                                              )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Card(
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: colors.secondary,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        //   width: MediaQuery.of(context),
                                        // decoration: BoxDecoration(borderRadius: ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .6,
                                        child: Center(
                                          child: Text(
                                            'Update Profile',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
