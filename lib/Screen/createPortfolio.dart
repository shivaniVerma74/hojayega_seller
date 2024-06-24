import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hojayega_seller/Helper/api.path.dart';
import 'package:hojayega_seller/Helper/color.dart';
import 'package:hojayega_seller/Model/CategoryModel.dart';
import 'package:hojayega_seller/Model/GetVendorServicesModel.dart';
import 'package:hojayega_seller/Screen/Congratutation.dart';
import 'package:hojayega_seller/Screen/CreateOnlineStore.dart';
import 'package:hojayega_seller/Screen/addServicesScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServicesDetails extends StatefulWidget {
  String? ParentId;
  ServicesDetails({Key? key, this.ParentId}) : super(key: key);

  @override
  State<ServicesDetails> createState() => _ServicesDetailsState();
}

class _ServicesDetailsState extends State<ServicesDetails> {
  int? selectedItemIndex;

  CategoryModel? categoryModel;
  getCat() async {
    var headers = {
      'Cookie': 'ci_session=2af0bd20724524e1ebfba0e830885dbff718f536'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getCategories));
    request.fields.addAll({'roll': '2', 'parent_id': '${widget.ParentId}'});
    print("=========roll in get${request.fields}===========");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = CategoryModel.fromJson(json.decode(finalResponse));
      print("categoryyyy responsee $finalResult");
      print("categoryyyy responsee $finalResponse");
      setState(() {
        categoryModel = finalResult;
        // for(var i=0;i< (categoryModel?.data?.length ??0);i++){
        //   categoriesSelectedValues.add(false);
        // }
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  GetVendorServicesModel? getVendorServicesModel;
  getVendorServices(categoryId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? vendorId = prefs.getString("vendor_id");
    var headers = {
      'Cookie': 'ci_session=2af0bd20724524e1ebfba0e830885dbff718f536'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiServicves.getVendorServices));
    request.fields.addAll({
      'v_id': vendorId.toString(),
      'category_id': categoryId,
    });
    debugPrint(
        "=========fields of get vendor services======${request.fields}===========");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult =
          GetVendorServicesModel.fromJson(json.decode(finalResponse));
      debugPrint("vendor services responsee $finalResult");
      debugPrint("vendor Services responsee $finalResponse");
      setState(() {
        getVendorServicesModel = finalResult;
        // for(var i=0;i< (getVendorServicesModel?.data?.length ??0);i++){
        //   categoriesSelectedValues.add(false);
        // }
      });
    } else {
      debugPrint(response.reasonPhrase);
    }
  }

