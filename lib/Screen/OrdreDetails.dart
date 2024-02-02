import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/api.path.dart';
import '../Helper/color.dart';
import 'package:http/http.dart' as http;
import '../Model/GetTimeSlotModel.dart';
import '../Model/GetVendorOrderModel.dart';

class OrderDetails extends StatefulWidget {
  final VendorOrders? model;
  OrderDetails({Key? key, this.model}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTimeSlot();
  }

  String? vendorId;
  TextEditingController totalController = TextEditingController();
  TextEditingController disController = TextEditingController();
  TextEditingController couponController = TextEditingController();
  TextEditingController deliverychargesController = TextEditingController();

  TextEditingController unitController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  int? selectedIndex;

  var s1;
  var s2;
  var s3;

  final List<List<String>> rows = [
    ["u_R1", "p_R1", "s_R1"],
    ["u_R2", "p_R2", "s_R2"],
    ["u_R3", "p_R3", "s_R3"],
    // ["unitController_Row2", "productPriceController_Row2", "sellingPriceController_Row2"],
    // ["unitController_Row3", "productPriceController_Row2", "sellingPriceController_Row3"],
    // ... more rows
  ];

  updateOrderItem() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    vendorId = preferences.getString('vendor_id');
    print("vendor id ordre details product screen $vendorId");
    var headers = {
      'Cookie': 'ci_session=92be93dffe80535f6ad557b44fba127560142fe4'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.updateOrderItem));
    request.fields.addAll({
      'user_id': vendorId.toString(),
      'type': '1',
      'product_id': '',
      'qty': '',
      'price': '',
      'sub_total': ''
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  updateOrder() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    vendorId = preferences.getString('vendor_id');
    var headers = {
      'Cookie': 'ci_session=92be93dffe80535f6ad557b44fba127560142fe4'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.updateOrders));
    request.fields.addAll({
      'user_id': vendorId.toString(),
      'order_id': '330',
      'sub_total': '1',
      'discount': '1',
      'promo_code': '',
      'final_total': '10',
      'vehicle_type': '1',
      'total': '100'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

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
          title: const Text('Details'),
          backgroundColor: colors.primary),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          getCurrentOrders(),
        ],
      ),
    );
  }

  dynamic selectTimeslot;
  var timefrom;
  List<TimeSlotListBooking> timeSlot = [];
  Future<void> getTimeSlot() async {
    var headers = {
      'Cookie': 'ci_session=c4664ff6d31ce6221e37b407dfcd60d4e14b6df3'
    };
    var request = http.Request('POST', Uri.parse(ApiServicves.timeSlots));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      if (finalresult['status'] == 1) {
        timeSlot = GetTimeSlotModel.fromJson(finalresult).booking ?? [];
        setState(() {});
      } else {
        timeSlot.clear();
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  getCurrentOrders() {
    return Column(
      children: [
        // ListView.builder(
        //     shrinkWrap: true,
        //     itemCount: vendorOrderModel?.orders?.length ?? 0,
        //     itemBuilder: (c,i) {
        //       return
        //
        //     })
        //     : Container(
        //   height:
        //   MediaQuery.of(context).size.height/2.5,
        //   child: const Center(
        //     child: Text("Data Not Found"),
        //   ),
        // ),
        Card(
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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: colors.primary),
                        child: Image.asset("assets/images/nmae.png"),
                      ),
                      Text(
                        "${widget.model?.username}",
                        style: const TextStyle(color: colors.primary),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: colors.primary),
                        child: Image.asset("assets/images/calenders.png"),
                      ),
                      Text(
                        "${widget.model?.date}",
                        style: const TextStyle(color: colors.primary),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: colors.primary),
                        child: Image.asset("assets/images/time.png"),
                      ),
                      Text(
                        "${widget.model?.time}".replaceAll("From", ""),
                        style: const TextStyle(color: colors.primary),
                      ),
                      // Container(
                      //   width: 20,
                      //   height: 20,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(5),
                      //       color: colors.primary),
                      //   child: Image.asset("assets/images/noofitem.png"),
                      // ),
                      // const Text(
                      //   "No. of item",
                      //   style: TextStyle(color: colors.primary),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
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
                        "${widget.model?.address}",
                        style: const TextStyle(
                            fontSize: 15, color: colors.primary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "Note: send small size of products",
                    style: TextStyle(fontSize: 15, color: colors.primary),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 5),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Image.asset("assets/images/edit.png"),
                //       const SizedBox(width: 2),
                //       Image.asset("assets/images/delete.png"),
                //       const SizedBox(width: 2),
                //       Image.asset("assets/images/view.png"),
                //     ],
                //   ),
                // ),
                const Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9, right: 2),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            "Name",
                            style: TextStyle(color: colors.primary),
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Text(
                            "Qty",
                            style: TextStyle(color: colors.primary),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            "Rs",
                            style: TextStyle(color: colors.primary),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            "Total",
                            style: TextStyle(color: colors.primary),
                          ),
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
                  itemCount: 3,
                  itemBuilder: (c, i) {
                    print(
                        "======${rows[i][0].toString()}=======u_R${i + 1}=======");
                    return Padding(
                      padding: const EdgeInsets.only(left: 5, right: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Card(
                                    elevation: 4,
                                    child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                            color: Colors.white),
                                        child: Image.network(
                                            "${widget.model?.orderItems?.first.productImage}")),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 60,
                                    child: Text(
                                      "${widget.model?.orderItems?.first.productName}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Text(
                                rows[i][0].toString() == 'u_R${i + 1}'
                                    ? "1"
                                    : "${rows[i][0]}rs",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: colors.primary),
                              ),
                              // ["u_R1", "p_R1", "s_R1"],
                              const SizedBox(
                                width: 40,
                              ),
                              Text(
                                rows[i][1].toString() == 'p_R${i + 1}'
                                    ? "2"
                                    : "${rows[i][1]}rs",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: colors.primary),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Text(
                                rows[i][2].toString() == 's_R${i + 1}'
                                    ? "3"
                                    : "${rows[i][2]}rs",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: colors.primary),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  print(i.toString());
                                  unitController.text = rows[i][0];
                                  productPriceController.text = rows[i][1];
                                  sellingPriceController.text = rows[i][2];
                                  // unitController.clear();
                                  // productPriceController.clear();
                                  // sellingPriceController.clear();
                                  setState(() {
                                    //  selectedIndex=0;
                                    selectedIndex = i;
                                  });
                                  _showEditDialog12(
                                    unitController,
                                    productPriceController,
                                    sellingPriceController, i,
                                  );
                                  // unitController.text="";
                                  // unitController.text="";
                                  // unitController.clear();
                                  // productPriceController.clear();
                                  // sellingPriceController.clear();
                                },
                                child: Image.asset("assets/images/edit.png"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // ListView.builder(
                //   shrinkWrap: true,
                //   itemCount: widget.model?.orderItems?.length ?? 0,
                //   itemBuilder: (c, i) {
                //     return Padding(
                //       padding: const EdgeInsets.only(left: 5, right: 2),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Row(
                //             children: [
                //               Card(
                //                 elevation: 4,
                //                 child: Container(
                //                     width: 25,
                //                     height: 25,
                //                     decoration: BoxDecoration(
                //                         borderRadius: BorderRadius.circular(
                //                           5,
                //                         ),
                //                         color: Colors.white),
                //                     child: Image.network(
                //                       "${widget.model?.orderItems?[i].productImage}",
                //                       color: Colors.red,
                //                     )),
                //               ),
                //               const SizedBox(
                //                 width: 5,
                //               ),
                //               widget.model?.orderItems?[i].productName ==
                //                   "" ||
                //                   widget.model?.orderItems?[i]
                //                       .productName ==
                //                       null
                //                   ? Text(
                //                 "Foods",
                //                 style: TextStyle(color: colors.primary),
                //               )
                //                   : Container(
                //                   width: 49,
                //                   child: Text(
                //                     "${widget.model?.orderItems?[i].productName}",
                //                     style: TextStyle(
                //                         color: colors.primary,
                //                         overflow: TextOverflow.ellipsis),
                //                   )),
                //               const SizedBox(
                //                 width: 50,
                //               ),
                //               Text(rows[i][0].toString()=='unitController_Row1'?
                //                 "${widget.model?.orderItems?[i].unit}":"${rows[i][0]}",
                //                 style: TextStyle(color: colors.primary),
                //               ),
                //               const SizedBox(
                //                 width: 40,
                //               ),
                //               Text(rows[i][1].toString()=='productPriceController_Row1'?
                //                 "${widget.model?.orderItems?[i].productPrice}rs":"${rows[i][1]}",
                //                 style: TextStyle(color: colors.primary),
                //               ),
                //               const SizedBox(
                //                 width: 30,
                //               ),
                //               Text(rows[i][2].toString()=='sellingPriceController_Row1'?
                //                 "${widget.model?.orderItems?[i].sellingPrice}rs":"${rows[i][2]}",
                //                 style: TextStyle(color: colors.primary),
                //               ),
                //               const SizedBox(
                //                 width: 10,
                //               ),
                //               InkWell(
                //                 onTap: () {
                //                   // unitController.clear();
                //                   // productPriceController.clear();
                //                   // sellingPriceController.clear();
                //                   setState(() {
                //                   //  selectedIndex=0;
                //                     selectedIndex=i;
                //                   });
                //
                //                   _showEditDialog12(
                //                     unitController,
                //                     productPriceController,
                //                     sellingPriceController,
                //                     i,  // Pass the index variable 'i'
                //                   );
                //                   // unitController.text="";
                //                   // unitController.text="";
                //                   // unitController.clear();
                //                   // productPriceController.clear();
                //                   // sellingPriceController.clear();
                //                 },
                //                 child: Image.asset("assets/images/EDIT.png"),
                //               ),
                //             ],
                //           )
                //         ],
                //       ),
                //     );
                //   },
                // ),
                const Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _showEditDialog(totalController, "Total");
                        },
                        child: Image.asset("assets/images/edit.png"),
                      ),
                      Text(
                        "Total = ${totalController.text}rs",
                        style: const TextStyle(color: colors.primary),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _showEditDialog(disController, "Dis");
                        },
                        child: Image.asset("assets/images/edit.png"),
                      ),
                      Text(
                        "Dis = ${disController.text}rs",
                        style: TextStyle(color: colors.primary),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 8, right: 5),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       InkWell(
                //         onTap: () {
                //           _showEditDialog(couponController,
                //               "Coupon =feb/haldiram/indira/001");
                //         },
                //         child: Image.asset("assets/images/edit.png"),
                //       ),
                //       Text("Coupon =feb/haldiram/indira/001 = ${couponController
                //           .text}rs", style: TextStyle(color: colors.primary),),
                //     ],
                //   ),
                // ),
                // const Divider(
                //   color: Colors.black,
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _showEditDialog(deliverychargesController,
                              "Delivery Charge as per Km ");
                        },
                        child: Image.asset("assets/images/edit.png"),
                      ),
                      Text(
                        "Delivery Charge as per Km = ${deliverychargesController.text}rs",
                        style: TextStyle(color: colors.primary),
                      ),
                    ],
                  ),
                ),
                // const Divider(
                //   color: Colors.black,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 8, right: 5),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //
                //     children: [
                //       Image.asset("assets/images/EDIT.png"),
                //       Text("Coupon =feb/haldiram/indira/001 = -3rs", style: TextStyle(color: colors.primary),),
                //     ],
                //   ),
                // ),

                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        // rejectOrders(context);
                      },
                      child: Container(
                        height: 30,
                        width: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Color(0xffE5CB24)),
                        child: const Center(
                          child: Text(
                            "Total = 103rs",
                            style:
                                TextStyle(fontSize: 15, color: colors.primary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colors.primary),
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Card(
                          color: colors.primary,
                          elevation: 2,
                          child: DropdownButtonFormField<dynamic>(
                            value: selectTimeslot,
                            // icon:  Icon(Icons.keyboard_arrow_down_sharp, color: colors.whiteTemp,),
                            onChanged: (dynamic newValue) {
                              setState(() {
                                selectTimeslot = newValue;
                                timefrom =
                                    "From ${newValue.fromTime.toString()} To ${newValue.toTime.toString()}";
                                print(
                                    "===my technic=======$timefrom===============");
                              });
                            },
                            items: timeSlot.map((dynamic orderitem) {
                              return DropdownMenuItem(
                                value: orderitem,
                                child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Text(
                                      "${orderitem.fromTime.toString()} To ${orderitem.toTime.toString()}",
                                      style: const TextStyle(
                                          color: colors.secondary),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                ),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Select Time Slot',
                              hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: const [
                      //         Text("Time", style: TextStyle(
                      //             fontSize: 15,
                      //             color: colors.primary,
                      //             fontWeight: FontWeight.w600)),
                      //         Text("Vehicle Type", style: TextStyle(
                      //             fontSize: 15,
                      //             color: colors.primary,
                      //             fontWeight: FontWeight.w600)),
                      //       ],
                      //     ),
                      //     SizedBox(width: 176,),
                      //     // InkWell(
                      //     //   onTap: () {
                      //     //     // rejectOrders(context);
                      //     //   },
                      //     //   child: Container(
                      //     //     height: 25,
                      //     //     width: 60,
                      //     //     decoration: BoxDecoration(
                      //     //         borderRadius: BorderRadius.circular(5),
                      //     //         color: colors.primary),
                      //     //     child: const Center(
                      //     //       child: Text(
                      //     //         "Edit",
                      //     //         style: TextStyle(
                      //     //             fontSize: 15, color: colors.whiteTemp),
                      //     //       ),
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //     // const SizedBox(
                      //     //   width: 6,
                      //     // ),
                      //     InkWell(
                      //       onTap: () {
                      //         // acceptRejectOrders(vendorOrderModel?.orders?[i].orderId);
                      //         setState(() {});
                      //         Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetails()),
                      //         );
                      //       },
                      //       child: Container(
                      //         height: 25,
                      //         width: 60,
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(5),
                      //             color: colors.secondary),
                      //         child: const Center(
                      //           child: Text(
                      //             "Send", style: TextStyle(
                      //               fontSize: 15, color: colors.whiteTemp),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colors.primary),
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Card(
                          color: colors.primary,
                          elevation: 2,
                          child: DropdownButtonFormField<dynamic>(
                            value: selectTimeslot,
                            // icon:  Icon(Icons.keyboard_arrow_down_sharp, color: colors.whiteTemp,),
                            onChanged: (dynamic newValue) {
                              setState(() {
                                selectTimeslot = newValue;
                                timefrom =
                                "From ${newValue.fromTime.toString()} To ${newValue.toTime.toString()}";
                                print(
                                    "===my technic=======$timefrom===============");
                              });
                            },
                            items: timeSlot.map((dynamic orderitem) {
                              return DropdownMenuItem(
                                value: orderitem,
                                child: SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width / 1.5,
                                    child: Text(
                                      "${orderitem.fromTime.toString()} To ${orderitem.toTime.toString()}",
                                      style: const TextStyle(
                                          color: colors.secondary),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    )),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Select Vehicle',
                              hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: const [
                      //         Text("Time", style: TextStyle(
                      //             fontSize: 15,
                      //             color: colors.primary,
                      //             fontWeight: FontWeight.w600)),
                      //         Text("Vehicle Type", style: TextStyle(
                      //             fontSize: 15,
                      //             color: colors.primary,
                      //             fontWeight: FontWeight.w600)),
                      //       ],
                      //     ),
                      //     SizedBox(width: 176,),
                      //     // InkWell(
                      //     //   onTap: () {
                      //     //     // rejectOrders(context);
                      //     //   },
                      //     //   child: Container(
                      //     //     height: 25,
                      //     //     width: 60,
                      //     //     decoration: BoxDecoration(
                      //     //         borderRadius: BorderRadius.circular(5),
                      //     //         color: colors.primary),
                      //     //     child: const Center(
                      //     //       child: Text(
                      //     //         "Edit",
                      //     //         style: TextStyle(
                      //     //             fontSize: 15, color: colors.whiteTemp),
                      //     //       ),
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //     // const SizedBox(
                      //     //   width: 6,
                      //     // ),
                      //     InkWell(
                      //       onTap: () {
                      //         // acceptRejectOrders(vendorOrderModel?.orders?[i].orderId);
                      //         setState(() {});
                      //         Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetails()),
                      //         );
                      //       },
                      //       child: Container(
                      //         height: 25,
                      //         width: 60,
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(5),
                      //             color: colors.secondary),
                      //         child: const Center(
                      //           child: Text(
                      //             "Send", style: TextStyle(
                      //               fontSize: 15, color: colors.whiteTemp),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Center(
                  child: InkWell(
                        onTap: () {
                          // acceptRejectOrders(vendorOrderModel?.orders?[i].orderId);
                          setState(() {});
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetails()),
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: colors.secondary),
                          child: const Center(
                            child: Text(
                              "Send", style: TextStyle(
                                fontSize: 16, color: colors.whiteTemp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showEditDialog(TextEditingController controller, String fieldName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $fieldName"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "$fieldName Value"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update the corresponding field and close the dialog
                setState(() {
                  // You may want to add validation here before updating the controller text
                  controller.text = controller.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog12(
    TextEditingController unitController,
    TextEditingController productPriceController,
    TextEditingController sellingPriceController,
    int i,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Product Details"),
          content: Container(
            height: 200,
            child: Column(
              children: [
                TextField(
                  controller: unitController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Unit"),
                ),
                TextField(
                  controller: productPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Product Price"),
                ),
                TextField(
                  controller: sellingPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Selling Price"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // unitController.text=unitController.text;
                  rows[i][0] = unitController.text;
                  rows[i][1] = productPriceController.text;
                  rows[i][2] = sellingPriceController.text;
                  // productPriceController.text=productPriceController.text;
                  // sellingPriceController.text=sellingPriceController.text;
                  // widget.model?.orderItems?[i].unit = unitController.text;
                  // widget.model?.orderItems?[i].productPrice = productPriceController.text;
                  // widget.model?.orderItems?[i].sellingPrice = sellingPriceController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
