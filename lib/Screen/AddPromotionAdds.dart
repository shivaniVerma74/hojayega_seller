import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hojayega_seller/Helper/api.path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/color.dart';
import 'package:http/http.dart' as http;

import 'BottomBar.dart';

class AddPromotionAdds extends StatefulWidget {
  const AddPromotionAdds({Key? key}) : super(key: key);

  @override
  State<AddPromotionAdds> createState() => _AddPromotionAddsState();
}

class _AddPromotionAddsState extends State<AddPromotionAdds> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSetting();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }


  var imageCode;
  File? _image;
  final picker = ImagePicker();

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null && imageCode == 1) {
        _image = File(pickedFile.path);
      }  else {
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
      }  else {
        print('no image picked');
      }
    });
  }

  TextEditingController startDateCtr = TextEditingController();
  TextEditingController endDateCtr = TextEditingController();
  TextEditingController dayCtr = TextEditingController();
  TextEditingController totalamtCtr = TextEditingController();

  Future<void> _showPickerOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                getImageGallery();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                _getImageFromCamera();
                Navigator.pop(context);
                // _getImage(ImageSource.camera);
              },
            ),
          ],
        );
      },
    );
  }

  checkAvailability() async {
    var headers = {
      'Cookie': 'ci_session=a7ed57b5c2abb7aa515a4dd255b0524db51e286b'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.checkAvailablity));
    request.fields.addAll({
      'start_date': startDateCtr.text,
      'end_date': endDateCtr.text
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finaResult = jsonDecode(result);
      Fluttertoast.showToast(msg: '${finaResult['message']}');
    }
    else {
      print(response.reasonPhrase);
    }
  }


  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: "Payment successfully");
    // addPromotionAdd();
    Navigator.pop(context);
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment cancelled by user");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}


Razorpay? _razorpay;
int? pricerazorpayy;

void openCheckout(amount) async {
  double res = double.parse(amount.toString());
  pricerazorpayy= int.parse(res.toStringAsFixed(0)) * 100;
  // Navigator.of(context).pop();
  var options = {
    'key': 'rzp_test_1DP5mmOlF5G5ag',
    'amount': "$pricerazorpayy",
    'name': 'Hojayega',
    'image':'assets/images/Group 165.png',
    'description': 'Hojayega',
  };
  try {
    _razorpay?.open(options);
  } catch (e) {
    debugPrint('Error: e');
  }
}


String? banner_Charge;
int? amount;

