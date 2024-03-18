import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/api.path.dart';
import '../Helper/color.dart';
import '../Model/TransactionModel.dart';
import 'package:http/http.dart' as http;

class BusinessCard extends StatefulWidget {

  final String walletAmount;
  const BusinessCard({Key? key, required this.walletAmount}) : super(key: key);

  @override
  State<BusinessCard> createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {
  @override
  void initState() {
    super.initState();
    super.initState();
    getData();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  String? vendorId;

  getData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    vendorId = preferences.getString('vendor_id');
    return walletTransactions();
  }

  Razorpay? _razorpay;
  int? pricerazorpayy;
  void openCheckout(amount) async {
    double res = double.parse(amount.toString());
    pricerazorpayy= int.parse(res.toStringAsFixed(0)) * 100;
    // Navigator.of(context).pop();
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': "$pricerazorpayy",
      'name': 'Hojayega',
      'image':'assets/images/Group 165.png',
      'description': 'Hojayega',
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  TextEditingController addMoneyCtr = TextEditingController();
  String? wallet_balance_added;
  var arrPrice=[500,1000,1500,2000];
  int addMoney=0;

  addWallet() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=b5700f932d8b03efe164db4d2f6eccb8c428fdfa'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.addAmount));
    request.fields.addAll({
      'user_id': vendorId.toString(),
      'amount': addMoneyCtr.text,
      'transaction_id': 'TXN1235455555',
      'user_type': '2'
    });
    print("add wallet amount ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonresponse = json.decode(finalResponse);
      if(jsonresponse["response_code"] == "1"){
        print("workinggg}");
        wallet_balance_added = jsonresponse["data"].toString();
        print("wallet balance is $wallet_balance_added");
        // if(wallet_balance_added != null){
          // await prefs.setString("business_card_wallet", wallet_balance_added!);
        // }
      } else {
        Fluttertoast.showToast(msg: jsonresponse["message"]);
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }


  TransactionModel? transactionModel;
  walletTransactions() async {
    var headers = {
      'Cookie': 'ci_session=e3825b4be6db7ecb421f2db35bd0a2ab2c91e923'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.walletTransaction));
    request.fields.addAll({
      'user_id': vendorId.toString(),
      'type': 'b_card',
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = TransactionModel.fromJson(json.decode(finalResponse));
      setState(() {
        transactionModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: "Payment successfully");
    addWallet();
    Navigator.pop(context);
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment cancelled by user");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          foregroundColor: colors.whiteTemp,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          title: const Text('Business'),
          backgroundColor: colors.primary),
          body: SingleChildScrollView(
            child: Column(
            children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width/1.2,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/images/homeblue.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20)
                     ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          const Text("Business Card Balance ", style: TextStyle(fontWeight: FontWeight.w600, color: colors.whiteTemp,fontSize: 19 ),),
                          const SizedBox(height: 10,),
                          // wallet_balance_added == null ? Text("₹ 500",
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.w600,
                          //         color: colors.whiteTemp,
                          //         fontSize: 23)):
                          Text("₹ ${widget.walletAmount}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: colors.whiteTemp,
                                  fontSize: 23)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: const [
            //     Text("Add Money"),
            //   ],
            // ),
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/3.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.whiteTemp,border: Border.all(color: colors.primary,width: 2)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: addMoneyCtr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Fill This Field';
                            }
                            return null;
                          },
                          // keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "Add Money",
                            hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            isDense: true,
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            focusedBorder: OutlineInputBorder(
                                borderRadius:BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.shade200)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),


                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Container(
                          height: 30,
                          child: ListView.builder(

                            scrollDirection:
                            Axis.horizontal,
                            // Set the direction to horizontal

                            itemCount: arrPrice.length,

                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: InkWell(
                                  onTap: (){
                                  //  print("11");
                                    addMoney=addMoney+arrPrice[index];
                                    setState(() {
                                      addMoneyCtr.text=addMoney.toString();

                                    });

                                  },
                                  child: Container(
                                    width:  60,

                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: colors.primary),
                                    child: Center(
                                      child: Text(
                                          arrPrice[index].toString(),
                                        style: TextStyle(color: colors.whiteTemp),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: () {
                          final form = _formkey.currentState!;
                          if (form.validate() && addMoneyCtr.text!= '0') {
                            form.save();
                            double amount = double.parse(addMoneyCtr.text.toString());
                            openCheckout((amount));
                          }
                        },
                        child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width/1.3,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                            child: const Center(child: Text("Add Money",
                              style: TextStyle(fontWeight: FontWeight.bold, color: colors.whiteTemp, fontSize: 19),
                             ),
                            ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text("Wallet Transaction", style: TextStyle(fontSize: 15, color: colors.blackTemp, fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              transactionModel?.responseCode == "0"
                  ? const Center(
                child: Text(
                  "No Transaction", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                ),
              ):
              ListView.builder(
                shrinkWrap: true,
                itemCount:  transactionModel?.data?.length ?? 0,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return listItem(index);
                },
              ),
        ],
      ),
          ),
    );
  }

  listItem(int index) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: colors.whiteTemp,
            border: Border.all(color: colors.primary, width: 2),
            borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
              decoration: const BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(13), topRight: Radius.circular(13))
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Date Created",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14, ), ),
                    Text('${transactionModel?.data?[index].createdAt}',  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14, ),),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Image.asset('assets/images/transactions.png', height: 50, width: 50,),
                  // SizedBox(width: 15,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/1.6,
                    child: Text(
                      "${transactionModel?.data?[index].userType}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: colors.black54, fontWeight: FontWeight.normal, fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "₹ ${transactionModel?.data?[index].amount}",
                    style: const TextStyle(color: colors.black54, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Container(
            //       margin: EdgeInsets.only(right: 8, bottom: 8),
            //       padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
            //       decoration: BoxDecoration(
            //         color: colors.black,
            //         borderRadius:  BorderRadius.all(
            //           const Radius.circular(4.0),
            //         ),
            //       ),
            //       child: walletTransactions[index].status == "1"
            //           ? Text("Completed",
            //         style: TextStyle(color: colors.white),
            //        )
            //           : Text(
            //         "Pending",
            //         style: TextStyle(color: colors.white),
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
