import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hojayega_seller/Helper/api.path.dart';
import 'package:hojayega_seller/Model/NotificationModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/color.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  initState() {
    super.initState();
    getNotification();
  }

  String? vendorId;

  NotificationModel? getNotiList;
  getNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    vendorId = prefs.getString("vendor_id");
    var headers = {
      'Cookie': 'ci_session=1826473be67eeb9329a8e5393f7907573d116ca1'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.notifications));
    request.fields.addAll({'user_id': vendorId.toString()});
    print("==========notification=====${request.fields}===========");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult =
          NotificationModel.fromJson(json.decode(finalResponse));
      setState(() {
        getNotiList = finalResult;
        setState(() {});
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  notificationClear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    vendorId = prefs.getString("vendor_id");
    var headers = {
      'Cookie': 'ci_session=1826473be67eeb9329a8e5393f7907573d116ca1'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiServicves.clearNotification));
    request.fields.addAll({'user_id': vendorId.toString()});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.pop(context);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              title: const Text('Notification'),
              backgroundColor: colors.primary),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 5, left: 25, right: 25, bottom: 20),
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      'Today',
                      style: TextStyle(
                          fontSize: 17,
                          color: colors.blackTemp,
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        notificationClear();
                      },
                      child: const Text(
                        'Clear All',
                        style: TextStyle(
                            fontSize: 17,
                            color: colors.blackTemp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                getNotiList?.responseCode == "0"
                    ? Container(
                        height: MediaQuery.of(context).size.height / 1.6,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: Text(
                            'Notification Not Found',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ListView.builder(
                          itemCount: getNotiList?.notifications?.length ?? 0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: colors.primary, width: 1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            "${index + 1}.  ${getNotiList?.notifications?[index].date ?? ""}",
                                            // "${getNotiList?.notifications?[index].dateSent.month ?? ""}-${getNotiList[index].dateSent.year ?? ""}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: colors.blackTemp,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      ListTile(
                                        title: Text(
                                          "${getNotiList?.notifications?[index].title ?? ""}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: colors.blackTemp,
                                              fontSize: 13),
                                        ),
                                        subtitle: Text(
                                          "${getNotiList?.notifications?[index].message ?? ""}",
                                          style: TextStyle(
                                              color: colors.black54,
                                              fontSize: 10),
                                        ),
                                        // trailing: CachedNetworkImage(
                                        //   imageUrl: "${getNotiList?.notifications?[index].}",
                                        //   errorWidget: (context, url, error) => Image.asset('assets/images/splash.png'),
                                        // ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ]),
            ),
          )),
    );
  }
}
