import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hojayega_seller/Helper/api.path.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/color.dart';
import '../Model/GetVendorOrderModel.dart';
import 'HomeScreen.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  initState() {
    super.initState();
    getData();
    getVendorOrder();
  }


  String? vendor_id;

  getData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? vendor_id = sharedPreferences.getString('vendor_id');
    print("vendor id order screen $vendor_id");
  }


  GetVendorOrderModel? vendorOrderModel;
  getVendorOrder() async {
    print("wokirngggg");
    var headers = {
      'Cookie': 'ci_session=6430902524c1703efd1eeb4c66d3537c73dbe375'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.vendorOrders));
    request.fields.addAll({'user_id': '137', 'status': selected == 1 ? "3" : ""});
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


  acceptRejectOrders(String? order_Id) async {
    var headers = {
      'Cookie': 'ci_session=c41e07862b19be167a9977bcab013b29c17d4dce'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.acceptRejectOrder));
    request.fields.addAll({
      'order_id': order_Id.toString(),
      'user_id': vendor_id.toString(),
      'status': '1'
    });
   print("order acceot reheet is ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Navigator.pop(context);
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }


  rejectOrders(context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: const Text("Confirm Sign Out"),
            content: const Text("Are you sure to reject?"),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: colors.primary),
                child: Text("YES"),
                onPressed: () async {

                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: colors.primary),
                child: const Text("NO"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }


  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          getVendorOrder();
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
                              'Current Orders',
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
                          getVendorOrder();
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
                              'Completed Orders',
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
                  ],
                ),
              ),
            ),
            selected == 0 ? getCurrentOrders() : getCompleteOrders("")
          ],
        ),
      ),
    );
  }

  getCurrentOrders() {
    return Column(
      children: [
        vendorOrderModel?.orders?.isNotEmpty ?? false ?
        vendorOrderModel?.orders?.length == "" || vendorOrderModel?.orders?.length == null ? const Center(child: CircularProgressIndicator(color: colors.primary,)):
        ListView.builder(
          shrinkWrap: true,
          itemCount: vendorOrderModel?.orders?.length ?? 0,
            itemBuilder: (c,i) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 5,
              left: 5,
              right: 5,
            ),
            child: Card(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: colors.darkColor),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5,), color: colors.primary),
                            child: Image.asset("assets/images/nmae.png"),
                          ),
                           Text(
                            "${vendorOrderModel?.orders?[i].username}",
                            style: const TextStyle(color: colors.primary),
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: colors.primary),
                            child: Image.asset("assets/images/calenders.png"),
                          ),
                          const Text(
                            "Date",
                            style: TextStyle(color: colors.primary),
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5,),
                                color: colors.primary),
                            child: Image.asset("assets/images/time.png"),
                          ),
                          const Text(
                            "Time",
                            style: TextStyle(color: colors.primary),
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: colors.primary),
                            child: Image.asset("assets/images/noofitem.png"),
                          ),
                          const Text(
                            "No. of item",
                            style: TextStyle(color: colors.primary),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children:  [
                          const Icon(
                            Icons.circle,
                            color: colors.secondary,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(
                            "----",
                            style: TextStyle(fontSize: 16),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          Text(
                            "${vendorOrderModel?.orders?[i].address}",
                            style: TextStyle(fontSize: 15, color: colors.primary),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 9, right: 2),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text("Name", style: TextStyle(color: colors.primary),),
                              SizedBox(
                                width: 120,
                              ),
                              Text("Qty", style: TextStyle(color: colors.primary),),
                              SizedBox(
                                width: 40,
                              ),
                              Text("Rs",style: TextStyle(color: colors.primary),),
                              SizedBox(
                                width: 40,
                              ),
                              Text("Total", style: TextStyle(color: colors.primary),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: vendorOrderModel?.orders?[i].orderItems?.length ?? 0,
                        itemBuilder: (c,i) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, right: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Row(
                              children: [
                                Card(
                                  elevation:4,
                                  child: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5,),
                                          color: Colors.white),
                                      child: Image.network("${vendorOrderModel?.orders?[i].orderItems?[i].productImage}", color: Colors.red,)),
                                ),
                                const SizedBox(width: 5,),
                                vendorOrderModel?.orders?[i].orderItems?[i].productName == "" || vendorOrderModel?.orders?[i].orderItems?[i].productName == null ?
                                Text("Foods", style: TextStyle(color: colors.primary),):
                                 Container(
                                   width: 49,
                                     child: Text("${vendorOrderModel?.orders?[i].orderItems?[i].productName}", style: TextStyle(color: colors.primary, overflow: TextOverflow.ellipsis),)),
                                const SizedBox(
                                  width: 75,
                                ),
                                vendorOrderModel?.orders?[i].orderItems?[i].unit == "" || vendorOrderModel?.orders?[i].orderItems?[i].unit == null ?
                                Text("1Kg", style: TextStyle(color: colors.primary),) :
                                 Text("${vendorOrderModel?.orders?[i].orderItems?[i].unit}", style: TextStyle(color: colors.primary),),
                                const SizedBox(
                                  width: 40,
                                ),
                                 Text("${vendorOrderModel?.orders?[i].orderItems?[i].productPrice}",style: TextStyle(color: colors.primary),),
                                const SizedBox(
                                  width: 40,
                                ),
                                Text("${vendorOrderModel?.orders?[i].orderItems?[i].sellingPrice}rs", style: TextStyle(color: colors.primary),)
                              ],
                            )
                          ],
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                             rejectOrders(context);
                            },
                            child: Container(
                              height: 35,
                              width: 80,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.red),
                              child: const Center(child: Text("Reject", style: TextStyle(fontSize: 15, color: colors.whiteTemp),)),
                            ),
                          ),
                          SizedBox(width: 6,),
                          InkWell(
                            onTap: () {
                              acceptRejectOrders(vendorOrderModel?.orders?[i].orderId);
                            },
                            child: Container(
                              height: 35,
                              width: 80,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.secondary),
                              child: const Center(child: Text("Accept", style: TextStyle(fontSize: 15, color: colors.whiteTemp),)),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          );
        }): Container(
            height:
            MediaQuery.of(context).size.height/2.5,
            child: const Center(
                child: Text("Data Not Found"),
            ),
        ),
      ],
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

  Widget dataCell(String text) {
    return Container(
      height: 50,
      child: Center(child: Text(text)),
    );
  }

  final List<Order> orders = [
    Order('10:00 to 12:00 pm', 'Indore', 'Pending'),
    Order('10:00 to 12:00 pm', 'Ujjain', 'Approved'),
    // Order('10:00 to 12:00 pm', 'Bhopal', 'Approved'),
    // Add more orders as needed
  ];

  Widget statusCell(String status) {
    Color textColor = Colors.black;
    if (status == 'Pending') {
      textColor = Colors.red; // Replace with your color for pending status
    } else if (status == 'Approved') {
      textColor = Colors.green; // Replace with your color for approved status
    }
    return Container(
      height: 50,
      // width: 0,
      child: Center(
        child: Text(
          status,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  getCompleteOrders(index) {
    return Column(
      children: [
        vendorOrderModel?.orders?.isNotEmpty ?? false ?
        Center(
          child: Table(
            border: TableBorder.all(borderRadius: BorderRadius.circular(5)),
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(115.0),
              1: FixedColumnWidth(65.0),
              2: FixedColumnWidth(80.0),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              // Header Row
              TableRow(
                children: [
                  headerCell('Time Slot'),
                  headerCell('Order No.'),
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
                   child: Center(child: Text("${vendorOrderModel?.orders?[index].time}")),
                   ),
                    Container(
                    height: 50,
                    child: Center(child: Text("${vendorOrderModel?.orders?[index].orderId}")),
                   ),
                    Container(
                      height: 50,
                      child: Center(child: Text("${vendorOrderModel?.orders?[index].address}")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: Container(
                        height: 30,
                        width: 60,
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary) ,
                        child: const Center(child: Text("Completed", style: TextStyle(color: colors.whiteTemp,))),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ):  Container(
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
