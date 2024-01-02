import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hojayega_seller/Helper/api.path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Helper/color.dart';
import '../Model/CategoryModel.dart';
import '../Model/ShopModel.dart';
import 'AllCategory.dart';

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
    getCat();
  }

  ShopModel? shopModel;
  List checkboxlist = [];
  shopType() async {
    var headers = {
      'Cookie': 'ci_session=33ec14b9ed18ebb12220d713f637bbb770e99aaa'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.typeofShops));
    request.fields.addAll({'type': 'services'});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    checkboxlist.clear();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = ShopModel.fromJson(json.decode(finalResponse));

      print("shop type responsee $finalResult");

      if (finalResult.data?.isNotEmpty ?? false) {
        for (int i = 0; i < finalResult.data!.length; i++) {
          checkboxlist.add(false);
        }
      }
      setState(() {
        shopModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  String? selectCategories = "0";

  CategoryModel? categoryModel;
  getCat() async {
    var headers = {
      'Cookie': 'ci_session=2af0bd20724524e1ebfba0e830885dbff718f536'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getCategories));
    request.fields.addAll({'roll': '2'});

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = CategoryModel.fromJson(json.decode(finalResponse));
      print("categoryyyy responsee $finalResult");
      setState(() {
        categoryModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool selectedCheckboxIndex = false; // To track the selected checkbox
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
                        style:
                            TextStyle(color: colors.lightWhite2, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
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
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                  backgroundColor: colors.primary,
                                  maxRadius: 8),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "What kind of Shop Do You Deal In ?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: colors.primary,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          const Text(
                            "You can select maximum 3 if you deal in multiple products in your shop",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colors.primary,
                                fontSize: 10),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          shopModel?.data?.length == null ||
                                  shopModel?.data?.length == ""
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: colors.primary,
                                ))
                              : Container(
                                  height: 20,
                                  child: ListView.builder(
                                    scrollDirection: Axis
                                        .horizontal, // Horizontal scroll direction
                                    itemCount: shopModel?.data?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Checkbox(
                                            activeColor: colors.secondary,
                                            onChanged: (checked) {
                                              checkboxlist[index] = checked;
                                              setState(() {});
                                              //  print("jjcjcjjf");
                                              // // print("${checked}");
                                              //  setState(() {
                                              //    if ( checked==true) {
                                              //      print(checked);
                                              //      print(index);
                                              //      selectedCheckboxIndex = checked??false;
                                              //    } else {
                                              //      selectedCheckboxIndex = false;
                                              //    }
                                              //  });
                                              //  print(selectedCheckboxIndex);
                                            },
                                            checkColor: colors.primary,
                                            value: checkboxlist[index],
                                          ),
                                          Text(
                                            "${shopModel?.data?[index].name.toString()}",
                                            style: const TextStyle(
                                                color: colors.primary,
                                                fontWeight: FontWeight.w600),
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
                                  child: Text(
                                    '2',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                  backgroundColor: colors.primary,
                                  maxRadius: 8),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Select Category's",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: colors.primary,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          categoryModel?.data?.length == null ||
                                  categoryModel?.data?.length == ""
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: colors.primary,
                                ))
                              : Container(
                                  margin:
                                      const EdgeInsets.only(left: 2, right: 2),
                                  height: 400,
                                  width: double.infinity,
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 5,
                                            childAspectRatio: 2 / 2.6
                                            // mainAxisExtent: 200
                                            ),
                                    itemCount: categoryModel?.data?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectCategories = categoryModel
                                                ?.data?[index].id
                                                .toString();
                                            print(
                                                "${selectCategories == categoryModel?.data?[index].id.toString()}__________");
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2),
                                                      border: Border.all(),
                                                      color: Colors.white),
                                                  child: Column(
                                                    children: [
                                                      Image.network(
                                                        '${ApiServicves.imageUrl}${categoryModel?.data?[index].img}',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (selectCategories ==
                                                    categoryModel?.data?[index].id.toString())
                                                  Positioned(
                                                    top: 6,
                                                    left: 6,
                                                    child: Container(
                                                      //width: MediaQuery.of(context).size.width,
                                                      width: 20,
                                                      height: 20,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: colors.secondary,
                                                      ),
                                                      child: const Center(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: Icon(
                                                            Icons.check,
                                                            color: Colors.white,
                                                            size: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                else
                                                  const SizedBox(),
                                              ],
                                            ),
                                            const SizedBox(height: 7),
                                            Text(
                                              '${categoryModel?.data?[index].cName}',
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context, MaterialPageRoute(
                                  builder: (context) => AllCategory(),
                                ),
                              );
                            },
                            child: Center(
                              child: Card(
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      'Next',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: colors.secondary,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  //   width: MediaQuery.of(context),
                                  // decoration: BoxDecoration(borderRadius: ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width: MediaQuery.of(context).size.width * .6,
                                ),
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
