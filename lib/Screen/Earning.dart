import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hojayega_seller/Helper/api.path.dart';
import 'package:hojayega_seller/Helper/color.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/EarningsModel.dart';
import '../Model/TransactionModel.dart';

class Earning extends StatefulWidget {
  const Earning({Key? key}) : super(key: key);

  @override
  State<Earning> createState() => _EarningState();
}

class _EarningState extends State<Earning> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEarnings();
  }

  EarningsModel? earningData;
  getEarnings() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? vendorId = preferences.getString('vendor_id');
    var headers = {
      'Cookie': 'ci_session=8669ba7a011c91f49e6425fd6279035043aaccd5'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.vendorEarning));
    request.fields.addAll({
      'vendor_id': vendorId.toString(),
      'start_date': '2024-06-01',
      'end_date': '2024-06-05',
      'type': _selectedIndex == 0 ? "Earrning" : "Acc"
    });
    print("earningss para ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = EarningsModel.fromJson(json.decode(finalResponse));
      setState(() {
        earningData = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }


TextEditingController amtCtr = TextEditingController();

  amountRequest(String? amount) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? vendorId = preferences.getString('vendor_id');
    var headers = {
      'Cookie': 'ci_session=33c3240e9634316144a84aab4a17112c99db3031'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.requestForSettlement));
    request.fields.addAll({
      'type': '1',
      'amount': amount.toString(),
      'user_id': vendorId.toString()
    });
    print("amount request is ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonresponse = json.decode(finalResponse);
      if(jsonresponse["response_code"] == "0") {
        Fluttertoast.showToast(msg: jsonresponse["message"]);
      } else {
        Fluttertoast.showToast(msg: jsonresponse["message"]);
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  void _showInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Amount'),
          content: TextField(
            controller: amtCtr,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintText: 'Amount Here',
            ),
            maxLines: 3,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                if(amtCtr.text.isEmpty){
                  Fluttertoast.showToast(msg: "Please Enter Amount");
                }
                else {
                  amountRequest(amtCtr.text);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  int selected = 0;
  String? date1;
  String? date2;
  bool showDate = true;
  int _selectedIndex = 0;
  final List<Map<String, String>> _daysOfWeek = [
    {'day': '12', 'label': 'Thu'},
    {'day': '13', 'label': 'Fri'},
    {'day': '14', 'label': 'Sat'},
    {'day': '15', 'label': 'Sun'},
    {'day': '16', 'label': 'Mon'},
    {'day': '17', 'label': 'Tue'},
    {'day': '18', 'label': 'Wed'},
  ];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = _dateFormat.format(picked);
      });
    }
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }


  DateTime initialDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE2EBFE),
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          title: const Text('Earnings'),
          backgroundColor: colors.primary),
      body: Column(
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
                        getEarnings();
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
                            'Earnings',
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
                        getEarnings();
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
                            'Acc Summary',
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
          selected == 0
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), ),
                                child: TextFormField(
                                  controller: _startDateController,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.calendar_today),
                                    labelText: "Select Start Date",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  readOnly: true,
                                  onTap: () {
                                    _selectDate(context, _startDateController);
                                  },
                                ),
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: _endDateController,
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.calendar_today),
                                  labelText: "Select End Date",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                readOnly: true,
                                onTap: () {
                                  _selectDate(context, _endDateController);
                                },
                              ),
                              SizedBox(height: 20.0),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                  }
                                },
                                child: Text('Submit'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //     top: 0,
                      //     left: 13,
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       const Text(
                      //         'Date:',
                      //         style: TextStyle(
                      //             color: colors.primary,
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 24),
                      //       ),
                      //       const SizedBox(
                      //         width: 10,
                      //       ),
                      //       Text(
                      //         date1 ?? " Select date",
                      //         style: const TextStyle(
                      //             color: colors.primary,
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 16),
                      //       ),
                      //       Text(
                      //         date2 != null ? " to $date2 " : " to Select date",
                      //         style: const TextStyle(
                      //             color: colors.primary,
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 16),
                      //       ),
                      //       showDate
                      //           ? IconButton(
                      //               onPressed: () async {
                      //                 DateTime? selectedDate1 =
                      //                     await showDatePicker(
                      //                         context: context,
                      //                         initialDate: DateTime.now(),
                      //                         firstDate: DateTime.now(),
                      //                         lastDate: DateTime(2023, 12, 31));
                      //                 if (selectedDate1 != null) {
                      //                   setState(() {
                      //                     initialDate = selectedDate1.add(const Duration(days: 1));
                      //                     date1 = "${selectedDate1.day}/${selectedDate1.month}/${selectedDate1.year}";
                      //                     showDate = false;
                      //                   });
                      //                 }
                      //               },
                      //               icon: const Icon(
                      //                 Icons.calendar_month_outlined,
                      //                 color: colors.primary,
                      //               ))
                      //           : IconButton(
                      //               onPressed: () async {
                      //                 DateTime? selectedDate =
                      //                     await showDatePicker(
                      //                         context: context,
                      //                         initialDate: initialDate,
                      //                         firstDate: initialDate,
                      //                         lastDate: DateTime(2023, 12, 31));
                      //                 if (selectedDate != null) {
                      //                   setState(() {
                      //                     date2 =
                      //                         "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                      //                     showDate = true;
                      //                   });
                      //                 }
                      //               },
                      //               icon: const Icon(
                      //                 Icons.calendar_month_outlined,
                      //                 color: colors.primary,
                      //               ),
                      //             ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10),
                      //   child: Container(
                      //     height: 65,
                      //     // color: Colors.blue[50],
                      //     // padding: EdgeInsets.symmetric(vertical: 10.0),
                      //     child: ListView.builder(
                      //       scrollDirection: Axis.horizontal,
                      //       itemCount: _daysOfWeek.length,
                      //       itemBuilder: (context, index) {
                      //         final day = _daysOfWeek[index];
                      //         final bool isSelected = index == _selectedIndex;
                      //         return GestureDetector(
                      //           onTap: () {
                      //             setState(() {
                      //               _selectedIndex = index;
                      //             });
                      //           },
                      //           child: Container(
                      //             margin: EdgeInsets.symmetric(horizontal: 5.0),
                      //             padding: EdgeInsets.symmetric(
                      //                 vertical: 10.0, horizontal: 15.0),
                      //             decoration: BoxDecoration(
                      //               color: isSelected ? Colors.green : Colors.white,
                      //               borderRadius: BorderRadius.circular(20.0),
                      //             ),
                      //             child: Column(
                      //               mainAxisSize: MainAxisSize.min,
                      //               children: [
                      //                 Text(
                      //                   day['day']!,
                      //                   style: TextStyle(
                      //                     color: isSelected
                      //                         ? Colors.white
                      //                         : Colors.black,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                 ),
                      //                 SizedBox(height: 5),
                      //                 Text(
                      //                   day['label']!,
                      //                   style: TextStyle(
                      //                     color: isSelected
                      //                         ? Colors.white
                      //                         : Colors.black,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),
                      earningData?.products?.length == null || earningData?.products?.length == ""
                          ? const Center(
                        child: Text("Data Not Found", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
                      ):
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: earningData?.products?.length?? 0,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Card(
                                margin: EdgeInsets.all(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      earningData?.products?[index].productImage == null || earningData?.products?[index].productImage == "" ?
                                      const CircleAvatar(
                                        backgroundImage: NetworkImage("assets/images/placeholder.png",),
                                        radius: 30,
                                      ):
                                      CircleAvatar(
                                        backgroundImage: NetworkImage("${ApiServicves.imageUrl}${earningData?.products?[index].productImage}"),
                                        radius: 30,
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Order No. - ${earningData?.products?[index].orderId}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "${earningData?.products?[index].paymentMode}",
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text("${earningData?.products?[index].createdAt}"),
                                        ],
                                      ),
                                      Spacer(),
                                      Text(
                                        '+${"${earningData?.products?[index].amount}"}',
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 150,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF112c48),
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2,
                                            offset: Offset(0, 1))
                                      ]),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Total Earning',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '₹ ${earningData?.totalEarning}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 150,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF112c48),
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow:  const [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2,
                                            offset: Offset(0, 1))
                                      ]),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'COD',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '₹ ${earningData?.cod}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            InkWell(
                              onTap: () {
                                _showInputDialog(context);
                              },
                              child: Container(
                                height: 50,
                                width: 150,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF112c48),
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 2,
                                          offset: Offset(0, 1),
                                      ),
                                    ]),
                                child: const Center(
                                  child: Text(
                                    'Request For COD\n       Amount',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ): Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                  left: 13,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      child: TextFormField(
                        controller: _startDateController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          labelText: "Start Date",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        readOnly: true,
                        onTap: () {
                          _selectDate(context, _startDateController);
                        },
                      ),
                    ),
                    // const Text(
                    //   'Date:',
                    //   style: TextStyle(
                    //       color: colors.primary,
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 24),
                    // ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    // Text(
                    //   date1 ?? " Select date",
                    //   style: const TextStyle(
                    //       color: colors.primary,
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 16),
                    // ),
                    // Text(
                    //   date2 != null ? " to $date2 " : " to Select date",
                    //   style: const TextStyle(
                    //       color: colors.primary,
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 16),
                    // ),
                    // showDate
                    //     ? IconButton(
                    //     onPressed: () async {
                    //       DateTime? selectedDate1 =
                    //       await showDatePicker(
                    //           context: context,
                    //           initialDate: DateTime.now(),
                    //           firstDate: DateTime.now(),
                    //           lastDate: DateTime(2023, 12, 31));
                    //       if (selectedDate1 != null) {
                    //         setState(() {
                    //           initialDate = selectedDate1.add(const Duration(days: 1));
                    //           date1 = "${selectedDate1.day}/${selectedDate1.month}/${selectedDate1.year}";
                    //           showDate = false;
                    //         });
                    //       }
                    //     },
                    //     icon: const Icon(
                    //       Icons.calendar_month_outlined,
                    //       color: colors.primary,
                    //     ))
                    //     : IconButton(
                    //   onPressed: () async {
                    //     DateTime? selectedDate =
                    //     await showDatePicker(
                    //         context: context,
                    //         initialDate: initialDate,
                    //         firstDate: initialDate,
                    //         lastDate: DateTime(2023, 12, 31));
                    //     if (selectedDate != null) {
                    //       setState(() {
                    //         date2 =
                    //         "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                    //         showDate = true;
                    //       });
                    //     }
                    //   },
                    //   icon: const Icon(
                    //     Icons.calendar_month_outlined,
                    //     color: colors.primary,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  height: 65,
                  // color: Colors.blue[50],
                  // padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _daysOfWeek.length,
                    itemBuilder: (context, index) {
                      final day = _daysOfWeek[index];
                      final bool isSelected = index == _selectedIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.green : Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                day['day']!,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                day['label']!,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              earningData?.products?.length == null || earningData?.products?.length == ""
                  ? const Center(
                child: Text("Data Not Found", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
              ):
              ListView.builder(
                shrinkWrap: true,
                itemCount: earningData?.products?.length?? 0,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              earningData?.products?[index].productImage == null || earningData?.products?[index].productImage == "" ?
                              const CircleAvatar(
                                backgroundImage: NetworkImage("assets/images/placeholder.png",),
                                radius: 30,
                              ):
                              CircleAvatar(
                                backgroundImage: NetworkImage("${ApiServicves.imageUrl}${earningData?.products?[index].productImage}"),
                                radius: 30,
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order No. - ${earningData?.products?[index].orderId}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${earningData?.products?[index].paymentMode}",
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("${earningData?.products?[index].createdAt}"),
                                ],
                              ),
                              Spacer(),
                              Text(
                                '+${"${earningData?.products?[index].amount}"}',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
