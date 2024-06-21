import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Color.dart';
import '../Helper/api.path.dart';
import '../Model/PickDropModel.dart';
import 'BottomBar.dart';

class MyPickDrop extends StatefulWidget {
  const MyPickDrop({Key? key}) : super(key: key);

  @override
  State<MyPickDrop> createState() => _MyPickDropState();
}

class _MyPickDropState extends State<MyPickDrop> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickDrop();
  }

  PickDropModel? pickDropData;
  pickDrop() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? vendorId = prefs.getString("vendor_id");
    var headers = {
      'Cookie': 'ci_session=f159c14a85a360db27f0daf0bbae9fa85626d317'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.myPickDrop));
    request.fields.addAll({
      'user_id': vendorId.toString(),
    });
    print("user id in pick drop${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = PickDropModel.fromJson(json.decode(finalResponse));
      print("responseeee $finalResponse");
      setState(() {
        pickDropData = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  getPickDropOrdre() {
    return pickDropData?.orders.length == null ||
            pickDropData?.orders.length == ""
        ? const Center(
            child: Text(
              "Order Not Found",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          )
        : Container(
            // height: MediaQuery.of(context).size.height*0.9,
            child: ListView.builder(
                itemCount: pickDropData?.orders.length ?? 0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // pickDropData?.orders[index].productType == "" ?
                                Row(
                                  children: [
                                    Text(
                                      "${pickDropData?.orders[index].productType}",
                                      style: const TextStyle(
                                          color: colors.primary,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13),
                                    ),
                                    Text(
                                      "${pickDropData?.orders[index].ordersType}",
                                      style: const TextStyle(
                                          color: colors.primary,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13),
                                    ),
                                    // Visibility(
                                    //   visible:  pickDropData?.orders[index].ordersType == "1",
                                    //   child: const Text(
                                    //     "Flexible",
                                    //     style: TextStyle(
                                    //         fontWeight: FontWeight.w400, fontSize: 16),
                                    //   ),
                                    // ),
                                    // Visibility(
                                    //   visible: pickDropData?.orders[index].ordersType == "2",
                                    //   child: const Text(
                                    //     "Urgent",
                                    //     style: TextStyle(
                                    //         fontWeight: FontWeight.w400, fontSize: 16),
                                    //   ),
                                    // ),
                                    // Visibility(
                                    //   visible:  pickDropData?.orders[index].ordersType == "3",
                                    //   child: const Text(
                                    //     "2 Way",
                                    //     style: TextStyle(
                                    //         fontWeight: FontWeight.w400, fontSize: 16),
                                    //   ),
                                    // ),
                                    // Visibility(
                                    //   visible: pickDropData?.orders[index].ordersType == "4",
                                    //   child: const Text(
                                    //     "Multiple",
                                    //     style: TextStyle(
                                    //         fontWeight: FontWeight.w400, fontSize: 16),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order Id: ",
                                      style: const TextStyle(
                                          color: colors.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                    Text(
                                      "${pickDropData?.orders[index].orderId}",
                                      style: const TextStyle(
                                          color: colors.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                                pickDropData?.orders[index].productImage == null
                                    ? Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            scale: 0.5,
                                            image: AssetImage(
                                                "assets/images/placeholder.png"),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            scale: 0.5,
                                            image: NetworkImage(
                                                "${pickDropData?.orders[index].productImage}"),
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: const [
                                //     Text("Distance:",
                                //         style: TextStyle(
                                //             color: colors.primary,
                                //             fontSize: 12,
                                //             fontWeight: FontWeight.bold),
                                //     ),
                                //     Text("1.38KM",
                                //         style: TextStyle(
                                //             color: colors.primary,
                                //             fontSize: 12,
                                //             fontWeight: FontWeight.bold),
                                //     ),
                                //   ],
                                // ),
                                // const SizedBox(
                                //   height: 10,
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Amount:",
                                        style: TextStyle(
                                            color: colors.primary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "Rs. ${pickDropData?.orders[index].total}",
                                        style: const TextStyle(
                                            color: colors.primary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Payment:",
                                        style: TextStyle(
                                            color: colors.primary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      "${pickDropData?.orders[index].paymentMode}",
                                      style: const TextStyle(
                                          color: colors.primary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Center(
                                //   child: Column(
                                //     children: [
                                //       const Text(
                                //         "Bill",
                                //         style: TextStyle(
                                //           color: colors.primary,
                                //         ),
                                //       ),
                                //       InkWell(
                                //         onTap: () {
                                //           print("invoice ${pickDropData?.orders[index].invoice}");
                                //           _launchURL("${pickDropData?.orders[index].invoice}");
                                //         },
                                //         child: const Icon(
                                //           Icons.receipt,
                                //           size: 30,
                                //           color: colors.primary,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            color: colors.primary,
                            width: 2,
                            thickness: 2,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Date - ${pickDropData?.orders[index].date}"
                                          .replaceAll("00:00:00.000", ""),
                                      style: const TextStyle(
                                          color: colors.primary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${pickDropData?.orders[index].username}",
                                  style: const TextStyle(
                                      color: colors.primary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                // const Text("Note.....",
                                //     style: TextStyle(
                                //         color: colors.primary,
                                //         fontSize: 14,
                                //         fontWeight: FontWeight.bold)),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: pickDropData?.orders[index]
                                            .pickupLocations.length ??
                                        0,
                                    itemBuilder: (context, j) {
                                      var item = pickDropData
                                          ?.orders[index].pickupLocations[j];
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              pickDropData?.orders[index].pickupLocations[j].itemStatus ==
                                                          null ||
                                                      pickDropData
                                                              ?.orders[index]
                                                              .pickupLocations[
                                                                  j]
                                                              .itemStatus ==
                                                          ""
                                                  ? const Text("Pickup",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                  : pickDropData
                                                              ?.orders[index]
                                                              .pickupLocations[
                                                                  j]
                                                              .itemStatus ==
                                                          "1"
                                                      ? const Text("Pickup",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))
                                                      : const Text("Pickup",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                              Container(
                                                height: 24,
                                                width: 24,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: colors.primary)),
                                                child: Center(
                                                  child: Text(
                                                    String.fromCharCode(65 + j),
                                                    style: const TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              const DotWidget(),
                                              /*const Text("Drop",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                            Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                  Border.all(color: colors.primary)),
                              child: const Center(
                                  child: Text("B",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold))),
                            ),
                            const DotWidget(),
                            const Text("Drop",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                            Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                  Border.all(color: colors.primary)),
                               child: const Center(
                                  child: Text("C",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                       ),
                                     ),
                                  ),*/
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // SizedBox(height: 12,),
                                              Row(
                                                children: [
                                                  item?.itemStatus == null ||
                                                          item?.itemStatus == ""
                                                      ? SizedBox(
                                                          width: 130,
                                                          child: Text(
                                                            item?.pickupLocation ??
                                                                '',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      : item?.itemStatus == "1"
                                                          ? SizedBox(
                                                              width: 130,
                                                              child: Text(
                                                                item?.pickupLocation ??
                                                                    '',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            )
                                                          : SizedBox(
                                                              width: 130,
                                                              child: Text(
                                                                item?.pickupLocation ??
                                                                    '',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .green),
                                                              ),
                                                            ),
                                                  const SizedBox(width: 20),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //     // Navigator.push(context, MaterialPageRoute(builder: (context) => PickDropOne()));
                                                  //   },
                                                  //   child: const Icon(
                                                  //     Icons.pin_drop_outlined,
                                                  //     color: Colors.red,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    }),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: pickDropData?.orders[index]
                                            .dropLocations.length ??
                                        0,
                                    itemBuilder: (context, k) {
                                      var item = pickDropData
                                          ?.orders[index].dropLocations[k];
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              pickDropData?.orders[index]
                                                                  .dropLocations[
                                                              k] ==
                                                          null ||
                                                      pickDropData
                                                                  ?.orders[index]
                                                                  .dropLocations[
                                                              k] ==
                                                          ""
                                                  ? Text(
                                                      "Drop",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : pickDropData?.orders[index]
                                                                  .dropLocations[
                                                              k] ==
                                                          "1"
                                                      ? const Text("Drop",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))
                                                      : Text(
                                                          "Drop",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                              Container(
                                                height: 24,
                                                width: 24,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: colors.primary)),
                                                child: Center(
                                                  child: Text(
                                                    String.fromCharCode(65 + k),
                                                    style: const TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              const DotWidget(),
                                              /*const Text("Drop",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                        Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                  Border.all(color: colors.primary)),
                              child: const Center(
                                  child: Text("C",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                  ),
                              ),
                        ),*/
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // SizedBox(height: 12,),
                                              Row(
                                                children: [
                                                  item?.itemStatus == null ||
                                                          item?.itemStatus == ""
                                                      ? SizedBox(
                                                          width: 130,
                                                          child: Text(
                                                            item?.dropLocation ??
                                                                '',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      : item?.itemStatus == "1"
                                                          ? SizedBox(
                                                              width: 130,
                                                              child: Text(
                                                                item?.dropLocation ??
                                                                    '',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            )
                                                          : SizedBox(
                                                              width: 130,
                                                              child: Text(
                                                                item?.dropLocation ??
                                                                    '',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //     // Navigator.push(context, MaterialPageRoute(builder: (context) => DropOne(address: item?.dropLocation, mobile: item?.dropNumber,orderID:item?.id )));
                                                  //   },
                                                  //   child: const Icon(
                                                  //     Icons.pin_drop_outlined,
                                                  //     color: Colors.red,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    }),
                                /*Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            const Text("Pick Up",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                  Border.all(color: colors.primary),
                              ),
                              child: const Center(
                                  child: Text("A",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                  ),
                              ),
                            ),
                            const DotWidget(),
                            const Text("Drop",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                            Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                  Border.all(color: colors.primary)),
                              child: const Center(
                                  child: Text("B",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold))),
                            ),
                            const DotWidget(),
                            const Text("Drop",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                            Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                  Border.all(color: colors.primary)),
                              child: const Center(
                                  child: Text("C",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height: 12,),
                            Row(
                              children: const [
                                Text(
                                  '372 Mclean Rd,\nMilner, GA, 30257',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.pin_drop_outlined,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.phone,
                                  color: Colors.red,
                                  size: 16,
                                ),
                                Text(
                                  "8760969005",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "12:30 PM",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                            Row(
                              children: const [
                                Text(
                                  '372 Mclean Rd,\nMilner, GA, 30257',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.pin_drop_outlined,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.phone,
                                  color: Colors.red,
                                  size: 16,
                                ),
                                Text(
                                  "8760969005",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "01:30 PM",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                            Row(
                              children: const [
                                Text(
                                  '372 Mclean Rd,\nMilner, GA, 30257',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.pin_drop_outlined,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.phone,
                                  color: Colors.red,
                                  size: 16,
                                ),
                                Text(
                                  "8760969005",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "02:30 PM",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            // showStatus();
                            print("neweeeeeee");
                            // showAlertDialog(context);
                          },
                          child: Container(
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                          ),
                        ),
                      ],
                    ),*/
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.primary,
        leading: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BottomNavBar()));
          },
          child: Icon(Icons.arrow_back_ios, color: colors.whiteTemp),
        ),
        foregroundColor: Colors.white,
        title: const Text('Pick & Drop'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            getPickDropOrdre(),
          ],
        ),
      ),
    );
  }
}

class DotWidget extends StatelessWidget {
  final double totalHeight, dashWidth, emptyHeight, dashHeight;

  final Color dashColor;

  const DotWidget({
    this.totalHeight = 42,
    this.dashWidth = 2,
    this.emptyHeight = 5,
    this.dashHeight = 10,
    this.dashColor = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        totalHeight ~/ (dashWidth + emptyHeight),
        (_) => Container(
          width: dashWidth,
          height: dashHeight,
          color: dashColor,
          margin:
              EdgeInsets.only(top: emptyHeight / 2, bottom: emptyHeight / 2),
        ),
      ),
    );
  }
}
