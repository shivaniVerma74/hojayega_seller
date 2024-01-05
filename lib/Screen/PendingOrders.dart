import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/api.path.dart';
import '../Helper/color.dart';
import '../Model/GetVendorOrderModel.dart';
import 'HomeScreen.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({Key? key}) : super(key: key);

  @override
  State<PendingOrders> createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
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
   return getVendorOrder();
 }

  GetVendorOrderModel? vendorOrderModel;
  getVendorOrder() async {
    print("wokirngggg");
    var headers = {
      'Cookie': 'ci_session=6430902524c1703efd1eeb4c66d3537c73dbe375'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.vendorOrders));
    request.fields.addAll({'user_id': vendorId.toString(), 'status': "0"});
    print("parameterr ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = GetVendorOrderModel.fromJson(json.decode(finalResponse));
      print("get vendor order responsee $finalResult $finalResponse");
      setState(() {
        vendorOrderModel = finalResult;
        setState(() {});
      });
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
          SizedBox(height: 10,),
         ListView.builder(
           shrinkWrap: true,
           physics: NeverScrollableScrollPhysics(),
           itemCount: vendorOrderModel?.orders?.length??0,
           itemBuilder: (context, index) {

           return getPendingOrders(context,index);
         },)

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

 Widget  getPendingOrders(BuildContext context,int index) {
    return Column(
      children: [
        vendorOrderModel?.orders?.isNotEmpty ?? false ?
        Center(
          child: Table(
            border: TableBorder.all(borderRadius: BorderRadius.circular(5)),
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(63.0),
              1: FixedColumnWidth(115.0),
              2: FixedColumnWidth(80.0),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              // Header Row
              TableRow(
                children: [
                  headerCell('Order No.'),
                  headerCell('Time Slot'),
                  headerCell('Region'),
                  headerCell('Order Status'),
                ],
              ),
              // Data Rows
              ...?vendorOrderModel?.orders?.map((order) {
                return TableRow(
                  children: [
                    Container(
                      height: 50,
                      child:  Center(child: Text("${vendorOrderModel?.orders?[index].orderId.toString()}")),
                    ),
                    Container(
                        height: 50,
                        child: Center(child: Text("${vendorOrderModel?.orders?[index].time.toString()}")),),
                    Container(
                      height: 50,
                      child: Center(child: Text("${vendorOrderModel?.orders?[index].address.toString()}")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: Container(
                        height: 30,
                        width: 60,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color(0xffE5CB24)) ,
                        child: const Center(
                            child: Text("Completed", style: TextStyle(color: colors.whiteTemp,))),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ) : Container(
          height:
          MediaQuery.of(context).size.height/2.5,
          child: const Center(
            child: Text("Data Not Found"),
          ),
        ),
      ],
    );
  }

}
