import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/api.path.dart';
import '../Helper/color.dart';
import '../Model/PendingBooking.dart';
import 'HomeScreen.dart';

class PendingBooking extends StatefulWidget {
  const PendingBooking({Key? key}) : super(key: key);

  @override
  State<PendingBooking> createState() => _PendingBookingState();
}

class _PendingBookingState extends State<PendingBooking> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  String? vendorId;
  getData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    vendorId = preferences.getString('vendor_id');
    return getVendorBooking();
  }

  PendingBookingModel? pendingBookingModel;
  getVendorBooking() async {
    print("wokirngggg");
    var headers = {
      'Cookie': 'ci_session=6430902524c1703efd1eeb4c66d3537c73dbe375'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.pendingBooking));
    request.fields
        .addAll({'user_id': vendorId.toString(), 'status': "Pending"});
    print("parameterr ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult =
          PendingBookingModel.fromJson(json.decode(finalResponse));
      print("get vendor order responsee $finalResult $finalResponse");
      pendingBookingModel = finalResult;
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Text("Pending Orders", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: colors.primary),),
            const SizedBox(height: 10),
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: vendorOrderModel?.orders?.length??0,
            //   itemBuilder: (context, index) {
            //   return getPendingBooking(context,index);
            // },)
            getPendingBooking(context),
          ],
        ),
      ),
    );
  }

  Widget headerCell(String text) {
    return Container(
      height: 32,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  final List<Order> orders = [
    Order('10:00 to 12:00 pm', 'Indore', 'Pending'),
    Order('10:00 to 12:00 pm', 'Ujjain', 'Approved'),
  ];

  Widget getPendingBooking(
    BuildContext context,
  ) {
    return Column(
      children: [
        pendingBookingModel?.data?.isNotEmpty ?? false
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Table(
                    border:
                        TableBorder.all(borderRadius: BorderRadius.circular(5)),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(60.0),
                      1: FixedColumnWidth(110.0),
                      2: FixedColumnWidth(90.0),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      // Header Row
                      TableRow(
                        children: [
                          headerCell('Order No'),
                          headerCell('Time Slot'),
                          headerCell('Region'),
                          headerCell('Booking Status'),
                        ],
                      ),
                      // Data Rows
                      ...?pendingBookingModel?.data?.map((booking) {
                        return TableRow(
                          children: [
                            Container(
                              height: 50,
                              child: Center(
                                  child: Text(booking.bookingId.toString())),
                            ),
                            Container(
                              height: 50,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text(booking.slot
                                      .toString()
                                      .replaceAll(":00", "")),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              child: Center(
                                child: Text(
                                  booking.address.toString(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4, right: 4),
                              child: Container(
                                height: 30,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xffE5CB24)),
                                child: const Center(
                                    child: Text("Pending",
                                        style: TextStyle(
                                            color: colors.primary,
                                            fontWeight: FontWeight.bold))),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height / 2.5,
                child: const Center(
                  child: Text("Data Not Found"),
                ),
              ),
      ],
    );
  }
}
