import 'dart:convert';
import 'dart:ui';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Helper/Color.dart';
import '../Helper/api.path.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    help();
  }

  String? mobile, email;

  help() async {
    var headers = {
      'Cookie': 'ci_session=5a5b2b2a84ead5a12c749f202a5770f3abd6d11b'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getHelp));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonresponse = json.decode(finalResponse);
      if (jsonresponse["response_code"] == "1") {
        print("workinggg}");
        email = jsonresponse["data"][0]['email'].toString();
        mobile = jsonresponse["data"][0]['contact_no'].toString();
        print("help mobile and email $mobile email $email");
        setState(() {});
      } else {
        // Fluttertoast.showToast(msg: jsonresponse["message"]);
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  _callNumber(String? mobileNumber) async {
    var number = "$mobileNumber";
    print("numberrrrr $number");
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    print("mobileee $res");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: AppBar(
          foregroundColor: colors.whiteTemp,
          elevation: 0,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          title: const Text('Help'),
          backgroundColor: colors.primary),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: colors.whiteTemp,
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox.square(
                    dimension:
                    MediaQuery.of(context).size.height * .15,
                    child:
                    Image.asset("assets/images/contact.png")),
                const Text(
                  "How can we help you?",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "It looks like you have a problem with our systems. We are here to help you, so please get in touch with us.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              launchUrl(
                  Uri.parse('mailto:$email'));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 12,
                        offset: Offset(0, 3),
                        color: Colors.black.withOpacity(.05))
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(
                    Icons.mail_rounded,
                    color: colors.primary,
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Email",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              _callNumber(mobile.toString());
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 12,
                        offset: Offset(0, 3),
                        color: Colors.black.withOpacity(.05))
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(
                    Icons.phone,
                    color: colors.primary,
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Call Us",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
//                       const SizedBox(height: 30),
//                       GestureDetector(
//                         onTap: () async {
// // var whatsapp = "+919926202390";
//                           var whatsappURl_android = "whatsapp://send?phone=" +
//                               '+91${data!.data.first.whatsappNo}' +
//                               "&text=${"Pricedot"}";
//                           await launch(whatsappURl_android);
// // if (await canLaunch(whatsappURl_android)) {
//                         },
//                         child: Container(
//                           margin: EdgeInsets.symmetric(horizontal: 10),
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               boxShadow: [
//                                 BoxShadow(
//                                     blurRadius: 12,
//                                     offset: Offset(0, 3),
//                                     color: Colors.black.withOpacity(.05))
//                               ],
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(7)),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               ImageIcon(
//                                 AssetImage("assets/icons/whatsapp.png"),
//                                 size: 25,
//                                 color: AppColors.primary,
//                               ),
//                               SizedBox(width: 15),
//                               Text(
//                                 "Connect On Whatsapp".tr,
//                                 style: TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.bold),
//                               ),
//                               Spacer(),
//                               Icon(
//                                 Icons.arrow_forward_ios_rounded,
//                                 size: 15,
//                                 color: Colors.grey,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Spacer(),
//                       Container(
//                         padding: const EdgeInsets.all(8),
// // margin: const EdgeInsets.symmetric(horizontal: 60),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(7),
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.grey.shade300,
//                                   offset: Offset(1, 1),
//                                   blurRadius: 5),
//                             ]),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 launchUrl(
//                                     Uri.parse('${data!.data.first.instagram}'));
//                               },
//                               child: Column(
//                                 children: [
//                                   ImageIcon(
//                                     AssetImage('assets/icons/instagram.png'),
//                                     size: 20,
//                                     color: AppColors.primary,
//                                   ),
//                                   Text(
//                                     'Instagram',
//                                     style: TextStyle(fontSize: 10),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 launchUrl(
//                                     Uri.parse('${data!.data.first.facebook}'));
//                               },
//                               child: Column(
//                                 children: [
//                                   ImageIcon(
//                                     AssetImage('assets/icons/facebook.png'),
//                                     size: 20,
//                                     color: AppColors.primary,
//                                   ),
//                                   Text(
//                                     'Facebook',
//                                     style: TextStyle(fontSize: 10),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 launchUrl(
//                                     Uri.parse('${data!.data.first.twitter}'));
//                               },
//                               child: Column(
//                                 children: [
//                                   ImageIcon(
//                                     AssetImage('assets/icons/twitter.png'),
//                                     size: 20,
//                                     color: AppColors.primary,
//                                   ),
//                                   Text(
//                                     'Twitter',
//                                     style: TextStyle(fontSize: 10),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
        ],
      ),
    );
  }
}
