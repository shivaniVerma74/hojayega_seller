import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Color.dart';
import '../Helper/api.path.dart';
import 'BottomBar.dart';

class Add15Sec extends StatefulWidget {
  const Add15Sec({Key? key}) : super(key: key);

  @override
  State<Add15Sec> createState() => _Add15SecState();
}

class _Add15SecState extends State<Add15Sec> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSetting();
  }

  String? banner_Charge;
  int? amount;

  getSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=bfa970b6e13a45a52775a4cd4995efa6026d6895'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getSettings));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finaResult = jsonDecode(result);
      print("responseee $finaResult");
      if (finaResult['status'] == 1) {
        banner_Charge = finaResult['setting']['banner_per_day_charge'];
        await prefs.setString(
            'banner_Charge', finaResult['setting']['ad_amount_15'].toString());
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

  TextEditingController totalAmtCtr = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var imageCode;
  File? _image;
  final picker = ImagePicker();

  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null && imageCode == 1) {
        _image = File(pickedFile.path);
        Navigator.pop(context);
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
        Navigator.pop(context);
      } else {
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

  TextEditingController totalamtCtr = TextEditingController();
  String? vendorId, roll;
  addOffers() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    vendorId = preferences.getString('vendor_id');
    roll = preferences.getString('roll');
    print("vendor id add product screen $vendorId");
    var headers = {
      'Cookie': 'ci_session=60bef4788330603caab520de3a388682e1b2fdea'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.offers));
    request.fields.addAll({
      'user_id': vendorId.toString(),
      'type': roll == "1" ? "shop" : "service",
      'total_amount': totalamtCtr.text,
      'transaction_id': 'wallet'
    });
    print("======15sec=========${request.fields}===========");
    request.files.add(
        await http.MultipartFile.fromPath('image', _image!.path.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomNavBar()));
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  TextEditingController dayCtr = TextEditingController();

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
          title: const Text('15Sec Adds'),
          backgroundColor: colors.primary),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  imageCode = 1;
                  _showPickerOptions();
                },
                child: Card(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: _image != null
                        ? Image.file(
                            _image!.absolute,
                            fit: BoxFit.fill,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Column(
                              children: const [
                                Text(
                                  "Upload Image",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
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
              SizedBox(
                height: 16,
              ),
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
                              border: Border.all(color: colors.primary)),
                          width: MediaQuery.of(context).size.width / 2 - 30,
                          child: TextFormField(
                            readOnly: true,
                            style: const TextStyle(color: Colors.black),
                            // controller: oldPriceController,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            decoration: InputDecoration(
                                // suffixIcon: Icon(Icons.calendar_month),
                                // contentPadding: EdgeInsets.only(top: 16),
                                counterText: '',
                                border: InputBorder.none,
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400),
                                hintText: "Charges: $banner_Charge RS."),
                          ),
                        ),
                        Container(
                          padding:
                              const EdgeInsets.only(top: 0, left: 12, right: 8),
                          height: 60,
                          decoration: BoxDecoration(
                              color: colors.whiteTemp,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: colors.primary)),
                          width: MediaQuery.of(context).size.width / 2 - 30,
                          child: TextFormField(
                            onChanged: (value) => {
                              totalAmtCtr.text =
                                  "${(int.parse(banner_Charge ?? "")) * (int.parse(value))} RS",
                              print(
                                  "===============${totalAmtCtr.text}==========="),
                            },
                            style: const TextStyle(color: Colors.black),
                            controller: dayCtr,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            decoration: const InputDecoration(
                                // suffixIcon: Icon(Icons.calendar_month),
                                // contentPadding: EdgeInsets.only(top: 16),
                                counterText: '',
                                border: InputBorder.none,
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.w400),
                                hintText: "Enter Day"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 0, left: 12, right: 8),
                    height: 50,
                    decoration: BoxDecoration(
                        color: colors.whiteTemp,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colors.primary)),
                    width: MediaQuery.of(context).size.width / 1.1,
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
                          hintText: "Total Amount "),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              Center(
                child: Card(
                  child: InkWell(
                    onTap: () {
                      if (_image == null ||
                          totalAmtCtr.text == "" ||
                          totalAmtCtr.text == null) {
                        Fluttertoast.showToast(msg: "Please Fill All Fields");
                      }
                      addOffers();
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          'Pay',
                          style: TextStyle(color: Colors.white, fontSize: 19),
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
        ),
      ),
    );
  }
}
