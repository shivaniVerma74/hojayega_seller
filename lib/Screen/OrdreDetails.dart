import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/api.path.dart';
import '../Helper/color.dart';
import 'package:http/http.dart' as http;
import '../Model/GetVendorOrderModel.dart';

class OrderDetails extends StatefulWidget {
  final VendorOrders? model;
  OrderDetails({Key? key, this.model}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

String? vendorId;
  updateOrderItem() async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    vendorId = preferences.getString('vendor_id');
    print("vendor id ordre details product screen $vendorId");
    var headers = {
      'Cookie': 'ci_session=92be93dffe80535f6ad557b44fba127560142fe4'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.updateOrderItem));
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
    }
    else {
      print(response.reasonPhrase);
    }
  }


  updateOrder() async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    vendorId = preferences.getString('vendor_id');
    var headers = {
      'Cookie': 'ci_session=92be93dffe80535f6ad557b44fba127560142fe4'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.updateOrders));
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
    }
    else {
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
          SizedBox(height: 20,),
          getCurrentOrders(),
        ],
      ),
    );
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5,),
                            color: colors.primary),
                        child: Image.asset("assets/images/nmae.png"),
                      ),
                      Text(
                        "${widget.model?.username}",
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
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
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
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
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
                        style: const TextStyle(fontSize: 15, color: colors.primary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5,),
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text("Note: send small size of products",  style: TextStyle(fontSize: 15, color: colors.primary),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset("assets/images/edit.png"),
                      const SizedBox(width: 2),
                      Image.asset("assets/images/delete.png"),
                      const SizedBox(width: 2),
                      Image.asset("assets/images/view.png"),
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
                          Text(
                            "Name",
                            style: TextStyle(color: colors.primary),
                          ),
                          SizedBox(
                            width: 120,
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
                    itemCount: widget.model?.orderItems?.length ?? 0,
                    itemBuilder: (c, i) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, right: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                        "${widget.model?.orderItems?[i].productImage}",
                                        color: Colors.red,
                                      )),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                widget.model?.orderItems?[i].productName ==
                                            "" ||
                                        widget.model?.orderItems?[i]
                                                .productName ==
                                            null
                                    ? Text(
                                        "Foods",
                                        style: TextStyle(color: colors.primary),
                                      )
                                    : Container(
                                        width: 49,
                                        child: Text(
                                          "${widget.model?.orderItems?[i].productName}",
                                          style: TextStyle(
                                              color: colors.primary,
                                              overflow: TextOverflow.ellipsis),
                                        )),
                                const SizedBox(
                                  width: 75,
                                ),
                                widget.model?.orderItems?[i].unit == "" ||
                                        widget.model?.orderItems?[i].unit ==
                                            null
                                    ? Text(
                                        "1Kg",
                                        style: TextStyle(color: colors.primary),
                                      )
                                    : Text(
                                        "${widget.model?.orderItems?[i].unit}",
                                        style: TextStyle(color: colors.primary),
                                      ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  "${widget.model?.orderItems?[i].productPrice}",
                                  style: TextStyle(color: colors.primary),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  "${widget.model?.orderItems?[i].sellingPrice}rs",
                                  style: TextStyle(color: colors.primary),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }),
                const Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/images/editred.png"),
                      Text("Total = 103rs", style: TextStyle(color: colors.primary),),
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
                      Image.asset("assets/images/editred.png"),
                      Text("Dis = 10rs", style: TextStyle(color: colors.primary),),
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
                      Image.asset("assets/images/editred.png"),
                      Text("Coupon =feb/haldiram/indira/001 = -3rs", style: TextStyle(color: colors.primary),),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only( right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Delivery Charge as per Km = 3rs", style: TextStyle(color: colors.primary),),
                    ],
                  ),
                ),
                SizedBox(height: 7,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        // rejectOrders(context);
                      },
                      child: Container(
                        height:30 ,
                        width: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Color(0xffE5CB24)),
                        child: const Center(
                          child: Text(
                            "Total = 103rs",
                            style: TextStyle(
                                fontSize: 15, color: colors.primary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                        Text("Time", style: TextStyle(
                            fontSize: 15, color: colors.primary, fontWeight: FontWeight.w600)),
                        Text("Vehicle Type", style: TextStyle(
                            fontSize: 15, color: colors.primary, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      SizedBox(width: 126,),
                      InkWell(
                        onTap: () {
                          // rejectOrders(context);
                        },
                        child: Container(
                          height:25,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: colors.primary),
                          child: const Center(
                              child: Text(
                            "Edit",
                            style: TextStyle(
                                fontSize: 15, color: colors.whiteTemp),
                             ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      InkWell(
                        onTap: () {
                          // acceptRejectOrders(vendorOrderModel?.orders?[i].orderId);
                          setState(() {});
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetails()));
                        },
                        child: Container(
                          height: 25,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: colors.secondary),
                          child: const Center(
                              child: Text(
                                "Send", style: TextStyle(fontSize: 15, color: colors.whiteTemp),
                              ),
                          ),
                        ),
                      ),
                    ],
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
}
