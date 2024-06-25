import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

import '../Helper/color.dart';
import '../Model/FaqModel.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  int selected = -1;
  FaqModel? faqs;
  Future<void> getFaqs() async {
    try {
      var headers = {
        'Cookie': 'ci_session=d71a907f3ec95431bc455a5b0429d06aadc021ee'
      };
      var request = http.MultipartRequest('POST',
          Uri.parse('https://developmentalphawizz.com/hojayega/Vendorapi/faq'));
      request.fields.addAll({'type': 'vendor'});
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print("hererrre");
        var finalResponse = await response.stream.bytesToString();
        final finalResult = FaqModel.fromJson(json.decode(finalResponse));
        setState(() {
          faqs = finalResult;
          print("faqssss ${faqs!.setting!.first.description}");
        });
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
    // TODO: implement initState
    super.initState();
    myFuture = getFaqs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      //
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: const Text(
          "FAQ",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        toolbarHeight: 70,
        elevation: 6,
      ),
      body: FutureBuilder(
          future: myFuture,
          builder: (context, snap) {
            return snap.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: colors.primary,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'FAQ',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return faqTileDetails(
                                question:
                                    faqs!.setting![index].title.toString(),
                                answer: faqs!.setting![index].description
                                    .toString(),
                                index: index);
                          },
                          itemCount: faqs!.setting!.length,
                        )
                      ],
                    ),
                  );
          }),
    ));
  }

  Widget faqTileDetails(
      {required String question, required String answer, required int index}) {
    return Column(
      children: [
        Card(
          elevation: 2,
          child: ListTile(
            onTap: () {
              setState(() {
                if (selected == index) {
                  selected = -1;
                } else {
                  selected = index;
                }
              });
            },
            title: Text(
              question,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(selected == index
                ? Icons.arrow_drop_down
                : Icons.arrow_drop_down),
          ),
        ),
        selected == index
            ? Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.grey.shade300,
                child: Html(data: answer),
              )
            : Container(),
      ],
    );
  }
}
