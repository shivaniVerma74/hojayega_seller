import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/api.path.dart';
import '../Helper/color.dart';
import 'package:http/http.dart' as http;
import '../Model/FestivalModel.dart';
import '../Model/GetTimeSlotModel.dart';
import '../Model/GetVendorOrderModel.dart';

class OrderDetails extends StatefulWidget {
  final VendorOrder? model;
  OrderDetails({Key? key, this.model}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addToRow();
    getTimeSlot();

    for (var i = 0; i< (widget.model?.orderItems?.length ?? 0);i++){
      rows[i][0] = widget.model?.orderItems?[i].qty ??"0";
      rows[i][1] = widget.model?.orderItems?[i].productPrice ?? "0";

    }
    double tempTotal = widget.model?.orderItems?.fold(0.0, (previousValue, element) => previousValue! + double.parse(element.productPrice  ?? '0.0')) ?? 0.0;
    // double tempTotal = widget.model?.orderItems.
    print("total temp is $tempTotal");
    totalPrice = tempTotal.toStringAsFixed(0);
    deliverychargesController.text = widget.model?.deliveryCharge ?? "";
    disController.text = widget.model?.discount ?? "";
    totalController.text = "${int.parse(widget.model?.orderItems?.first.qty.toString() ?? "0") * double.parse(widget.model?.orderItems?.first.productPrice.toString() ?? "0.0") ?? ""}";
  }

  String? vendorId;
  TextEditingController totalController = TextEditingController();
  TextEditingController disController = TextEditingController();
  TextEditingController couponController = TextEditingController();
  TextEditingController deliverychargesController = TextEditingController();

  TextEditingController unitController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  // String? totalPrice ;
  // String? discount ;
  // String? deliveryChargePerKM ;
  int? selectedIndex;

  var s1;
  var s2;
  var s3;
  final List<List<String>> rows = [
    // ["unitController_Row2", "productPriceController_Row2", "sellingPriceController_Row2"],
    // ["unitController_Row3", "productPriceController_Row2", "sellingPriceController_Row3"],
    // ... more rows
  ];

   addToRow(){
     for(var i = 0; i < (widget.model?.orderItems?.length??0); i++){
       rows.add(["u_R${i+1}","p_R${i+1}", "s_R${i+1}"]);
     }
     debugPrint("rows_____ $rows");
   }

