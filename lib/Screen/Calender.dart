 import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hojayega_seller/Helper/api.path.dart';
import 'package:hojayega_seller/Model/getVendorBookingsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/color.dart';
import 'package:http/http.dart'as http;

import 'BottomBar.dart';

class Calender extends StatefulWidget {
  final bool isFromBottom;

  const Calender({super.key, required this.isFromBottom});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  String? roll;
  GetVendorBookingModel? getVendorBookingModel;
  getVendorBookings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? vendorId = prefs.getString("vendor_id");
    roll=  prefs.getString('roll');
    var headers = {
      'Cookie': 'ci_session=2af0bd20724524e1ebfba0e830885dbff718f536'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiServicves.getVendorBookings));
    request.fields.addAll({'user_id':vendorId.toString(),});
    debugPrint("=========fields of get bookings======${request.fields}===========");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = GetVendorBookingModel.fromJson(json.decode(finalResponse));
      debugPrint("get bookings responsee $finalResult");
      debugPrint("get bookings responsee $finalResponse");
      setState(() {
        getVendorBookingModel = finalResult;
      });
    } else {
      debugPrint(response.reasonPhrase);
    }
  }

    bool isLoading= true;
  load(){
    Future.delayed(Duration(seconds: 1),() {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
    getVendorBookings();
  }

  completeBooking(String? bookingID) async {
    var headers = {
      'Cookie': 'ci_session=665c4cfcb0fe58936a31c314dbaaf606bda67175'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.completeBookings));
    request.fields.addAll({
      'id': bookingID.toString(),
    });
    print("booking complete ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Fluttertoast.showToast(msg: "Booking Complete");
      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: roll== "2" && widget.isFromBottom?AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        elevation: 0,
      ):AppBar(
        leading: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          margin: const EdgeInsets.all(8), // Adjust padding inside container
          child: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: Colors.white, //(0xff112C48),
        iconTheme: const IconThemeData(color: colors.secondary),
        title: const Text("Calendar"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.0)),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 15),
        //     child: Container(
        //       height: 40,
        //       width: 40,
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(5), color: Colors.white),
        //       child: IconButton(
        //         icon: const Icon(Icons.notifications),
        //         onPressed: () {
        //           // Add your notification icon tap logic here
        //         },
        //     ),  ),
        //
        //   ),
        // ],
      ),
      body:
      isLoading? const Center(child: CircularProgressIndicator(),):getVendorBookingModel?.msg == "No Booking found"?const Center(child: Text("No Booking found"),):ListView.builder(
        itemCount:getVendorBookingModel?.data.length ?? 0,
          itemBuilder: (_,index){
          GetBookingData? data = getVendorBookingModel?.data[index];
            return Padding(
              padding: const EdgeInsets.only(
                top: 5,
                left: 5,
                right: 5,
              ),
              child:
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: colors.darkColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                Text(
                                  "Date: ${data?.date}".replaceAll("00:00:00.000", ''),
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Time: ${data?.slot}",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Name: ${data?.username}",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Ph no: ${data?.mobile}",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                // Text("Hair cut",),
                                // Text("Hair colour touch up",),
                                // Text("Hair Wash",),
                                // SizedBox(
                                //     width: 150,
                                //     child: Text("Note : I want to get it dont before 6:00. have to go to part.",style: TextStyle(fontSize: 10,color: colors.grad1Color),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                              ],
                            ),
                            //               SizedBox(
                            // width: 80,
                            //               ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                data?.status == "Pending" ?
                                const Text('Pending',
                                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)): SizedBox(),
                                data?.status == "Complete" ?
                                const Text('Complete',
                                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)): SizedBox(),
                                const SizedBox(height: 5,),
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: colors.primary)),
                                  child:
                                  // data?.shopImage == null?
                                  // Image.asset(
                                  //     'assets/images/placeholder.png'):
                                  Image.network("${data!.shopImage}", fit: BoxFit.fill,)
                                )
                              ],
                            ),
                            // Text("Note : I want to get it dont before 6:00. have to go to part.",style: TextStyle(fontSize: 10,color: colors.grad1Color),),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      Column(
                        children: data.serviceDetails.map((service){
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                Text(
                                  "${service.serviceName}",
                                ),
                                const SizedBox(height: 3,),
                                Text(
                                  "${service.price}/-",
                                ),
                              ],
                            ),
                          );
                        }).toList()
                      ),
                       Padding(
                        padding: const EdgeInsets.only(left: 5,bottom: 10),
                        child: Text(
                          "Note: ${data.note}",
                          style: const TextStyle(
                              fontSize: 12, color: colors.grad1Color),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2, right: 2),
                        child: Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                completeBooking(data.bookingId.toString());
                              },
                              child: Container(
                                height: 30,
                                  width: 140,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                                  child: const Center(child: Text("Complete Booking", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),))),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          })
    );
  }
}