getSetting() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var headers = {
    'Cookie': 'ci_session=bfa970b6e13a45a52775a4cd4995efa6026d6895'
  };
  var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getSettings));
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    var result = await response.stream.bytesToString();
    var finaResult = jsonDecode(result);
    print("responseee $finaResult");
    if (finaResult['status'] == 1) {
      banner_Charge = finaResult['setting']['banner_per_day_charge'];
      await prefs.setString('banner_Charge', finaResult['setting']['banner_per_day_charge'].toString());
      print('____banner charge is$banner_Charge ___');
      setState(() {});
      // Fluttertoast.showToast(msg: '${finaResult['message']}');
    } else {
      // Fluttertoast.showToast(msg: "${finaResult['message']}");
    }
  } else {
    print(response.reasonPhrase);
  }
}

  String? vendorId, roll;
  addPromotionAdd() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    vendorId = preferences.getString('vendor_id');
    roll=  preferences.getString('roll');
    print("vendor id add product screen $vendorId");
    var headers = {
      'Cookie': 'ci_session=d3b1699eb1ea7c8e063b47767b2b9c44a2205458'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.promotionAdd));
    request.fields.addAll({
      'user_id': vendorId.toString(),
      'start_date': startDateCtr.text,
      'end_date': endDateCtr.text,
      'day': dayCtr.text,
      'total_amount': totalamtCtr.text,
      'transaction_id': 'wallet',
      'type': roll=="1" ? "shop" : "service"
    });
    print("===============${request.fields}===========");
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
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
      startDateCtr = TextEditingController(text: _dateValue);
    });
  }

  Future _selectEndDate() async {
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
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent)),
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
      endDateCtr = TextEditingController(text: _dateValue);
      DateTime date1 = DateTime.parse(startDateCtr.text);
      DateTime date2 = DateTime.parse(endDateCtr.text);
      Duration difference = date2.difference(date1);
      print("The difference in days is: ${difference.inDays}");
      dayCtr.text=difference.inDays.toString();
      totalamtCtr.text=(int.parse(dayCtr.text.toString()) * int.parse(banner_Charge.toString())).toString();
      // setState(() {
      //   // dayCtr.text=difference.inDays.toString();
      //   dayCtr.text=y.toString();
      // });

    });
  }

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          title: const Text('Promotion & Adds'),
          backgroundColor: colors.primary),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  imageCode = 1;
                  _showPickerOptions();
                },
                child: Card(
                  child: Container(
                    height: MediaQuery.of(context).size.height/4.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: _image != null
                        ? Image.file(
                      _image!.absolute,
                      fit: BoxFit.fill,
                    ): Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Column(
                        children: const [
                          Text("Upload Image", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                          Icon(
                            Icons.file_upload_outlined,
                            color: colors.secondary,
                            size: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 0, left: 12, right: 8),
                            height: 50,
                            decoration: BoxDecoration(
                                color: colors.whiteTemp,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: colors.primary)
                            ),
                            width: MediaQuery.of(context).size.width/2-30,
                            child: TextFormField(
                              onTap: () {
                                _selectDate1();
                              },
                              // enabled: false,
                              style: const TextStyle(color: Colors.black),
                              controller: startDateCtr,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              decoration: const InputDecoration(
                                  // suffix: Text("₹"),
                                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                                  counterText: '',
                                  border: InputBorder.none,
                                  hintText: "Start Date"
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 0, left: 12, right: 8),
                            height: 50,
                            decoration: BoxDecoration(
                                color: colors.whiteTemp,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: colors.primary)
                            ),
                            width: MediaQuery.of(context).size.width/2-30,
                            child: TextFormField(
                              onTap: () {
                                _selectEndDate();
                                DateTime date1 = DateTime.parse(startDateCtr.text);
                                DateTime date2 = DateTime.parse(endDateCtr.text);
                                Duration difference = date2.difference(date1);
                                print("The difference in days is: ${difference.inDays}");
                                int y=difference.inDays;
                                dayCtr.text=difference.inDays.toString();
                                // setState(() {
                                //   // dayCtr.text=difference.inDays.toString();
                                //   dayCtr.text=y.toString();
                                // });
                              },
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              controller: endDateCtr,
                              decoration: const InputDecoration(
                                  // suffix: Text("₹"),
                                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                                  counterText: '',
                                  border: InputBorder.none,
                                  hintText: "End Date"
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 0, left: 12, right: 8),
                    height: 60,
                    decoration: BoxDecoration(
                        color: colors.whiteTemp,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colors.primary)
                    ),
                    width: MediaQuery.of(context).size.width/1.1,
                    child: TextFormField(
                      readOnly: true,
                      style: const TextStyle(color: Colors.black),
                      // controller: oldPriceController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              checkAvailability();
                            },
                              child: const Icon(Icons.calendar_month),
                          ),
                          contentPadding: const EdgeInsets.only(top: 16),
                          counterText: '',
                          border: InputBorder.none,
                          hintText: "Check Availability"
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 0, left: 12, right: 8),
                          height: 60,
                          decoration: BoxDecoration(
                              color: colors.whiteTemp,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: colors.primary)
                          ),
                          width: MediaQuery.of(context).size.width/2-30,
                          child: TextFormField(
                            readOnly: true,
                            style: const TextStyle(color: Colors.black),
                            // controller: oldPriceController,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            decoration:  InputDecoration(
                              // suffixIcon: Icon(Icons.calendar_month),
                              // contentPadding: EdgeInsets.only(top: 16),
                                counterText: '',
                                border: InputBorder.none,
                                hintStyle: const TextStyle(fontWeight: FontWeight.w400),
                                hintText: "Charges: $banner_Charge"
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 0, left: 12, right: 8),
                          height: 60,
                          decoration: BoxDecoration(

                              color: colors.whiteTemp,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: colors.primary)
                          ),
                          width: MediaQuery.of(context).size.width/2-30,
                          child: TextFormField(
                            readOnly: true,
                            onChanged:(value) => {
                              totalamtCtr.text = "${(int.parse(banner_Charge??""))* (int.parse(value))} RS",
                              print("===============${totalamtCtr.text}==========="),
                            },
                            style:  const TextStyle(color: Colors.black),
                            controller: dayCtr,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            decoration:  const InputDecoration(
                              // suffixIcon: Icon(Icons.calendar_month),
                              // contentPadding: EdgeInsets.only(top: 16),
                                counterText: '',
                                border: InputBorder.none,
                                hintStyle: TextStyle(fontWeight: FontWeight.w400),
                                hintText: "Total Days"
                            ),

                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 0, left: 12, right: 8),
                    height: 60,
                    decoration: BoxDecoration(
                        color: colors.whiteTemp,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colors.primary)
                    ),
                    width: MediaQuery.of(context).size.width/1.1,
                    child: TextFormField(
                      readOnly: true,
                      style: const TextStyle(color: Colors.black),
                      controller: totalamtCtr,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 16),
                          counterText: '',
                          border: InputBorder.none,
                          hintText: "Total Amount "
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70),
              Center(
                child: Card(
                  child: InkWell(
                    onTap: () {
                      if (_image == null || startDateCtr.text == "" || startDateCtr.text == null || endDateCtr.text == "" || endDateCtr.text == "" ||
                          dayCtr.text == "" ||dayCtr.text == null  || totalamtCtr.text == null  || totalamtCtr.text == ""
                      ) {
                        Fluttertoast.showToast(msg: "Please Fill All Fields");
                      }
                      addPromotionAdd();
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          'Pay',
                          style: TextStyle(
                            color: Colors.white, fontSize: 19
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: colors.secondary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * .6,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
