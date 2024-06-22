import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

import '../Helper/Color.dart';
import '../Model/PrivacyPolicyModel.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  PrivacyPolicyModel? privacy;
  Future<void> getPrivacyPolicy() async {
    try {
      // var headers = {
      //   'Cookie': 'ci_session=0a68526a3ce5b251a6761ec7c01fe4892118b57b'
      // };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://developmentalphawizz.com/hojayega/Vendorapi/static_pages'));

      // request.headers.addAll(headers);
      request.fields.addAll({'id': '4'});

      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        print(json);
        privacy = PrivacyPolicyModel.fromJson(json);
        print("privacy $json");
        setState(() {});
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  late Future myFuture;
  @override
  void initState() {
    super.initState();
    myFuture = getPrivacyPolicy(); // TODO: implement initState
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
          title: const Text('Privacy Policy'),
          backgroundColor: colors.primary),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: myFuture,
                builder: (context, snap) {
                  return snap.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            Html(data: privacy!.setting!.title.toString()),
                            Html(data: privacy!.setting!.html.toString()),
                          ],
                        );
                }),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
