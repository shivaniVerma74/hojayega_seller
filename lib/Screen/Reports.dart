import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Helper/Color.dart';
import '../Helper/api.path.dart';
import '../Model/EarningsModel.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  EarningsModel? earningData;
  getEarnings(String? type,) async {
    print("object Tis ${_startDateController.text.toString()}");
    print("object Tis ${_startAccDateController.text.toString()}");
    print("object Tis ${_endDateController.text.toString()}");
    print("object Tis ${_endDateAccController.text.toString()}");
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? vendorId = preferences.getString('vendor_id');
    var headers = {
      'Cookie': 'ci_session=8669ba7a011c91f49e6425fd6279035043aaccd5'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiServicves.vendorEarning));
    request.fields.addAll({
      'vendor_id':vendorId.toString(),
      'start_date':_startAccDateController.text.toString(),
      'end_date':_endDateAccController.text.toString(),
      'type': type.toString()
    });
    print("earningss para ${request.fields} $selected");
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

  final TextEditingController _startAccDateController = TextEditingController();
  final TextEditingController _endDateAccController = TextEditingController();

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
        _startDateController.text = _dateFormat.format(picked);
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _endDateController.text = _dateFormat.format(picked);
      });
    }
    getEarnings("Earrning");
  }


  Future<void> _selectAccDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _startAccDateController.text = _dateFormat.format(picked);
      });
    }
  }

  Future<void> _selectAccEndDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _endDateAccController.text = _dateFormat.format(picked);
      });
    }
    getEarnings("Acc");
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

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
          title: const Text('Reports'),
          backgroundColor: colors.primary),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 5,
                        child: TextFormField(
                          controller: _startAccDateController,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "Select Start Date",
                            isDense: true,
                            filled: true,
                            fillColor: Colors.grey.shade100 ,
                            suffixIcon: InkWell(
                                onTap: () {
                                  _selectAccDate(context, _startAccDateController);
                                },
                                child: const Icon(Icons.calendar_month, color: colors.primary)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.shade100)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.shade100)
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        elevation: 5,
                        child: TextFormField(
                          controller: _endDateAccController,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "Select End Date",
                            isDense: true,
                            filled: true,
                            fillColor: Colors.grey.shade100 ,
                            suffixIcon: InkWell(
                              onTap: () async {
                                _selectAccEndDate(context, _endDateAccController);
                                // await getEarnings("Acc");
                              },
                              child: const Icon(Icons.calendar_month, color: colors.primary),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.shade100)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.shade100)
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
                earningData?.status == "0" || (earningData?.products!.isEmpty) == false
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
                                const SizedBox(width: 10),
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
                                const Spacer(),
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
      ),
    );
  }
}