  List? selectedCategoryIndex;
  String? selectCatId;
  getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("selectedCategoryIndex");
    selectedCategoryIndex = value != null
        ? value
            .replaceAll('[', '')
            .replaceAll(']', '')
            .split(',')
            .map<int>((e) {
            return int.parse(e);
          }).toList()
        : null;
    await getCat();
    selectCatId = selectedCategoryIndex != null
        ? categoryModel!.data![selectedCategoryIndex!.first].id.toString()
        : "0";
    selectedItemIndex =
        selectedCategoryIndex != null ? selectedCategoryIndex!.first : 0;
    await getVendorServices(selectCatId);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("parent id is $parentId and ${widget.ParentId}");
    getAll();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          margin: EdgeInsets.all(8),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: colors.primary,
              )),
        ),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: Colors.white,
        title: const Text('Services'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            // Padding(
            //   padding: const EdgeInsets.only(left: 5),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: const [
            //       Text(
            //         'Beauty Parlour',
            //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 140,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categoryModel?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  if (selectedCategoryIndex!.contains(index)) {
                    CategoryData? catData = categoryModel?.data?[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedItemIndex = index;
                          getVendorServices(catData!.id);
                        });
                      },
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: catData?.img == null
                                      ? Image.asset(
                                          "assets/images/placeholder.png")
                                      : Image.network(
                                          "https://developmentalphawizz.com/hojayega/${catData?.img}",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                Text("${catData?.cName}")
                              ],
                            ),
                          ),
                          if (selectedItemIndex == index)
                            const Positioned(
                              top: 10,
                              left: 15,
                              child: CircleAvatar(
                                backgroundColor: colors.secondary,
                                radius: 10,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: size.height * 0.55,
                width: size.height * 0.44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0XFF112c48),
                  ),
                ),
                child: getVendorServicesModel == null
                    ? const SizedBox.shrink()
                    : MyListView(
                        getVendorServicesModel: getVendorServicesModel!,
                        categoryId: categoryModel!.data![selectedItemIndex!].id
                            .toString(),
                        callApi: (bool value) {
                          if (value) {
                            getVendorServices(categoryModel!
                                .data![selectedItemIndex!].id
                                .toString());
                          }
                        },
                      ),
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     const Padding(
                //       padding: EdgeInsets.only(left: 20, top: 10),
                //       child: Text(
                //         'Hair Service',
                //         style: TextStyle(
                //             fontSize: 20,
                //             color: Color(0XFF112c40),
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 5, right: 10),
                //       child: Row(
                //         children: const [
                //           Padding(
                //             padding: EdgeInsets.only(right: 3, left: 10),
                //             child: Icon(
                //               Icons.circle,
                //               size: 10,
                //             ),
                //           ),
                //           Text(
                //             'Haircut',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Spacer(),
                //           Text(
                //             '350/-',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(left: 5, right: 3),
                //             child: Icon(
                //               Icons.circle,
                //               size: 22,
                //               color: Colors.green,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 5, right: 10),
                //       child: Row(
                //         children: const [
                //           Padding(
                //             padding: EdgeInsets.only(right: 3, left: 10),
                //             child: Icon(
                //               Icons.circle,
                //               size: 10,
                //             ),
                //           ),
                //           Text(
                //             'Hair Wash',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Spacer(),
                //           Text(
                //             '100/-',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(left: 5, right: 3),
                //             child: Icon(
                //               Icons.circle,
                //               size: 22,
                //               color: Colors.green,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 5, right: 10),
                //       child: Row(
                //         children: const [
                //           Padding(
                //             padding: EdgeInsets.only(right: 3, left: 10),
                //             child: Icon(
                //               Icons.circle,
                //               size: 10,
                //             ),
                //           ),
                //           Text(
                //             'Hair Spa',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Spacer(),
                //           Text(
                //             '500/-',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(left: 5, right: 3),
                //             child: Icon(
                //               Icons.circle,
                //               size: 22,
                //               color: Colors.green,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 5, right: 10),
                //       child: Row(
                //         children: const [
                //           Padding(
                //             padding: EdgeInsets.only(right: 3, left: 10),
                //             child: Icon(
                //               Icons.circle,
                //               size: 10,
                //             ),
                //           ),
                //           Text(
                //             'Hair Color Touch Up',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Spacer(),
                //           Text(
                //             '300/-',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(left: 5, right: 3),
                //             child: Icon(
                //               Icons.circle,
                //               size: 22,
                //               color: Colors.green,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     const Padding(
                //       padding: EdgeInsets.only(left: 20, top: 10),
                //       child: Text(
                //         'Grooming',
                //         style: TextStyle(
                //             fontSize: 20,
                //             color: Color(0XFF112c40),
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 5, right: 10),
                //       child: Row(
                //         children: const [
                //           Padding(
                //             padding: EdgeInsets.only(left: 10, right: 3),
                //             child: Icon(
                //               Icons.circle,
                //               size: 10,
                //             ),
                //           ),
                //           Text(
                //             'Shaving',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Spacer(),
                //           Text(
                //             '350/-',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(left: 5, right: 3),
                //             child: Icon(
                //               Icons.circle,
                //               size: 22,
                //               color: Colors.green,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 5, right: 10),
                //       child: Row(
                //         children: const [
                //           Padding(
                //             padding: EdgeInsets.only(right: 3, left: 10),
                //             child: Icon(
                //               Icons.circle,
                //               size: 10,
                //             ),
                //           ),
                //           Text(
                //             'Nail Spa',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Spacer(),
                //           Text(
                //             '100/-',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(left: 5, right: 3),
                //             child: Icon(
                //               Icons.circle,
                //               size: 22,
                //               color: Colors.green,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 5, right: 10),
                //       child: Row(
                //         children: const [
                //           Padding(
                //             padding: EdgeInsets.only(right: 3, left: 10),
                //             child: Icon(
                //               Icons.circle,
                //               size: 10,
                //             ),
                //           ),
                //           Text(
                //             'Groomin Feet',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Spacer(),
                //           Text(
                //             '500/-',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(left: 5, right: 3),
                //             child: Icon(
                //               Icons.circle,
                //               size: 22,
                //               color: Colors.green,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 5, right: 10),
                //       child: Row(
                //         children: const [
                //           Padding(
                //             padding: EdgeInsets.only(right: 3, left: 10),
                //             child: Icon(
                //               Icons.circle,
                //               size: 10,
                //             ),
                //           ),
                //           Text(
                //             'Grooming Hand',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Spacer(),
                //           Text(
                //             '300/-',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(left: 5, right: 3),
                //             child: Icon(
                //               Icons.circle,
                //               size: 22,
                //               color: Colors.green,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     const Padding(
                //       padding: EdgeInsets.only(left: 20, top: 10),
                //       child: Text(
                //         'Combo Offer',
                //         style: TextStyle(
                //             fontSize: 20,
                //             color: Color(0XFF112c40),
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 25, right: 30),
                //       child: Row(
                //         children: const [
                //           Text(
                //             'Shaving + hair color +\n hair wash',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Spacer(),
                //           Text(
                //             '500/-',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(right: 10),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           CircleAvatar(
                //             child: Center(child: Icon(Icons.add,color: colors.whiteTemp,)),
                //             backgroundColor: colors.secondary,
                //             maxRadius: 13,
                //           ),
                //           SizedBox(width: 5,),
                //           CircleAvatar(
                //             child: Icon(Icons.delete,color: colors.whiteTemp,),
                //             backgroundColor: colors.darkRed,
                //             maxRadius: 13,
                //           ),
                //           SizedBox(width: 5,),
                //           CircleAvatar(
                //             child: Icon(Icons.remove_red_eye,color: colors.whiteTemp,),
                //             backgroundColor: colors.primary,
                //             maxRadius: 13,
                //           ),
                //         ],
                //       ),
                //     ),
                //     const SizedBox(
                //       height: 10,
                //     ),
                //     Center(
                //       child: Container(
                //         height: 30,
                //         width: 280,
                //         decoration: BoxDecoration(
                //             border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(10)),
                //         child: Center(
                //           child: const Text(
                //             'Note:rate might change as per work',
                //             style: TextStyle(
                //                 fontSize: 15, fontWeight: FontWeight.bold),
                //           ),
                //         ),
                //       ),
                //     ),
                //     const SizedBox(
                //       height: 20,
                //     ),
                //     InkWell(
                //       onTap: () {
                //         //  Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentBooking()));
                //       },
                //       child: Center(
                //         child: Container(
                //           height: 40,
                //           width: 270,
                //           decoration: BoxDecoration(
                //
                //               borderRadius: BorderRadius.circular(10),
                //               color: Colors.green),
                //           child: const Center(
                //               child: Text(
                //                 'Done',
                //                 style: TextStyle(
                //                     fontSize: 20,
                //                     fontWeight: FontWeight.w500,
                //                     color: Colors.white),
                //               )),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Congratulation()));
              },
              child: Center(
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.secondary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    //   width: MediaQuery.of(context),
                    // decoration: BoxDecoration(borderRadius: ),
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * .5,
                    child: const Center(
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedItemIndex != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddServicesScreen(
                          categoryId: categoryModel!
                              .data![selectedItemIndex!].id
                              .toString(),
                          isUpdate: false,
                        ))).then((value) {
              getCat();
              getVendorServices(categoryModel?.data?[selectedItemIndex!].id);
            });
          } else {
            Fluttertoast.showToast(msg: "Please Select Category");
          }
        },
        backgroundColor: colors.primary,
        tooltip: "Add Services",
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyListView extends StatefulWidget {
  final GetVendorServicesModel getVendorServicesModel;
  final String categoryId;
  final Function(bool value) callApi;

  const MyListView(
      {super.key,
      required this.getVendorServicesModel,
      required this.categoryId,
      required this.callApi});
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  List<bool> checkboxValues = List.generate(5, (index) => false);
  bool activeServiceStatus = true;
  List<String> selectedServiceIds = [];
  deleteService(serviceId) async {
    var headers = {
      'Cookie': 'ci_session=2af0bd20724524e1ebfba0e830885dbff718f536'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.deleteService));
    request.fields.addAll({'id': serviceId.toString()});
    print("=========id of service======${request.fields}===========");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = json.decode(finalResponse);
      print("deleteee resulttttt $finalResult");
      print("deleteee responsee $finalResponse");
      print("deleteee status ${finalResult["status"]}");
      Fluttertoast.showToast(msg: finalResult["message"].toString());
    } else {
      print(response.reasonPhrase);
    }
  }

  updateServiceStatus(serviceId, bool status) async {
    var headers = {
      'Cookie': 'ci_session=2af0bd20724524e1ebfba0e830885dbff718f536'
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiServicves.updateServiceStatus));
    request.fields.addAll({
      'service_id': serviceId.toString(),
      'status': status ? "1" : "0",
    });
    print(
        "=========fields of update service status======${request.fields}===========");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = json.decode(finalResponse);
      debugPrint("update service status resulttttt $finalResult");
      debugPrint("update service status responsee $finalResponse");
      debugPrint("update service status ${finalResult["status"]}");
      Fluttertoast.showToast(msg: finalResult["message"].toString());
    } else {
      debugPrint(response.reasonPhrase);
    }
  }

  showConfirmDialog(serviceId) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text("Are You Sure to delete this service?"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: colors.red),
                    child: const Text("No")),
                ElevatedButton(
                    onPressed: () {
                      deleteService(serviceId).then((val) {
                        widget.callApi(true);
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary),
                    child: const Text("yes")),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var data in widget.getVendorServicesModel.data) {
      for (var i = 0; i < data.services.length; i++) {
        selectedServiceIds.add(data.services[i].id.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 2, 10),
      child: widget.getVendorServicesModel.msg == "Services Not Found"
          ? const Center(
              child: Text(
                "No Services. Please add Services",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: widget.getVendorServicesModel.data.length,
              itemBuilder: (context, index) {
                ServiceData data = widget.getVendorServicesModel.data[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data.name}",
                      style: const TextStyle(
                          color: colors.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Column(
                      children: data.services.map((service) {
                        // selectedServiceIds.add(service.id.toString());
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colors.primary),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 50,
                                      child: Text(
                                        "${service.serviceName}",
                                        style: const TextStyle(
                                          color: colors.primary,
                                          fontSize: 15,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 60,
                                    ),
                                    Text(
                                      "${service.mrpPrice}/-",
                                      style: const TextStyle(
                                        color: colors.primary,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "${service.specialPrice}/-",
                                      style: const TextStyle(
                                        color: colors.primary,
                                        fontSize: 15,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddServicesScreen(
                                                  categoryId: widget.categoryId,
                                                  isUpdate: true,
                                                  name: data.name.toString(),
                                                  service: service,
                                                ))).then((val) {
                                      widget.callApi(true);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: colors.primary,
                                    size: 20,
                                  )),
                              const SizedBox(
                                width: 12,
                              ),
                              InkWell(
                                  onTap: () {
                                    // deleteService(service.id).then(
                                    //     (val){
                                    //
                                    //     }
                                    // );
                                    showConfirmDialog(service.id);
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: colors.red,
                                    size: 20,
                                  )),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                constraints: const BoxConstraints(maxWidth: 40),
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: Switch(
                                    value:
                                        selectedServiceIds.contains(service.id),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onChanged: (val) {
                                      setState(() {
                                        if (!val) {
                                          selectedServiceIds
                                              .remove(service.id.toString());
                                        } else {
                                          selectedServiceIds
                                              .add(service.id.toString());
                                        }
                                        print(selectedServiceIds.length
                                            .toString());
                                        setState(() {
                                          debugPrint(val.toString());
                                        });
                                        updateServiceStatus(service.id, val);
                                      });
                                    },
                                    activeColor: colors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                );
              },
            ),
    );
  }
}