  updateOrderItem(i) async {
    debugPrint("rowssssss ${rows[i]}");
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
      'product_id': widget.model?.orderItems?[i].productId.toString()?? "",
      'qty': rows[i][0],
      'price': rows[i][1],
      'sub_total': rows[i][2],
      "order_id": widget.model?.orderId.toString()?? "",

    });
    print('update order itemsss para ${request.fields}');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      Fluttertoast.showToast(msg: finalresult["msg"]);
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
      'order_id': widget.model?.orderId.toString() ?? "",
      'sub_total': totalPrice.toString(),
      'discount': disController.text,
      'time': timefrom,
      'promo_code': '1',
      'final_total': discountAmt.toString(),
      'vehicle_type': (vehicleItem.indexOf(selectedVehicle.toString()) + 1).toString(),
      'total': finalTotal.toString(),
      'time_id': time_id.toString(),
      'order_type': (orderitem.indexOf(selectOrders.toString()) + 1).toString(),
      'delivery_charge': delCharge.toString(),
    });
    print('update order para ${request.fields}');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result.toString());
      print("finalresult  ${finalresult["msg"]}");
      Fluttertoast.showToast(msg: finalresult['msg']);
      Navigator.pop(context);
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            getCurrentOrders(),
          ],
        ),
      ),
    );
  }

  dynamic selectTimeslot;
  var timefrom;
  String? time_id;
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

  FestivalModel? festivalModel;
  checkFestive() async{
    var headers = {
      'Cookie': 'ci_session=357aeaa9c34813410a247f64361084193b7c4337'
    };
    var request = http.Request('POST', Uri.parse('https://developmentalphawizz.com/hojayega/Vendorapi/check_festival'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = FestivalModel.fromJson(json.decode(finalResponse));
      print("get festival model $finalResult $finalResponse");
      setState(() {
        festivalModel = finalResult;
        setState(() {});
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

String? delCharge;
  Future<void> deliveryCharge({required String vType}) async {
    try {
    var headers = {
      'Cookie': 'ci_session=a4cf635dc882bdf7680025f3bdfc1b0dc4027b0b'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/hojayega/Vendorapi/get_delivery_charge_distacee'));
    request.fields.addAll({
      'res_lat': '${widget.model?.vendorLat.toString()}',
      'res_lang': '${widget.model?.vendorLang.toString()}',
      'latitude': '${widget.model?.lat.toString()}',
      'longitude': '${widget.model?.lang.toString()}',
      'vehicle_type': (vehicleItem.indexOf(vType) + 1).toString(),
      'time_slot_id': time_id.toString(),
      'product_type': (productitem.indexOf(selectproducts.toString()) + 1).toString(),
      'type': '1',
      'order_type': (orderitem.indexOf(selectOrders.toString()) + 1).toString(),
    });
    print("delivery cahrge para ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result.toString());
      delCharge = finalresult["data"];
      setState(() {

      });
      print("delivery charge is ${delCharge.toString()}");
      print("final result  in delivery${finalresult["message"]}");
      Fluttertoast.showToast(msg: finalresult['message']);
    }
    else {
    print(response.reasonPhrase);
    }}
    catch (e) {
    throw Exception(e);
    }
  }


  var vehicleItem = [
    'Bike',
    'Electric',
    'Car',
    'Taxi',
    'Truck',
  ];
  var selectBikeType;
  var bikeType = [
    'Electric',
    'Non-Electric',
  ];

  String? selectwhehicle;
  String? selectedVehicle;
  String? totalPrice;
  String? totalAmount;
  String? selectOrders;
  String? disAmt;

  String? selectproducts;
  var orderitem = [
    'Cake/Fragile',
    'Cooked Meal',
    'Food',
    'Non-Food',
  ];
  var productitem = ['Urgent', '2 Way', 'Multiple', 'Flexible'];


  getCurrentOrders() {
    print("sssss@@@@@@@@@@@@${widget.model?.orderItems?[0].subtotal}===========");
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
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                        child: Image.asset("assets/images/nmae.png"),
                      ),
                      Text(
                        "${widget.model?.username}",
                        style: const TextStyle(color: colors.primary),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                        child: Image.asset("assets/images/calenders.png"),
                      ),
                      Text(
                        "${widget.model?.date}".replaceAll("00:00:00.000", ""),
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
                            width: 150,
                          ),
                          Text(
                            "Type",
                            style: TextStyle(color: colors.primary),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            "Rs.",
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
                  itemCount:widget.model?.orderItems?.length ?? 0,
                  itemBuilder: (c, i) {
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
                                            "${widget.model?.orderItems?[i].productImage}", fit: BoxFit.fill,)),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 60,
                                    child: Text(
                                      "${widget.model?.orderItems?[i].productName}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              Text(
                                "${widget.model?.orderItems?[i].unitType}",
                                // rows[i][0].toString() == 'u_R${i + 1}'
                                //     ? "${widget.model?.orderItems?[i].unitType}"
                                //     : rows[i][0],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: colors.primary),
                              ),
                              // ["u_R1", "p_R1", "s_R1"],
                              const SizedBox(
                                width: 40,
                              ),
                              Text(
                                // rows[i][1].toString() == 'p_R${i + 1}'
                                //     ? "${widget.model?.orderItems?[i].subtotal} Rs."
                                //     : rows[i][1],
                                widget.model?.orderItems?[i].productPrice ??'',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: colors.primary),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              // Flexible(
                              //   child: Text(
                              //     rows[i][2].toString() == 's_R${i + 1}'
                              //         ? "${int.parse(widget.model?.orderItems?[i].qty.toString() ?? "0") *double.parse(widget.model?.orderItems?[i].productPrice.toString() ?? "0.0")}"
                              //         : rows[i][2],
                              //     overflow: TextOverflow.ellipsis,
                              //     softWrap: true,
                              //     style: const TextStyle(color: colors.primary),
                              //   ),
                              // ),
                              // const SizedBox(
                              //   width: 10,
                              // ),
                              InkWell(
                                onTap: () {
                                   // var sellingPrice = int.parse(widget.model?.orderItems?[i].qty.toString() ?? "0") * double.parse(widget.model?.orderItems?[i].productPrice.toString() ??"0");
                                    productPriceController.text = widget.model?.orderItems?[i].productPrice ?? "";
                                  // unitController.text = rows[i][0].toString() ?? "";
                                  // productPriceController.text =  rows[i][1].toString();
                                  // unitController.clear();
                                  // productPriceController.clear();
                                  // sellingPriceController.clear();
                                  setState(() {
                                    selectedIndex = i;
                                  });
                                  _showEditDialog12(
                                    // unitController,
                                    productPriceController, i,
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Image.asset("assets/images/edit.png"),
                      totalPrice == null || totalPrice =="" ?  Text(
                        "Total = ${totalAmount.toString()}",
                        style: const TextStyle(color: colors.primary),
                      ):
                      Text(
                        // "Total = ${rows[0][2]}",
                        // "Total = ${int.parse(widget.model?.orderItems?[0].qty.toString() ?? "0") *double.parse(widget.model?.orderItems?[0].productPrice.toString() ?? "0.0")}",
                        "Total = ${totalPrice.toString()}Rs",
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
                          _showEditDialog(disController, "Discount");

                        },
                        child: Image.asset("assets/images/edit.png"),
                      ),
                      Text(
                        "Discount = ${disController.text}Rs",
                        style: const TextStyle(color: colors.primary),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 30,
                      width: 195,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: const Color(0xffE5CB24),
                      ),
                      child: Center(
                        child: discountAmt == null || discountAmt == "" ? const Text("DiscountAmount = 0.0"):
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            "DiscountAmount = $discountAmt Rs",
                            style: const TextStyle(fontSize: 15, color: colors.primary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 5, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Time Slot",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                      Text("",
                          style: TextStyle(
                              fontSize: 1, fontWeight: FontWeight.w400))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonFormField<TimeSlotListBooking>(
                    value: selectTimeslot,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: colors.primary,
                    ),
                    onChanged: ( newValue) {
                      setState(() {
                        selectTimeslot = newValue;
                        time_id = newValue?.id.toString();
                        timefrom ="From ${newValue?.fromTime.toString()} To ${newValue?.toTime.toString()}";
                        print("time from=======$timefrom time id is $time_id===============");
                      });
                    },
                    items: timeSlot.map((TimeSlotListBooking orderitem) {
                      return DropdownMenuItem(
                        value: orderitem,
                        child: SizedBox(
                            width:
                            MediaQuery.of(context).size.width / 1.5,
                            child: Text("${orderitem.fromTime.toString()} - ${orderitem.toTime.toString()}",
                              style: const TextStyle(
                                  color: colors.secondary),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        hintText: 'Select Time Slot',
                        hintStyle: TextStyle(color: colors.primary),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
                // SizedBox(height: 5,),
                // Padding(
                //   padding: const EdgeInsets.only(left: 4),
                //   child: Container(
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: colors.primary),
                //     width: MediaQuery.of(context).size.width / 1.2,
                //     child: Card(
                //       color: colors.primary,
                //       elevation: 2,
                //       child: DropdownButtonFormField<String>(
                //         value: selectedVehicle,
                //         icon: const Icon(
                //           Icons.keyboard_arrow_down_sharp,
                //           color: colors.whiteTemp,
                //         ),
                //         onChanged: (String? newValue) {
                //           setState(() {
                //             selectedVehicle = newValue!;
                //           });
                //         },
                //         items: vehicleItem.map((String orderitem) {
                //           return DropdownMenuItem(
                //             value: orderitem,
                //             child: Text(
                //               orderitem.toString(),
                //               style: TextStyle(color: colors.secondary),
                //             ),
                //           );
                //         }).toList(),
                //         decoration: const InputDecoration(
                //           border: InputBorder.none,
                //           hintText: 'Select Vehicle Type',
                //           hintStyle: TextStyle(color: Colors.white),
                //           filled: true,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Product Type",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("",
                          style: TextStyle(
                              fontSize: 1, fontWeight: FontWeight.w400))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
                  child: DropdownButtonFormField<String>(
                    value: selectOrders,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: colors.primary,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectOrders = newValue!;
                        print(
                            "===my technic=======$selectOrders===============");
                      });
                    },
                    items: orderitem.map((String orderitem) {
                      return DropdownMenuItem(
                        value: orderitem,
                        child: Text(
                          orderitem.toString(),
                          style:
                          const TextStyle(color: colors.secondary),
                        ),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        hintText: 'Select Product Type',
                        hintStyle: TextStyle(color: colors.primary),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 0, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Order Type",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                      Text("",
                          style: TextStyle(
                              fontSize: 1, fontWeight: FontWeight.w400))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonFormField<String>(
                    value: selectproducts,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: colors.primary,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectproducts = newValue!;
                        print("===my technic=======$selectOrders===============");
                      });
                    },
                    items: productitem.map((String orderitem) {
                      return DropdownMenuItem(
                        value: orderitem,
                        child: Text(
                          orderitem.toString(),
                          style:
                          const TextStyle(color: colors.secondary),
                        ),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10),
                          ),
                        ),
                        hintText: 'Select Order Type',
                        hintStyle: TextStyle(color: colors.primary),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 5, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Vehicle Type",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                      Text("",
                          style: TextStyle(
                              fontSize: 1, fontWeight: FontWeight.w400))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonFormField<String>(
                    value: selectedVehicle,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: colors.primary,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedVehicle = newValue!;
                        print(
                            "===vehicle =======$selectedVehicle===============");
                        deliveryCharge(vType: selectedVehicle.toString());
                        double? numericValue = double.tryParse(discountAmt ?? "");
                        double? delValue = double.tryParse(delCharge ?? "");
                        double? result = double.parse(numericValue.toString()) + delValue!;
                        finalTotal = result.toString();
                        print("final total is ${finalTotal.toString()}");
                        setState(() {

                        });
                        // getDeliveryCharges(
                        //     vType: selectedVehicle.toString());
                      });
                    },
                    items: vehicleItem.map((String orderitem) {
                      return DropdownMenuItem(
                        value: orderitem,
                        child: Text(
                          orderitem.toString(),
                          style: const TextStyle(color: colors.secondary),
                        ),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        hintText: 'Select Vehicle Type',
                        hintStyle: TextStyle(color: colors.primary),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(left: 5),
                //       child: Container(
                //         height: 49,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //             color: colors.primary),
                //         width: MediaQuery.of(context).size.width / 2.5,
                //         child: Card(
                //           color: colors.primary,
                //           elevation: 2,
                //           child: DropdownButtonFormField<dynamic>(
                //             value: selectTimeslot,
                //             // icon:  Icon(Icons.keyboard_arrow_down_sharp, color: colors.whiteTemp,),
                //             onChanged: (dynamic newValue) {
                //               setState(() {
                //                 selectTimeslot = newValue;
                //                 timefrom = "From ${newValue.fromTime.toString()} To ${newValue.toTime.toString()}";
                //               });
                //             },
                //             items: timeSlot.map((dynamic orderitem) {
                //               return DropdownMenuItem(
                //                 value: orderitem,
                //                 child: SizedBox(
                //                     width: MediaQuery.of(context).size.width / 1.5,
                //                     child: Text("${orderitem.fromTime.toString()} To ${orderitem.toTime.toString()}",
                //                       style: const TextStyle(
                //                           color: colors.secondary),
                //                       overflow: TextOverflow.ellipsis,
                //                       maxLines: 1,
                //                     ),
                //                 ),
                //               );
                //             }).toList(),
                //             decoration: const InputDecoration(
                //               border: InputBorder.none,
                //               hintText: 'Select Time Slot',
                //               hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                //               filled: true,
                //             ),
                //           ),
                //         ),
                //       ),
                //       // Row(
                //       //   children: [
                //       //     Column(
                //       //       crossAxisAlignment: CrossAxisAlignment.start,
                //       //       children: const [
                //       //         Text("Time", style: TextStyle(
                //       //             fontSize: 15,
                //       //             color: colors.primary,
                //       //             fontWeight: FontWeight.w600)),
                //       //         Text("Vehicle Type", style: TextStyle(
                //       //             fontSize: 15,
                //       //             color: colors.primary,
                //       //             fontWeight: FontWeight.w600)),
                //       //       ],
                //       //     ),
                //       //     SizedBox(width: 176,),
                //       //     // InkWell(
                //       //     //   onTap: () {
                //       //     //     // rejectOrders(context);
                //       //     //   },
                //       //     //   child: Container(
                //       //     //     height: 25,
                //       //     //     width: 60,
                //       //     //     decoration: BoxDecoration(
                //       //     //         borderRadius: BorderRadius.circular(5),
                //       //     //         color: colors.primary),
                //       //     //     child: const Center(
                //       //     //       child: Text(
                //       //     //         "Edit",
                //       //     //         style: TextStyle(
                //       //     //             fontSize: 15, color: colors.whiteTemp),
                //       //     //       ),
                //       //     //     ),
                //       //     //   ),
                //       //     // ),
                //       //     // const SizedBox(
                //       //     //   width: 6,
                //       //     // ),
                //       //     InkWell(
                //       //       onTap: () {
                //       //         // acceptRejectOrders(vendorOrderModel?.orders?[i].orderId);
                //       //         setState(() {});
                //       //         Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetails()),
                //       //         );
                //       //       },
                //       //       child: Container(
                //       //         height: 25,
                //       //         width: 60,
                //       //         decoration: BoxDecoration(
                //       //             borderRadius: BorderRadius.circular(5),
                //       //             color: colors.secondary),
                //       //         child: const Center(
                //       //           child: Text(
                //       //             "Send", style: TextStyle(
                //       //               fontSize: 15, color: colors.whiteTemp),
                //       //           ),
                //       //         ),
                //       //       ),
                //       //     ),
                //       //   ],
                //       // ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 5),
                //       child: Container(
                //         height: 40,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //             color: colors.primary),
                //         width: MediaQuery.of(context).size.width / 2.5,
                //         child: Card(
                //           color: colors.primary,
                //           elevation: 2,
                //           child: DropdownButtonFormField<dynamic>(
                //             value: selectTimeslot,
                //             // icon:  Icon(Icons.keyboard_arrow_down_sharp, color: colors.whiteTemp,),
                //             onChanged: (dynamic newValue) {
                //               setState(() {
                //                 selectTimeslot = newValue;
                //                 timefrom =
                //                 "From ${newValue.fromTime.toString()} To ${newValue.toTime.toString()}";
                //                 print(
                //                     "===my technic=======$timefrom===============");
                //               });
                //             },
                //             items: timeSlot.map((dynamic orderitem) {
                //               return DropdownMenuItem(
                //                 value: orderitem,
                //                 child: SizedBox(
                //                     width:
                //                     MediaQuery.of(context).size.width / 1.5,
                //                     child: Text(
                //                       "${orderitem.fromTime.toString()} To ${orderitem.toTime.toString()}",
                //                       style: const TextStyle(
                //                           color: colors.secondary),
                //                       overflow: TextOverflow.ellipsis,
                //                       maxLines: 1,
                //                     )),
                //               );
                //             }).toList(),
                //             decoration: const InputDecoration(
                //               border: InputBorder.none,
                //               hintText: 'Select Vehicle',
                //               hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                //               filled: true,
                //             ),
                //           ),
                //         ),
                //       ),
                //       // Row(
                //       //   children: [
                //       //     Column(
                //       //       crossAxisAlignment: CrossAxisAlignment.start,
                //       //       children: const [
                //       //         Text("Time", style: TextStyle(
                //       //             fontSize: 15,
                //       //             color: colors.primary,
                //       //             fontWeight: FontWeight.w600)),
                //       //         Text("Vehicle Type", style: TextStyle(
                //       //             fontSize: 15,
                //       //             color: colors.primary,
                //       //             fontWeight: FontWeight.w600)),
                //       //       ],
                //       //     ),
                //       //     SizedBox(width: 176,),
                //       //     // InkWell(
                //       //     //   onTap: () {
                //       //     //     // rejectOrders(context);
                //       //     //   },
                //       //     //   child: Container(
                //       //     //     height: 25,
                //       //     //     width: 60,
                //       //     //     decoration: BoxDecoration(
                //       //     //         borderRadius: BorderRadius.circular(5),
                //       //     //         color: colors.primary),
                //       //     //     child: const Center(
                //       //     //       child: Text(
                //       //     //         "Edit",
                //       //     //         style: TextStyle(
                //       //     //             fontSize: 15, color: colors.whiteTemp),
                //       //     //       ),
                //       //     //     ),
                //       //     //   ),
                //       //     // ),
                //       //     // const SizedBox(
                //       //     //   width: 6,
                //       //     // ),
                //       //     InkWell(
                //       //       onTap: () {
                //       //         // acceptRejectOrders(vendorOrderModel?.orders?[i].orderId);
                //       //         setState(() {});
                //       //         Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetails()),
                //       //         );
                //       //       },
                //       //       child: Container(
                //       //         height: 25,
                //       //         width: 60,
                //       //         decoration: BoxDecoration(
                //       //             borderRadius: BorderRadius.circular(5),
                //       //             color: colors.secondary),
                //       //         child: const Center(
                //       //           child: Text(
                //       //             "Send", style: TextStyle(
                //       //               fontSize: 15, color: colors.whiteTemp),
                //       //           ),
                //       //         ),
                //       //       ),
                //       //     ),
                //       //   ],
                //       // ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 5),
                  child:
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     InkWell(
                  //       onTap: () {
                  //         _showEditDialog(deliverychargesController,
                  //             "Delivery Charge as per Km ");
                  //       },
                  //       child: Image.asset("assets/images/edit.png"),
                  //     ),
                  //     Text(
                  //       "Delivery Charge as per Km = ${deliverychargesController.text}rs",
                  //       style: const TextStyle(color: colors.primary),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Image.asset("assets/images/edit.png"),
                      const Text(
                        "Delivery Charge as per Km = ",
                        style: TextStyle(color: colors.primary),
                      ),
                      delCharge == null || delCharge== "" ? const Text("0.0") :
                      Text(
                        "${delCharge.toString()}Rs",
                        style: const TextStyle(color: colors.primary, fontWeight: FontWeight.bold),
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
                const SizedBox(
                  height: 7,
                ),
                const Divider(
                  color: Colors.black,
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
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: const Color(0xffE5CB24),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: finalTotal == null || finalTotal == "" ? Text("0.0"):
                            Text(
                              "Total = ${finalTotal.toString()} Rs",
                              style: const TextStyle(fontSize: 15, color: colors.primary),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: InkWell(
                        onTap: () {
                          // acceptRejectOrders(vendorOrderModel?.orders?[i].orderId);
                          if(timefrom == null || selectTimeslot == null){
                            Fluttertoast.showToast(msg: "Please Select Time Slot");
                          }
                          else if (selectedVehicle == null){
                            Fluttertoast.showToast(msg: "Please Select Vehicle Type");
                          }
                          else {
                            setState(() {
                              updateOrder();
                            });
                          }
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

  String? discountAmt;
  String? finalTotal;
  void _showEditDialog(TextEditingController controller, String fieldName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(fieldName),
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
                double? numericValue = double.tryParse(totalPrice ?? "");
                double? inputValue = double.tryParse(controller.text);
                double? result = double.parse(numericValue.toString()) - inputValue!;
                discountAmt = result.toString();
                print("dis amount is $discountAmt");
                  setState(() {
                    // controller.text = controller.text;
                  });
                // disController.clear();
                  // switch(fieldName){
                  //   case "Total":
                  //     setState(() {
                  //       totalPrice = controller.text;
                  //     });
                  //     break;
                  //   case "Discount":
                  //     setState(() {
                  //       discount = controller.text;
                  //     });
                  //     break;
                  //   default :
                  //     setState(() {
                  //       deliveryChargePerKM = controller.text;
                  //     });
                  // }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog12(
    TextEditingController productPriceController,

    int i,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Product Details"),
          content: Container(
            height: 100,
            child: Column(
              children: [
                // TextField(
                //   controller: unitController,
                //   keyboardType: TextInputType.text,
                //   decoration: const InputDecoration(labelText: "Unit"),
                // ),
                TextField(
                  controller: productPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Product Price"),
                ),
                // TextField(
                //   controller: sellingPriceController,
                //   readOnly: true,
                //   keyboardType: TextInputType.number,
                //   decoration: const InputDecoration(labelText: "Total Price"),
                // ),
              ],
            ),
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
                setState(() {
                  // unitController.text=unitController.text;
                  // rows[i][0] = unitController.text;
                  // rows[i][1] = productPriceController.text;
                  //rows[i][2] = (double.parse(unitController.text) * double.parse(productPriceController.text) ).toString();
                  widget.model?.orderItems?[i].productPrice= productPriceController.text;
                  double tempTotal = widget.model?.orderItems?.fold(0.0, (previousValue, element) => previousValue! + double.parse(element.productPrice  ?? '0.0')) ?? 0.0;
                  // double tempTotal = widget.model?.orderItems.
                  print("total temp is $tempTotal");
                  
                  totalPrice = tempTotal.toStringAsFixed(0);

                  // productPriceController.text=productPriceController.text;
                  // sellingPriceController.text=sellingPriceController.text;
                  // widget.model?.orderItems?[i].unit = unitController.text;
                  // widget.model?.orderItems?[i].productPrice = productPriceController.text;
                  // widget.model?.orderItems?[i].sellingPrice = sellingPriceController.text;
                  // updateOrderItem(i).then((val){setState(() {
                  // });});
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
