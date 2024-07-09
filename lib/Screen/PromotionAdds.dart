import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hojayega_seller/Helper/api.path.dart';
import 'package:hojayega_seller/Screen/BottomBar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/color.dart';
import '../Model/BannerHistory.dart';
import '../Model/PromotionAdsList.dart';
import '../Model/Sec15ModelList.dart';
import '15SecAdds.dart';
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
    getPromotionList();
  }

  PromotionAdsList? promotionAdsList;
  getPromotionList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    vendorId = prefs.getString("vendor_id");
    var headers = {
      'Cookie': 'ci_session=3e77e7aa026a5d8de1e1559474dae89c2d280f6c'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.promotionList));
    request.fields.addAll({'vendor_id': vendorId.toString()});
    print("vendor id inn prmotion add ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("aksdjakldjaksjd");
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse =
          PromotionAdsList.fromJson(json.decode(finalResponse));
      print("response $jsonResponse");
      setState(() {
        promotionAdsList = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Sec15ModelList? sec15List;
  get15SecList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    vendorId = prefs.getString("vendor_id");
    var headers = {
      'Cookie': 'ci_session=3e77e7aa026a5d8de1e1559474dae89c2d280f6c'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.sec15ListApi));
    request.fields.addAll({'vendor_id': vendorId.toString()});
    print("vendor id inn prmotion add ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("aksdjakldjaksjd");
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = Sec15ModelList.fromJson(json.decode(finalResponse));
      print("response $jsonResponse");
      setState(() {
        sec15List = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  BannerHistory? historyList;
  getHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    vendorId = prefs.getString("vendor_id");
    var headers = {
      'Cookie': 'ci_session=3e77e7aa026a5d8de1e1559474dae89c2d280f6c'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getHistory));
    request.fields.addAll({'vendor_id': '${vendorId.toString()}'});
    print("vendor id inn history add ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("");
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = BannerHistory.fromJson(json.decode(finalResponse));
      print("response $jsonResponse");
      setState(() {
        historyList = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      floatingActionButton: selected == 2
          ? SizedBox()
          : InkWell(
              onTap: () {
                selected == 0
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddPromotionAdds()))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Add15Sec()));
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      color: colors.primary),
                  child: const Icon(Icons.add, color: Colors.white, size: 37),
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
                            get15SecList();
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
                            getHistory();
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
                                  color: selected == 2
                                      ? Colors.white
                                      : colors.primary),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            selected == 0
                ? getFirstTap()
                : selected == 1
                    ? getsecondTapFields()
                    : getHitsoryFields(),
          ],
        ),
      ),
    );
  }

  getFirstTap() {
    return promotionAdsList!.data!.isEmpty
        ? const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                "Banners Not Found",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
              ),
            ),
          )
        : ListView.builder(
            itemCount: promotionAdsList?.data?.length ?? 0,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (c, i) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${promotionAdsList?.data?[i].startDate}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colors.primary,
                              fontSize: 18),
                        ),
                        Text(
                            "${promotionAdsList?.data?[i].totalDay}Day = ${promotionAdsList?.data?[i].amount}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colors.primary,
                                fontSize: 18))
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  promotionAdsList?.data?[i].status == "0"
                      ? Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: colors.primary),
                            child: const Center(
                                child: Text(
                              "Pending",
                              style: TextStyle(color: colors.whiteTemp),
                            )),
                          ),
                        )
                      : const SizedBox(),
                  promotionAdsList?.data?[i].status == "1"
                      ? Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: colors.primary),
                            child: const Center(
                                child: Text(
                              "Active",
                              style: TextStyle(color: colors.whiteTemp),
                            )),
                          ),
                        )
                      : SizedBox(),
                  promotionAdsList?.data?[i].status == "2"
                      ? Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: colors.primary),
                            child: const Center(
                                child: Text(
                              "Reject",
                              style: TextStyle(color: colors.whiteTemp),
                            )),
                          ),
                        )
                      : SizedBox(),
                  const SizedBox(height: 5),
                  Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        "https://developmentalphawizz.com/hojayega/${promotionAdsList?.data?[i].image}",
                        fit: BoxFit.cover,
                      )),
                ],
              );
            });
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
        await prefs.setString('banner_Charge',
            finaResult['setting']['banner_per_day_charge'].toString());
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

  checkAvailability() async {
    var headers = {
      'Cookie': 'ci_session=a7ed57b5c2abb7aa515a4dd255b0524db51e286b'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.checkAvailablity));
    request.fields
        .addAll({'start_date': startDateCtr.text, 'end_date': endDateCtr.text});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finaResult = jsonDecode(result);
      Fluttertoast.showToast(msg: '${finaResult['message']}');
    } else {
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
        dateFormate =
            DateFormat("dd/MM/yyyy").format(DateTime.parse(_dateValue ?? ""));
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
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        dateFormate =
            DateFormat("dd/MM/yyyy").format(DateTime.parse(_dateValue ?? ""));
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
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null && imageCode == 1) {
        _image = File(pickedFile.path);
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
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                getImageGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
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
    return sec15List!.data!.length == null || sec15List!.data!.length == ""
        ? const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Center(
                child: Text(
              "Banners Not Found",
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
            )),
          )
        : sec15List?.data?.length == null || sec15List?.data?.length == ""
            ? const CircularProgressIndicator(
                color: colors.primary,
              )
            : ListView.builder(
                itemCount: sec15List?.data?.length ?? 0,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (c, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Row(
                      //     mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text("${sec15List?.data?[i].startDate}", style: TextStyle(fontWeight: FontWeight.bold, color: colors.primary, fontSize: 18),),
                      //       Text("${sec15List?.data?[i].totalDay}Day = ${sec15List?.data?[i].totalAmount}",style: TextStyle(fontWeight: FontWeight.bold, color: colors.primary, fontSize: 18))
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(height: 5,),
                      sec15List?.data?[i].status == "0"
                          ? Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Container(
                                width: 70,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colors.primary),
                                child: const Center(
                                    child: Text(
                                  "Pending",
                                  style: TextStyle(color: colors.whiteTemp),
                                )),
                              ),
                            )
                          : const SizedBox(),
                      sec15List?.data?[i].status == "1"
                          ? Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Container(
                                width: 70,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colors.primary),
                                child: const Center(
                                  child: Text(
                                    "Active",
                                    style: TextStyle(color: colors.whiteTemp),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                      sec15List?.data?[i].status == "2"
                          ? Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Container(
                                width: 70,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colors.primary),
                                child: const Center(
                                    child: Text(
                                  "Reject",
                                  style: TextStyle(color: colors.whiteTemp),
                                )),
                              ),
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(height: 5),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          "https://developmentalphawizz.com/hojayega/${sec15List?.data?[i].image}",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  );
                });
  }

  getHitsoryFields() {
    return historyList?.data?.length == null || historyList!.data!.length == ""
        ? const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Center(
                child: Text(
              "Banners Not Found",
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
            )),
          )
        : historyList?.data?.length == null || historyList?.data?.length == ""
            ? const CircularProgressIndicator(
                color: colors.primary,
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: historyList?.data?.length ?? 0,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (c, i) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          historyList?.data?[i].status == "0"
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Container(
                                    width: 70,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.primary),
                                    child: const Center(
                                        child: Text(
                                      "Pending",
                                      style: TextStyle(color: colors.whiteTemp),
                                    )),
                                  ),
                                )
                              : const SizedBox(),
                          historyList?.data?[i].status == "1"
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Container(
                                    width: 70,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.primary),
                                    child: const Center(
                                        child: Text(
                                      "Active",
                                      style: TextStyle(color: colors.whiteTemp),
                                    )),
                                  ),
                                )
                              : SizedBox(),
                          historyList?.data?[i].status == "2"
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Container(
                                    width: 70,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.primary),
                                    child: const Center(
                                        child: Text(
                                      "Reject",
                                      style: TextStyle(color: colors.whiteTemp),
                                    )),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(height: 5),
                          Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                "https://developmentalphawizz.com/hojayega/${historyList?.data?[i].image}",
                                fit: BoxFit.fill,
                              )),
                        ],
                      );
                    }),
              );
  }
}
