import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hojayega_seller/Helper/api.path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Helper/color.dart';
import '../Model/ShopModel.dart';

class CreateOnlineStore extends StatefulWidget {
  const CreateOnlineStore({super.key});

  @override
  State<CreateOnlineStore> createState() => _CreateOnlineStoreState();
}

class _CreateOnlineStoreState extends State<CreateOnlineStore> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shopType();
  }

  ShopModel? shopModel;
  shopType() async {
    var headers = {
      'Cookie': 'ci_session=33ec14b9ed18ebb12220d713f637bbb770e99aaa'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.typeofShops));
    request.fields.addAll({
      'type': 'services'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = ShopModel.fromJson(json.decode(finalResponse));
      print("shop type responsee $finalResult");
      setState(() {
        shopModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    String _selectedOption = '1';
    var arNames = ['1', '2', '3', '4']; // Your items
    var data = [
      'Personal Information',
      'Address',
      'Account Details',
      'Upload Document',
    ];

    var data12 = [
      'BOOK STORE',
      'GROCERY STORE',
      'TOY SHOP',
      'VEGETABLE SHOP',
      'GIFT SHOP',
    ];

    int _len = 5;
    int selectedCheckboxIndex = -1; // To track the selected checkbox

    String _getTitle() {
      if (selectedCheckboxIndex == -1) {
        return "Checkbox Demo : None Selected";
      } else {
        return "Checkbox Demo : Item $selectedCheckboxIndex Selected";
      }
    }

    return Scaffold(
      backgroundColor: colors.appbarColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              "assets/images/otp verification – 3.png",
            ),
          ),
        ),
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Create Online Store",
                          style: TextStyle(
                              color: colors.lightWhite2,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        Text(
                          "Take a quick moment choosing your store category.\nThis helps us set up your store to match your products.",
                          style: TextStyle(color: colors.lightWhite2, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
              Card(
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            CircleAvatar(
                              child: Text('1',style: TextStyle(color: Colors.white,fontSize: 10),),
                                backgroundColor: colors.primary, maxRadius: 8

                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "What kind of Shop Do You Deal In ?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: colors.primary, fontSize: 15),
                            ),
                          ],
                        ),
                        const Text(
                          "You can select maximum 3 if you deal in multiple products in your shop",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: colors.primary,fontSize: 10),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 20,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal, // Horizontal scroll direction
                            itemCount: _len,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    onChanged: (bool? checked) {
                                      setState(() {
                                        if (checked != null && checked) {
                                          selectedCheckboxIndex = index;
                                        } else {
                                          selectedCheckboxIndex = -1;
                                        }
                                      });
                                    },
                                    value: selectedCheckboxIndex == index,
                                  ),
                                  Text(
                                   "${shopModel?.data?[index].name}",
                                    style: TextStyle(color: colors.secondary),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const [
                            CircleAvatar(
                                child: Text('2',style: TextStyle(color: Colors.white,fontSize: 10),),
                                backgroundColor: colors.primary, maxRadius: 8
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Select Category's",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: colors.primary, fontSize: 15),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 2, right: 2),
                          height: 400,
                          width: double.infinity,
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                                 // mainAxisExtent: 200
                            ),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        topLeft: Radius.circular(12),
                                    ),
                                    color: Colors.white),
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/dummy.png',),
                                    // const Text(
                                    //   'RB saloon',
                                    //   style: TextStyle(fontSize: 13),
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    //   children: const [
                                    //     Text(
                                    //       '2KM',
                                    //       style: TextStyle(fontSize: 13),
                                    //     ),
                                    //     Text(
                                    //       'open',
                                    //       style: TextStyle(fontSize: 13),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Center(
                          child: Card(
                            child: Container(
                              child: Center(child: Text('Next',style: TextStyle(color: Colors.white, ),),),
                              decoration: BoxDecoration(color: colors.secondary,
                                borderRadius:  BorderRadius.circular(5),
                              ),
                              //   width: MediaQuery.of(context),
                              // decoration: BoxDecoration(borderRadius: ),
                              height:MediaQuery.of(context).size.height *0.05,
                              width: MediaQuery.of(context).size.width *.6,
                               ),
                             ),
                           ),
                         ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}
