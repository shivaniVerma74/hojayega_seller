import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hojayega_seller/Helper/api.path.dart';
import 'package:hojayega_seller/Screen/BottomBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/color.dart';
import 'AddPromotionAdds.dart';

class PromotionAdds extends StatefulWidget {
  const PromotionAdds({Key? key}) : super(key: key);

  @override
  State<PromotionAdds> createState() => _PromotionAddsState();
}

class _PromotionAddsState extends State<PromotionAdds> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSetting();
  }

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPromotionAdds()));
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40,),
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(150), color: colors.primary
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 37,),
          ),
        ),
      ),
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selected = 0;
                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: selected == 0
                                  ? colors.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: colors.primary)),
                          child: Center(
                            child: Text(
                              'Promotion',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: selected == 0
                                      ? Colors.white
                                      : colors.primary),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selected = 1;
                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: selected == 1
                                  ? colors.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: colors.primary)),
                          child: Center(
                            child: Text(
                              '15 Sec Adds',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: selected == 1
                                      ? Colors.white
                                      : colors.primary),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selected = 2;
                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: selected == 2
                                  ? colors.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: colors.primary)),
                          child: Center(
                            child: Text(
                              'History',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: selected == 2 ? Colors.white : colors.primary),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            selected == 0 ? getFirstTap() : getsecondTapFields()
          ],
        ),
      ),
    );
  }

  getFirstTap() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
            children: const [
              Text("25 October", style: TextStyle(fontWeight: FontWeight.bold, color: colors.primary, fontSize: 18),),
              Text("5 Day = 500",style: TextStyle(fontWeight: FontWeight.bold, color: colors.primary, fontSize: 18))
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Image.asset("assets/images/specialdeal.png"),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
            children: const [
              Text("25 October", style: TextStyle(fontWeight: FontWeight.bold, color: colors.primary, fontSize: 18),),
              Text("5 Day = 500",style: TextStyle(fontWeight: FontWeight.bold, color: colors.primary, fontSize: 18))
            ],
          ),
        ),
        Image.asset("assets/images/superbanner.png"),
      ],
    );
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


  String? vendorId;
  addOffers() async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    vendorId = preferences.getString('vendor_id');
    print("vendor id add product screen $vendorId");
    var headers = {
      'Cookie': 'ci_session=60bef4788330603caab520de3a388682e1b2fdea'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.offers));
    request.fields.addAll({
      'user_id': vendorId.toString(),
      'type': 'shop',
      'total_amount': totalamtCtr.text,
      'transaction_id': 'wallet'
    });
    print("===============${request.fields}===========");
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
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


  TextEditingController startDateCtr = TextEditingController();
  TextEditingController endDateCtr = TextEditingController();

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
                accentColor: Colors.black,
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
                accentColor: Colors.black,
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
    });
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController totalAmtCtr = TextEditingController();

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
  TextEditingController dayCtr = TextEditingController();
  TextEditingController totalamtCtr = TextEditingController();

  getsecondTapFields() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          SizedBox(height: 20,),
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
          // Padding(
          //   padding: const EdgeInsets.only(left: 15, right: 15),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.only(top: 12, bottom: 12),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Container(
          //               padding: EdgeInsets.only(top: 0, left: 12, right: 8),
          //               height: 50,
          //               decoration: BoxDecoration(
          //                   color: colors.whiteTemp,
          //                   borderRadius: BorderRadius.circular(10),
          //                   border: Border.all(color: colors.primary)
          //               ),
          //               width: MediaQuery.of(context).size.width/1.1,
          //               child: TextFormField(
          //                 onTap: () {
          //                   _selectDate1();
          //                 },
          //                 // enabled: false,
          //                 style: const TextStyle(color: Colors.black),
          //                 controller: startDateCtr,
          //                 keyboardType: TextInputType.number,
          //                 maxLength: 10,
          //                 decoration: const InputDecoration(
          //                   // suffix: Text("₹"),
          //                     contentPadding: EdgeInsets.symmetric(vertical: 0),
          //                     counterText: '',
          //                     border: InputBorder.none,
          //                     hintText: "Start Date"
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       // Padding(
          //       //   padding: const EdgeInsets.only(top: 12, bottom: 12),
          //       //   child: Column(
          //       //     crossAxisAlignment: CrossAxisAlignment.start,
          //       //     children: [
          //       //       Container(
          //       //         padding: EdgeInsets.only(top: 0, left: 12, right: 8),
          //       //         height: 50,
          //       //         decoration: BoxDecoration(
          //       //             color: colors.whiteTemp,
          //       //             borderRadius: BorderRadius.circular(10),
          //       //             border: Border.all(color: colors.primary)
          //       //         ),
          //       //         width: MediaQuery.of(context).size.width/2-30,
          //       //         child: TextFormField(
          //       //           onTap: () {
          //       //             _selectEndDate();
          //       //           },
          //       //           style: TextStyle(color: Colors.black),
          //       //           keyboardType: TextInputType.number,
          //       //           maxLength: 10,
          //       //           controller: endDateCtr,
          //       //           decoration: InputDecoration(
          //       //             // suffix: Text("₹"),
          //       //               contentPadding: EdgeInsets.symmetric(vertical: 0),
          //       //               counterText: '',
          //       //               border: InputBorder.none,
          //       //               hintText: "End Date"
          //       //           ),
          //       //         ),
          //       //       ),
          //       //     ],
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Container(
          //       padding: EdgeInsets.only(top: 0, left: 12, right: 8),
          //       height: 50,
          //       decoration: BoxDecoration(
          //           color: colors.whiteTemp,
          //           borderRadius: BorderRadius.circular(10),
          //           border: Border.all(color: colors.primary)
          //       ),
          //       width: MediaQuery.of(context).size.width/1.1,
          //       child: TextFormField(
          //         style: const TextStyle(color: Colors.black),
          //         // controller: oldPriceController,
          //         keyboardType: TextInputType.number,
          //         maxLength: 10,
          //         decoration: const InputDecoration(
          //             suffixIcon: Icon(Icons.calendar_month),
          //             contentPadding: EdgeInsets.only(top: 16),
          //             counterText: '',
          //             border: InputBorder.none,
          //             hintText: "Check Availability"
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(height: 16,),
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
                        onChanged:(value) => {
                          totalAmtCtr.text = "${(int.parse(banner_Charge??""))* (int.parse(value))} RS",
                          print("===============${totalAmtCtr.text}==========="),
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
                            hintText: "Enter Day"
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
                height: 50,
                decoration: BoxDecoration(
                    color: colors.whiteTemp,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colors.primary)
                ),
                width: MediaQuery.of(context).size.width/1.1,
                child: TextFormField(
                  readOnly: true,
                  style: const TextStyle(color: Colors.black),
                  controller: totalAmtCtr,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: const InputDecoration(
                      // suffixIcon: Padding(
                      //   padding: EdgeInsets.only(top: 16),
                      //   child: Text("0 Rs"),
                      // ),
                      contentPadding: EdgeInsets.only(top: 6),
                      counterText: '',
                      border: InputBorder.none,
                      hintText: "Total Amount "
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 70,),
          Center(
            child: Card(
              child: InkWell(
                onTap: () {
                  if (_image == null || totalAmtCtr.text == "" || totalAmtCtr.text == null
                  ) {
                    Fluttertoast.showToast(msg: "Please Fill All Fields");
                  }
                  addOffers();
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
          ),
        ],
      ),
    );
  }
}
