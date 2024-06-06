import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart'as http;
import '../Helper/Color.dart';
import '../Helper/api.path.dart';
import '../Model/PrivacyPolicy.dart';
import '../Model/TermsAndCondition.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {


  TermsAndCondition? terms;
  Future<void> getTermCondition() async {
    try {
      var headers = {
        'Cookie': 'ci_session=0a68526a3ce5b251a6761ec7c01fe4892118b57b'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://developmentalphawizz.com/hojayega/api/pages/static_pages'));

      request.headers.addAll(headers);
      request.fields.addAll({'id': '3'});

      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        print(json);
        terms = TermsAndCondition.fromJson(json);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  PrivacyPolicy? privacy;
  Future<void> getPrivacyPolicy() async {
    try {
      var headers = {
        'Cookie': 'ci_session=0a68526a3ce5b251a6761ec7c01fe4892118b57b'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://developmentalphawizz.com/hojayega/api/pages/static_pages'));

      request.headers.addAll(headers);
      request.fields.addAll({'id': '4'});

      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        print(json);
        privacy = PrivacyPolicy.fromJson(json);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  late Future myFuture;
  late Future myFutures;
  @override
  void initState() {
    myFuture = getTermCondition(); // TODO: implement initState
    myFutures = getPrivacyPolicy();
    super.initState();
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
          title: const Text('Setting'),
          backgroundColor: colors.primary),
        body: Column(
          children: [
            FutureBuilder(
              future: myFuture,
              builder: (context, snap) {
                return snap.connectionState == ConnectionState.waiting
                    ? const Center(
                  child: CircularProgressIndicator(),
                ): Column(
                  children: [
                    Html(data: terms!.setting!.title.toString()),
                    Html(data: terms!.setting!.html.toString()),
                  ],
                );
              }),
            SizedBox(height: 10,),
          ],
        ),
    );
  }
}
