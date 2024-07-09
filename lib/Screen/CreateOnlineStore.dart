import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hojayega_seller/Helper/api.path.dart';
import 'package:hojayega_seller/Screen/createPortfolio.dart';
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

String? parentId;

class _CreateOnlineStoreState extends State<CreateOnlineStore> {
  final TextEditingController clientsServesController = TextEditingController();
  final TextEditingController workingHoursController = TextEditingController();
  final TextEditingController workingDaysController = TextEditingController();
  final TextEditingController visitingChargesController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    // shopType();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {});
    });
  }

  String? roll_id;
  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    roll_id = preferences.getString('roll');
    print("===========hhh====$roll_id===========");
    await shopType();
    await getCat(shopModel?.data?[selectedIndex].id.toString() ?? "0");
  }

  ShopModel? shopModel;
  List checkboxlist = [];
  int selectedIndex = 0;
  List categoriesSelectedValues = [];
  List categoriesIdSelected = [];

  shopType() async {
    var headers = {
      'Cookie': 'ci_session=33ec14b9ed18ebb12220d713f637bbb770e99aaa'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.typeofShops));
    request.fields.addAll({'type': roll_id == "1" ? 'shop' : 'services'});
    print("shop type parar ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    checkboxlist.clear();
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

  String? selectCategories = "0";

  CategoryModel? categoryModel;
  getCat(String id) async {
    var headers = {
      'Cookie': 'ci_session=2af0bd20724524e1ebfba0e830885dbff718f536'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getCategories));
    request.fields.addAll({'parent_id': id, 'roll': roll_id.toString()});
    print("=========roll in get category======${request.fields}===========");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = CategoryModel.fromJson(json.decode(finalResponse));
      print("categoryyyy responsee $finalResult");
      print("categoryyyy responsee $finalResponse");
      setState(() {
        categoryModel = finalResult;
        for (var i = 0; i < (categoryModel?.data?.length ?? 0); i++) {
          categoriesSelectedValues.add(false);
        }
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  String? vendorId;
  String? parentId;

  saveCatDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    vendorId = prefs.getString("vendor_id");
    var headers = {
      'Cookie': 'ci_session=2af0bd20724524e1ebfba0e830885dbff718f536'
    };
    var data = <String, String>{
      'parent_id': parentId.toString(),
      'categoies': categoriesIdSelected.join(","),
      'vendor_id': vendorId.toString(),
      'howmany_cient': clientsServesController.text,
      'wokring_hours': workingHoursController.text,
      'working_days': workingDaysController.text,
      'visting_charge': visitingChargesController.text
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.vendorDeals));
    request.fields.addAll(data);
    print("requestttt fields save details======${request.fields}===========");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = jsonDecode(finalResponse);
      print(" final resultseeee $finalResult");
      print(" responseeee $finalResponse");
      Fluttertoast.showToast(msg: finalResult["message"]);
      // if(finalResult["status"]== "success") {}
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
              "assets/images/otp verification3.png",
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
                                  child: Text('1',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10)),
                                  backgroundColor: colors.primary,
                                  maxRadius: 8),
                              SizedBox(width: 5),
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
                          // roll_id == "1" ? shopModel?.data?.length == null || shopModel?.data?.length == ""
                          //         ? const Center(
                          //             child: CircularProgressIndicator(
                          //             color: colors.primary,
                          //           ))
                          //         :
                          SizedBox(
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
                                        if (checked!) {
                                          selectedIndex = index;
                                          getCat(shopModel?.data?[index].id
                                                  .toString() ??
                                              "");
                                          parentId = shopModel?.data?[index].id
                                                  .toString() ??
                                              "";
                                          print(
                                              "=========parent id is ======$parentId===========");
                                        }
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
                                      value: selectedIndex == index,
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
                          //     : SizedBox.shrink(),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          SizedBox(
                            height: 5,
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
                            height: 0,
                          ),
                          categoryModel == null
                              ? const Center(
                                  child: Text("Select Shop type"),
                                )
                              : categoryModel!.responseCode == "0"
                                  ? const Center(
                                      child: Text("Categories Not Found"),
                                    )
                                  : categoryModel?.data?.length == null ||
                                          categoryModel?.data?.length == ""
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: colors.primary,
                                          ),
                                        )
                                      :
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
                                          margin: const EdgeInsets.only(
                                              left: 2, right: 2),
                                          width: double
                                              .infinity, // adjust width if needed
                                          // height: 400, // adjust height if needed
                                          child: GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    mainAxisSpacing: 3,
                                                    childAspectRatio: 2 / 2.67),
                                            itemCount:
                                                categoryModel!.data!.length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Stack(
                                                alignment: Alignment.topLeft,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        categoriesSelectedValues[
                                                                index] =
                                                            !categoriesSelectedValues[
                                                                index];
                                                      });
                                                    },
                                                    child: Column(
                                                      children: [
                                                        categoryModel!
                                                                        .data![
                                                                            index]
                                                                        .img ==
                                                                    "" ||
                                                                categoryModel!
                                                                        .data![
                                                                            index]
                                                                        .img ==
                                                                    null
                                                            ? Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Image.asset(
                                                                    "assets/images/placeholder.png"))
                                                            : Container(
                                                                height: 100,
                                                                width: 100,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                // clipBehavior: Clip.hardEdge,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(4),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    border: Border.all(
                                                                        color: colors
                                                                            .primary)),
                                                                child: Image
                                                                    .network(
                                                                  "https://developmentalphawizz.com/hojayega/${categoryModel!.data![index].img.toString()}",
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                        Flexible(
                                                          child: Text(
                                                            categoryModel!
                                                                .data![index]
                                                                .cName
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        10),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  if (categoriesSelectedValues[
                                                      index])
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              10),
                                                      //  padding: EdgeInsets.all(2),
                                                      decoration: BoxDecoration(
                                                        color: colors.secondary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
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
                                          )),
                          roll_id == "2"
                              ? Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          CircleAvatar(
                                            backgroundColor: colors.primary,
                                            maxRadius: 8,
                                            child: Text(
                                              '5',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "How Many Clients You Can Serves At Same Time?",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: colors.primary),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: clientsServesController,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Required Details';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "EX. 3 client",
                                          isDense: true,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: colors.primary)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: const [
                                          CircleAvatar(
                                            child: Text(
                                              '3',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
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
                                          SizedBox(width: 30),
                                          CircleAvatar(
                                            child: Text(
                                              '4',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
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
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .41,
                                            child: TextFormField(
                                              controller:
                                                  workingHoursController,
                                              keyboardType: TextInputType.text,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter working Hours';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                hintText: "Ex.9 AM to 10 PM",
                                                isDense: true,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: colors
                                                                .primary)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .41,
                                            child: TextFormField(
                                              controller: workingDaysController,
                                              keyboardType: TextInputType.text,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter  Working Days';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                hintText: "Ex. Mon-Sat",
                                                isDense: true,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: colors
                                                                .primary)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: const [
                                          CircleAvatar(
                                            backgroundColor: colors.primary,
                                            maxRadius: 8,
                                            child: Text(
                                              '6',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
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
                                          style:
                                              TextStyle(color: colors.primary),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: visitingChargesController,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter  Your Visiting Charges';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "EX. 200 Rs",
                                          isDense: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: colors.primary),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox.shrink(),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () async {
                                List<int> selectedCategoryIndex = [];
                                // selectedCategoryIndex.add(
                                //     categoriesSelectedValues.where((element) => element==true)
                                // );
                                //
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                if (categoriesSelectedValues.contains(true)) {
                                  for (var i = 0;
                                      i < categoriesSelectedValues.length;
                                      i++) {
                                    if (categoriesSelectedValues[i] == true) {
                                      categoriesIdSelected
                                          .add(categoryModel?.data?[i].id);
                                      print(
                                          "categoriesss $categoriesIdSelected valueee $categoriesSelectedValues");
                                      selectedCategoryIndex.add(i);
                                    }
                                  }
                                  prefs.setString("selectedCategoryIndex",
                                      selectedCategoryIndex.toString());
                                  prefs.setString(
                                      "selectedShopType",
                                      shopModel!.data![selectedIndex].id
                                          .toString());
                                  log("selectedindex $selectedCategoryIndex");
                                  if (roll_id == "1") {
                                    // print(getData());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AllCategory(isShow: true),
                                      ),
                                    );
                                  } else {
                                    if (_formKey.currentState!.validate()) {
                                      print(getData());
                                      saveCatDetails();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ServicesDetails(
                                                      ParentId: parentId
                                                          .toString())));
                                    }
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Please Select Categories");
                                }
                              },
                              child: Center(
                                child: Card(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: colors.secondary,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width:
                                        MediaQuery.of(context).size.width * .6,
                                    child: const Center(
                                      child: Text(
                                        'Next',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
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
