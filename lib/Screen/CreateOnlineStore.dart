import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hojayega_seller/Helper/api.path.dart';
import 'package:hojayega_seller/Screen/createPortfolio.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
    getData();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {});
      shopType();
      getCat();
    });
  }

  String? roll_id;
  getData() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
     roll_id = preferences.getString('roll');
     print("===============$roll_id===========");
  }
  ShopModel? shopModel;
  List checkboxlist = [];
  shopType() async {
    var headers = {
      'Cookie': 'ci_session=33ec14b9ed18ebb12220d713f637bbb770e99aaa'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.typeofShops));
    request.fields.addAll({'type': 'shop'});
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
    request.fields.addAll({'roll': roll_id.toString()});
      print("=========roll in get category======${request.fields}===========");
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
  List<bool> selectedItems = List.generate(15, (index) => false);

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
                const SizedBox(
                  height: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                                  child: Text('1', style: TextStyle(color: Colors.white, fontSize: 10)),
                                  backgroundColor: colors.primary, maxRadius: 8),
                              SizedBox(width: 5),
                              Text("What kind of Shop Do You Deal In ?",
                                style: TextStyle(fontWeight: FontWeight.bold, color: colors.primary, fontSize: 15),
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
                              ? const Center(
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
                                  backgroundColor: colors.primary,
                                  maxRadius: 8,
                                  child: Text(
                                    '2',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                              ),
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
                          categoryModel?.data?.length == null || categoryModel?.data?.length == ""
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: colors.primary,
                                ),
                          ):
                          // Container(
                          //         margin:
                          //             const EdgeInsets.only(left: 2, right: 2),
                          //         height: 400,
                          //         width: double.infinity,
                          //         child: GridView.builder(
                          //           gridDelegate:
                          //               const SliverGridDelegateWithFixedCrossAxisCount(
                          //                   crossAxisCount: 3,
                          //                   crossAxisSpacing: 5,
                          //                   mainAxisSpacing: 5,
                          //                   childAspectRatio: 2 / 2.6
                          //                   // mainAxisExtent: 200
                          //                   ),
                          //           itemCount: categoryModel?.data?.length ?? 0,
                          //           itemBuilder: (context, index) {
                          //             return InkWell(
                          //               onTap: () {
                          //                 setState(() {
                          //                   selectCategories = categoryModel
                          //                       ?.data?[index].id
                          //                       .toString();
                          //                   print(
                          //                       "${selectCategories == categoryModel?.data?[index].id.toString()}__________");
                          //                 });
                          //               },
                          //               child: Column(
                          //                 children: [
                          //                   Stack(
                          //                     children: [
                          //                       Container(
                          //                         height: 90,
                          //                         decoration: BoxDecoration(
                          //                             borderRadius:
                          //                                 BorderRadius.circular(
                          //                                     2),
                          //                             border: Border.all(),
                          //                             color: Colors.white),
                          //                         child: Column(
                          //                           children: [
                          //                             Image.network(
                          //                               'https://developmentalphawizz.com/hojayega/${categoryModel?.data?[index].img}',
                          //                               fit: BoxFit.fill,
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       if (selectCategories == categoryModel?.data?[index].id.toString())
                          //                         Positioned(
                          //                           top: 6,
                          //                           left: 6,
                          //                           child: Container(
                          //                             //width: MediaQuery.of(context).size.width,
                          //                             width: 20,
                          //                             height: 20,
                          //                             decoration:
                          //                                 const BoxDecoration(
                          //                               shape: BoxShape.circle,
                          //                               color: colors.secondary,
                          //                             ),
                          //                             child: const Center(
                          //                               child: Padding(
                          //                                 padding:
                          //                                     EdgeInsets.all(2),
                          //                                 child: Icon(
                          //                                   Icons.check,
                          //                                   color: Colors.white,
                          //                                   size: 15,
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         )
                          //                       else
                          //                         const SizedBox(),
                          //                     ],
                          //                   ),
                          //                   const SizedBox(height: 7),
                          //                   Text(
                          //                     '${categoryModel?.data?[index].cName}',
                          //                     style:
                          //                         const TextStyle(fontSize: 13),
                          //                   ),
                          //                 ],
                          //               ),
                          //             );
                          //           },
                          //         ),
                          //       ),
                          Container(
                              margin: const EdgeInsets.only(left: 2, right: 2),
                              width: double.infinity, // adjust width if needed
                              height: 400, // adjust height if needed
                              child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 3,
                                    childAspectRatio: 2 / 2.4
                                ),
                                itemCount: categoryModel!.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    alignment: Alignment.topLeft,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedItems[index] = !selectedItems[index];
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            categoryModel!.data![index].img == "" || categoryModel!.data![index].img == null ?Container(
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                                                child: Image.asset("assets/images/placeholder.png")
                                            ):
                                            Container(
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                                                child: Image.network("https://developmentalphawizz.com/hojayega/${categoryModel!.data![index].img.toString()}")
                                            ),
                                            Text(categoryModel!.data![index].cName.toString(),)
                                          ],
                                        ),
                                      ),
                                      if (selectedItems[index])
                                        Container(
                                          margin: const EdgeInsets.all(10),
                                          //  padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: colors.secondary,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              )
                          ),
                         roll_id == 2 ?
                         Column(
                           children: [
                             Row(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: const [
                                 CircleAvatar(
                                   backgroundColor: colors.primary,
                                   maxRadius: 8,
                                   child: Text(
                                     '5',
                                     style: TextStyle(
                                         color: Colors.white, fontSize: 10),
                                   ),
                                 ),
                                 SizedBox(
                                   width: 5,
                                 ),
                                 Text(
                                   "How Many Clients You Can Server At Same \nTime?",
                                   style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       color: colors.primary),
                                 ),
                               ],
                             ),
                             const SizedBox(height: 10,),
                             Container(
                               decoration: BoxDecoration(border: Border.all(color: colors.primary),borderRadius: BorderRadius.circular(10)),
                               child: TextFormField(
                                 validator: (value) {
                                   if (value == null || value.isEmpty) {
                                     return 'Required Details';
                                   }
                                   return null;
                                 },
                                 decoration: const InputDecoration(
                                   border: InputBorder.none,
                                 ),
                               ),
                             ),
                             SizedBox(height: 8,),
                             Row(
                               children: const [
                                 CircleAvatar(
                                   child: Text(
                                     '3',
                                     style: TextStyle(
                                         color: Colors.white, fontSize: 10),
                                   ),
                                   backgroundColor: colors.primary,
                                   maxRadius: 8,
                                 ),
                                 SizedBox(
                                   width: 5,
                                 ),
                                 Text(
                                   "Working Hours?",
                                   style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       color: colors.primary),
                                 ),
                                 SizedBox(width: 30 ),
                                 CircleAvatar(
                                   child: Text(
                                     '4',
                                     style: TextStyle(
                                         color: Colors.white, fontSize: 10),
                                   ),
                                   backgroundColor: colors.primary,
                                   maxRadius: 8,
                                 ),
                                 SizedBox(
                                   width: 5,
                                 ),
                                 Text(
                                   "Working Days?",
                                   style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       color: colors.primary),
                                 ),
                               ],
                             ),
                             SizedBox(height: 5,),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Container(
                                   width: MediaQuery.of(context).size.width * .41,
                                   decoration: BoxDecoration(border: Border.all(color: colors.primary),borderRadius: BorderRadius.circular(10)),
                                   child: TextFormField(
                                     validator: (value) {
                                       if (value == null || value.isEmpty) {
                                         return 'Enter working Hours';
                                       }
                                       return null;
                                     },
                                     decoration: InputDecoration(
                                       border: InputBorder.none,
                                     ),
                                   ),
                                 ),
                                 Container(
                                   width: MediaQuery.of(context).size.width * .41,
                                   decoration: BoxDecoration(border: Border.all(color: colors.primary),borderRadius: BorderRadius.circular(10)),
                                   child: TextFormField(
                                     validator: (value) {
                                       if (value == null || value.isEmpty) {
                                         return 'Enter  Working Days';
                                       }
                                       return null;
                                     },
                                     decoration: InputDecoration(
                                       border: InputBorder.none,
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                             SizedBox(height: 6,),
                             Row(
                               children: const [
                                 CircleAvatar(
                                   backgroundColor: colors.primary,
                                   maxRadius: 8,
                                   child: Text(
                                     '6',
                                     style: TextStyle(
                                         color: Colors.white, fontSize: 10),
                                   ),
                                 ),
                                 SizedBox(
                                   width: 5,
                                 ),
                                 Text(
                                   "Your Visiting Charges?",
                                   style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       color: colors.primary),
                                 ),
                               ],
                             ),
                             const Padding(
                               padding: EdgeInsets.only(left: 20),
                               child: Text(
                                 "Keep charges between 20rs to 100rs",
                                 style: TextStyle(
                                     color: colors.primary),
                               ),
                             ),
                             SizedBox(height: 10,),
                             Container(
                               //width: MediaQuery.of(context).size.width * .41,
                               decoration: BoxDecoration(border: Border.all(color: colors.primary),borderRadius: BorderRadius.circular(10)),
                               child: TextFormField(
                                 validator: (value) {
                                   if (value == null || value.isEmpty) {
                                     return 'Enter  Your Visting Charges';
                                   }
                                   return null;
                                 },
                                 decoration: const InputDecoration(
                                   border: InputBorder.none,
                                 ),
                               ),
                             ),
                           ],
                         ): SizedBox.shrink(),
                          SizedBox(height: 20,),
                          InkWell(
                            onTap: () {
                              if(roll_id == 1) {
                              //  print(getData());
                                Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (context) => AllCategory(),
                                ),
                                );
                              } else {
                                print(getData());
                                Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (context) => const CreatePortfolio(),
                                ),
                                );
                              }
                            },
                            child: Center(
                              child: Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: colors.secondary,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  //   width: MediaQuery.of(context),
                                  // decoration: BoxDecoration(borderRadius: ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  width: MediaQuery.of(context).size.width * .6,
                                  child: const Center(
                                    child: Text(
                                      'Next',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
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
