// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:hojayega_seller/Screen/AddProduct.dart';
// import 'package:http/http.dart' as http;
// import '../Helper/api.path.dart';
// import '../Helper/color.dart';
// import '../Model/CategoryModel.dart';
// import '../Model/ChildCategoryModel.dart';
// import '../Model/SubCategoryModel.dart';
//
// class AllCategory extends StatefulWidget {
//   const AllCategory({super.key});
//
//   @override
//   State<AllCategory> createState() => _AllCategoryState();
// }
//
// class _AllCategoryState extends State<AllCategory> {
//
//
//   @override
//   void initState() {
//     super.initState();
//     getCat();
//     getSubCat();
//     getChildCat();
//   }
//   CategoryModel? categoryModel;
//   List<CategoryData> categoryList1 = [];
//   List <String> categoryImageList = [];
//   List <String> categoryNameList = [];
//
//   getCat() async {
//     var headers = {
//       'Cookie': 'ci_session=70c618f5670ba3cd3a735fde130cab16e002a8af'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getCategories));
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var result = await response.stream.bytesToString();
//       print("this is a response===========> $result");
//       categoryList1 = CategoryModel.fromJson(json.decode(result)).data??[];
//       print("this is category slider===========> $categoryList1");
//       setState(() {
//         for(int i=0;i<categoryList1.length;i++){
//           categoryImageList.add(categoryList1[i].img ?? '');
//           categoryNameList.add(categoryList1[i].cName ?? '');
//           print("imagegesssss ${categoryList1[i].img}");
//         }
//       });
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   SubCategoryModel? subCatData;
//   getSubCat() async {
//     var headers = {
//       'Cookie': 'ci_session=bc5faeb8b724ab48c93561cf6ee609d9ec876621'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getSubCategories));
//     request.fields.addAll({
//       'parent_id': '2',
//       'roll': '1',
//       'cat_id': '1'
//     });
//     print("seb category parameteer ${request.fields}");
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResponse = await response.stream.bytesToString();
//       final finalResult = SubCategoryModel.fromJson(json.decode(finalResponse));
//       print("sub category responsee $finalResult");
//       setState(() {
//         subCatData = finalResult;
//       });
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   ChildCategoryModel? childCategoryModel;
//   getChildCat() async{
//     var headers = {
//       'Cookie': 'ci_session=e456fb4275aab002e5eb6c860cc3811ebb3a9fa7'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.productchildCategories));
//     request.fields.addAll({
//       'sub_cat_id': '2'
//     });
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResponse = await response.stream.bytesToString();
//       final finalResult = ChildCategoryModel.fromJson(json.decode(finalResponse));
//       print("child category responsee $finalResult");
//       setState(() {
//         childCategoryModel = finalResult;
//       });
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   int currentIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       floatingActionButton: InkWell(
//         onTap: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
//         },
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 40, ),
//           child: Container(
//             height: 50,
//             width: 50,
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(150), color: colors.primary
//             ),
//             child: const Icon(Icons.add, color: Colors.white, size: 34,),
//           ),
//         ),
//       ),
//       backgroundColor: colors.appbarColor,
//       appBar: AppBar(
//           elevation: 0,
//           centerTitle: true,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(25),
//               bottomRight: Radius.circular(25),
//             ),
//           ),
//           title: const Text('Sub-Category'),
//           backgroundColor: colors.primary
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 10),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//                 children: categoryImageList.map((e) {
//                   print(e);
//                   var item = e ;
//                   return Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 3, right: 3),
//                         child:
//                         item == null || item == "" ? Container(
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             image: const DecorationImage(
//                                 image: AssetImage("assets/images/placeholder.png",), fit: BoxFit.fill),
//                           ),
//                         ):
//                         Container(
//                           //width: MediaQuery.of(context).size.width,
//                           width: 110,
//                           height: 100,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             image: DecorationImage(image: NetworkImage(item), fit: BoxFit.fill),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },).toList()
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Center(
//             child: SizedBox(
//               width: 100,
//               height: 6,
//               child: Center(
//                 child: ListView.separated(
//                   shrinkWrap: true,
//                   itemCount: categoryImageList.length ?? 0,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       height: 6,
//                       width: 6,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: index == currentIndex
//                             ? colors.primary
//                             :Colors.grey,
//                       ),
//                     );
//                   },
//                   separatorBuilder: (context, index) {
//                     return const SizedBox(
//                       width: 5,
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: const [
//               Padding(
//                 padding: EdgeInsets.only(left: 5),
//                 child: Text(
//                   'Sub Category',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//           Column(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     height: size.height * 0.68,
//                     width: size.width * 0.3,
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
//                       color: Colors.white,
//                     ),
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: ListView.builder(
//                               shrinkWrap: true,
//                               scrollDirection: Axis.vertical,
//                               itemCount: subCatData?.data?.length ?? 0,
//                               itemBuilder: (context, index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.all(10),
//                                   child: Column(
//                                     children: [
//                                       subCatData?.data?[index].image == null || subCatData?.data?[index].image == "" ? Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                           BorderRadius.circular(10),
//                                           color: Colors.white,
//                                         ),
//                                         child: Image.asset(
//                                           "assets/images/placeholder.png",
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ):
//                                       Container(
//                                       height: 60,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                           BorderRadius.circular(10),
//                                           color: Colors.white,
//                                           border: Border.all(),
//                                         ),
//                                         child: Image.network(
//                                           '${ApiServicves.imageUrl}${subCatData?.data?[index].image}',
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                       Text("${subCatData?.data?[index].cName}", style: TextStyle(fontWeight: FontWeight.w500),),
//                                     ],
//                                   ),
//                                 );
//                               }),
//                         ),
//                         Container(
//                           width: 100,
//                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
//                           child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Color(0XFF112c48),
//                                 // shape: RoundedRectangleBorder(),
//                               ),
//                               onPressed: () {},
//                               child: const Text(
//                                 'More',
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 20),
//                               )),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Container(
//                           height: size.height * 0.68,
//                           width: size.width * 0.7,
//                           // color: Colors.orange,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 height: 30,
//                                 child: const Text(
//                                   'Child category',
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                               ),
//                               Container(
//                                 height: 50,
//                                 child: ListView.builder(
//                                     shrinkWrap: true,
//                                     scrollDirection: Axis.horizontal,
//                                     itemCount: 4,
//                                     itemBuilder: (context, index) {
//                                       return Padding(
//                                         padding: const EdgeInsets.all(5.0),
//                                         child: Column(
//                                           children: [
//                                             Container(
//                                               height: 30,
//                                               width: 90,
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.circular(5),
//                                                 border: Border.all(color: Colors.black),
//                                                 color: const Color(0XFF112c48),
//                                               ),
//                                               child: const Center(
//                                                 child: Text(
//                                                   'Data',
//                                                   style: TextStyle(
//                                                       fontSize: 18,
//                                                       color: Colors.white),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     }),
//                               ),
//                               SingleChildScrollView(
//                                 child: Container(
//                                   margin: EdgeInsets.only(left: 5, right: 5),
//                                   height: MediaQuery.of(context).size.height/2.6,
//                                   width: 280,
//                                   child: GridView.builder(
//                                     gridDelegate:
//                                     const SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 2,
//                                       crossAxisSpacing: 10,
//                                       mainAxisSpacing: 10,
//                                       mainAxisExtent: 200,
//                                     ),
//                                     itemCount: childCategoryModel?.data?.length ?? 0,
//                                     itemBuilder: (context, index) {
//                                       return Container(
//                                         margin: const EdgeInsets.only(top: 0),
//                                         decoration:  BoxDecoration(
//                                             borderRadius: BorderRadius.circular(5),
//                                             color: Colors.white),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             childCategoryModel?.data?[index].image == null ||  childCategoryModel?.data?[index].image == "" ?
//                                             ClipRRect(
//                                               child: Image.asset("assets/images/placeholder.png", height: 110),
//                                             ):
//                                             ClipRRect(
//                                               child: Image.network("${ApiServicves.imageUrl}${childCategoryModel?.data?[index].image}", height: 110),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(left: 3),
//                                               child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                       '${childCategoryModel?.data?[index].cName} ',
//                                                       style: const TextStyle(color: colors.primary, fontSize: 15, fontWeight: FontWeight.w600)),
//                                                   const Text("1KG", style: TextStyle(color: colors.primary, fontWeight: FontWeight.w600),),
//                                                   const SizedBox(height: 5,),
//                                                   const Text("200", style: TextStyle(color: colors.primary, fontWeight: FontWeight.w600),),
//                                                   const SizedBox(height: 5,),
//                                                   Row(
//                                                     children: [
//                                                       const Text("300", style: TextStyle(color: colors.primary, fontWeight: FontWeight.w600)),
//                                                       SizedBox(width: 20,),
//                                                       Container(
//                                                         height:25,
//                                                         child: ElevatedButton(
//                                                           style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                                                           onPressed: () {},
//                                                           child: const Text(
//                                                             'Add',
//                                                             style: TextStyle(color: Colors.white),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             SizedBox(height: 2,),
//                                             // Center(
//                                             //   child: Container(
//                                             //     height: 30,
//                                             //     child: ElevatedButton(
//                                             //       style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                                             //       onPressed: () {},
//                                             //       child: const Text(
//                                             //         'Add',
//                                             //         style: TextStyle(color: Colors.white),
//                                             //       ),
//                                             //     ),
//                                             //   ),
//                                             // ),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 93,
//                               ),
//                               Center(
//                                 child: Container(
//                                   height: 45,
//                                   width: 200,
//                                   child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                                     onPressed: () {
//                                       // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails()));
//                                     },
//                                     child: const Text(
//                                       'Buy', style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 20,
//                                     ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   buildproduct({required int index, required String name}) => Container(
//     width: 90,
//     height: 40,
//     alignment: Alignment.center,
//     decoration: BoxDecoration(
//         color: Color(0XFF112c48), borderRadius: BorderRadius.circular(8)),
//     child: Text(
//       name,
//       style: TextStyle(color: Colors.white),
//     ),
//   );
// }

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/api.path.dart';
import '../Helper/color.dart';
import '../Model/CategoryModel.dart';
import '../Model/ChildCategoryModel.dart';
import '../Model/GetProductCatWise.dart';
import '../Model/SubCategoryModel.dart';
import 'AddProduct.dart';
import 'Congratutation.dart';

class AllCategory extends StatefulWidget {
  String? ShopId;
  bool? isShow;
  AllCategory({super.key, this.ShopId, this.isShow});

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  @override
  void initState() {
    super.initState();
    getAll();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    subcatid = "";
    chidcatId = "";
  }

  List? selectedCategoryIndex;

  CategoryModel? categoryModel;
  List<CategoryData> categoryList1 = [];
  List<String> categoryImageList = [];
  List<String> categoryNameList = [];

  String? Selectcat;
  String? parent_id = "0";
  String? selectedShopId;

  getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("selectedCategoryIndex");
    selectedShopId = prefs.getString('selectedShopType');
    selectedCategoryIndex = value != null
        ? value
            .replaceAll('[', '')
            .replaceAll(']', '')
            .split(',')
            .map<int>((e) {
            return int.parse(e);
          }).toList()
        : null;
    await getShopCategory();
    Selectcat = selectedCategoryIndex != null
        ? categoryList1[selectedCategoryIndex!.first].id.toString()
        : "0";
    await getSubCat();
    await getChildCat();
    String? s1 = selectedCategoryIndex != null
        ? categoryList1[selectedCategoryIndex!.first].cName
        : null;
    prefs.setString('category', s1!);
    prefs.setString("catId", Selectcat!);
  }

  getShopCategory() async {
    var headers = {
      'Cookie': 'ci_session=70c618f5670ba3cd3a735fde130cab16e002a8af'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getCategories));
    request.fields
        .addAll({'parent_id': selectedShopId.toString() ?? "0", 'roll': '1'});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("===my technic=======${request.fields}===============");
    print("===my technic=======${request.url}===============");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print("this is a response===========> $result");
      categoryList1 = CategoryModel.fromJson(json.decode(result)).data ?? [];
      print("this is category slider===========> $categoryList1");
      setState(() {
        for (int i = 0; i < categoryList1.length; i++) {
          categoryImageList.add(categoryList1[i].img ?? '');
          categoryNameList.add(categoryList1[i].cName ?? '');
          print("imageg ${categoryList1[i].img}");
          setState(() {});
        }
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  String? subcatid;
  SubCategoryModel? subCatData;
  getSubCat() async {
    var headers = {
      'Cookie': 'ci_session=bc5faeb8b724ab48c93561cf6ee609d9ec876621'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getSubCategories));
    request.fields.addAll({
      'parent_id': parent_id.toString(),
      'roll': '1',
      'cat_id': Selectcat != null ? Selectcat.toString() : "0"
    });
    // request.fields.addAll({'cat_id': Selectcat.toString()});
    print("seb category parameteer ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("===my technic=======${request.fields}===============");
    print("===my technic=======${request.url}===============");
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = SubCategoryModel.fromJson(json.decode(finalResponse));
      print("sub category response $finalResult");
      setState(() {
        subCatData = finalResult;
        setState(() {});
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  String? chidcatId;
  ChildCategoryModel? childCategoryModel;
  getChildCat() async {
    var headers = {
      'Cookie': 'ci_session=e456fb4275aab002e5eb6c860cc3811ebb3a9fa7'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiServicves.productchildCategories));
    request.fields
        .addAll({'sub_cat_id': subcatid != null ? subcatid.toString() : "0"});
    request.headers.addAll(headers);
    print("===my technic=======${request.fields}===============");
    print("===my technic=======${request.url}===============");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult =
          ChildCategoryModel.fromJson(json.decode(finalResponse));
      print("child category responsee $finalResult");
      setState(() {
        childCategoryModel = finalResult;
        setState(() {});
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  GetProductCatWise? gerProductcatWise;
  List<ProductsData> productList = [];
  getProduct() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? vendor_id = sharedPreferences.getString('vendor_id');
    var headers = {
      'Cookie': 'ci_session=e456fb4275aab002e5eb6c860cc3811ebb3a9fa7'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getVendorProduct));
    request.fields.addAll({
      'cat_id': Selectcat.toString(),
      'sub_id': subcatid.toString(),
      'child_id': chidcatId != null ? chidcatId.toString() : "0",
      'vid': vendor_id.toString()
    });

    request.headers.addAll(headers);
    log("=== get product my technic=======${request.fields}===============");
    print("===my technic=======${request.url}===============");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      log("===my technic=======${response.statusCode}===============");
      var finalResponse = await response.stream.bytesToString();
      gerProductcatWise =
          GetProductCatWise.fromJson(json.decode(finalResponse));
      productList = gerProductcatWise?.products ?? [];
      setState(() {});
    } else {
      print("response" + response.toString());
    }
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            log(prefs.get('category').toString());
            log(prefs.get('catId').toString());
            log(prefs.get('sunCatId').toString());
            log("subid$subcatid");
            print(prefs.get('sub'));
            print(prefs.get('child'));

            if (Selectcat == null ||
                Selectcat == "" ||
                subcatid == null ||
                subcatid!.isEmpty ||
                chidcatId == null ||
                chidcatId!.isEmpty) {
              Fluttertoast.showToast(msg: "Please select Categories");
            } else {
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddProduct()))
                  .then((value) {
                setState(() {
                  subcatid = null;
                  chidcatId = null;
                  getAll();
                });
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 40,
            ),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150),
                  color: colors.primary),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 34,
              ),
            ),
          ),
        ),
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            title: const Text('Sub-Category'),
            backgroundColor: colors.primary),
        backgroundColor: colors.appbarColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryImageList.length,
                  itemBuilder: (context, index) {
                    if (selectedCategoryIndex == null ||
                        selectedCategoryIndex == []) {
                      return InkWell(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          setState(() {
                            Selectcat = categoryList1[index].id;
                            String? s1 = categoryList1[index].cName;
                            parent_id = categoryList1[index].serviceType;
                            print(s1);
                            // log(Selectcat!);
                            prefs.setString('category', s1!);
                            prefs.setString("catId", Selectcat!);
                          });
                          getSubCat();
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: Container(
                                      //width: MediaQuery.of(context).size.width,
                                      width: 90,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(color: colors.primary),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "${ApiServicves.imageUrl}${categoryImageList[index]}"),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  ),
                                  Selectcat == categoryList1[index].id
                                      ? Positioned(
                                          top: 6,
                                          left: 6,
                                          child: Container(
                                            //width: MediaQuery.of(context).size.width,
                                            width: 20,
                                            height: 30,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: colors.secondary,
                                            ),
                                            child: const Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(2),
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ),
                            Container(
                              width: 50,
                              child: Text(
                                categoryNameList[index],
                                style: const TextStyle(
                                    fontSize: 14, color: colors.black54),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      if (selectedCategoryIndex!.contains(index)) {
                        return InkWell(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            setState(() {
                              Selectcat = categoryList1[index].id;

                              String? s1 = categoryList1[index].cName;

                              parent_id = categoryList1[index].serviceType;
                              print(s1);
                              // log(Selectcat!);
                              prefs.setString('category', s1!);
                              prefs.setString("catId", Selectcat!);
                            });
                            getSubCat();
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: Container(
                                        //width: MediaQuery.of(context).size.width,
                                        width: 90,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border:
                                              Border.all(color: colors.primary),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${ApiServicves.imageUrl}${categoryImageList[index]}"),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                    ),
                                    Selectcat == categoryList1[index].id
                                        ? Positioned(
                                            top: 6,
                                            left: 6,
                                            child: Container(
                                              //width: MediaQuery.of(context).size.width,
                                              width: 20,
                                              height: 30,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: colors.secondary,
                                              ),
                                              child: const Center(
                                                child: Padding(
                                                  padding: EdgeInsets.all(2),
                                                  child: Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              ),
                              Container(
                                width: 50,
                                child: Text(
                                  categoryNameList[index],
                                  style: const TextStyle(
                                      fontSize: 14, color: colors.black54),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Center(
                child: SizedBox(
                  width: 100,
                  height: 6,
                  child: Center(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: categoryImageList.length ?? 0,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 6,
                          width: 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index == currentIndex
                                ? colors.primary
                                : Colors.grey,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 5,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      'Sub Category',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: size.height * 0.65,
                        width: size.width * 0.3,
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(25)),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: subCatData?.data?.isNotEmpty ?? false
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: subCatData?.data?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            setState(() {
                                              subcatid =
                                                  subCatData?.data?[index].id;
                                              prefs.setString(
                                                  'subCatId', subcatid!);
                                              String? s1 = subCatData
                                                  ?.data?[index].cName;
                                              print(s1);
                                              prefs.setString('sub', s1!);
                                              // prefs.setString('child', chidcatId!);
                                            });
                                            getChildCat();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                subCatData?.data?[index]
                                                                .image ==
                                                            null ||
                                                        subCatData?.data?[index]
                                                                .image ==
                                                            ""
                                                    ? Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.asset(
                                                          "assets/images/placeholder.png",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    : Stack(
                                                        children: [
                                                          Container(
                                                            height: 60,
                                                            width: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Colors.white,
                                                              image:
                                                                  DecorationImage(
                                                                image: NetworkImage(
                                                                    '${ApiServicves.imageUrl}${subCatData?.data?[index].image}'),
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                          subcatid ==
                                                                  subCatData
                                                                      ?.data?[
                                                                          index]
                                                                      .id
                                                              ? Positioned(
                                                                  top: 6,
                                                                  left: 6,
                                                                  child:
                                                                      Container(
                                                                    //width: MediaQuery.of(context).size.width,
                                                                    width: 20,
                                                                    height: 20,
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Colors
                                                                          .green,
                                                                    ),
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(2),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .check,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              15,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : const SizedBox
                                                                  .shrink(),
                                                        ],
                                                      ),
                                                Text(
                                                  "${subCatData?.data?[index].cName}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.5,
                                      child: const Center(
                                        child: Text("Data Not Found"),
                                      ),
                                    ),
                            ),
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0XFF112c48),
                                    // shape: RoundedRectangleBorder(),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'More',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: size.height * 0.68,
                              width: size.width * 0.7,
                              // color: Colors.orange,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          'Child category',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: colors.black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 50,
                                    child: childCategoryModel
                                                ?.data?.isNotEmpty ??
                                            false
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: childCategoryModel
                                                    ?.data?.length ??
                                                0,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () async {
                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  setState(() {
                                                    chidcatId =
                                                        childCategoryModel
                                                            ?.data?[index].id;
                                                    String? s1 =
                                                        childCategoryModel
                                                            ?.data?[index]
                                                            .cName;
                                                    prefs.setString(
                                                        "childCatId",
                                                        chidcatId!);
                                                    print(s1);
                                                    print(
                                                        "1111111111SSSSSSSSSSS@@2222222222");
                                                    prefs.setString(
                                                        'child', s1!);
                                                  });
                                                  getProduct();
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: chidcatId ==
                                                                      childCategoryModel
                                                                          ?.data?[
                                                                              index]
                                                                          .id
                                                                  ? colors
                                                                      .secondary
                                                                  : Colors
                                                                      .black,
                                                              width: 3),
                                                          color: const Color(
                                                              0XFF112c48),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            '${childCategoryModel?.data?[index].cName}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
                                        : const Center(
                                            child: Text('Data Not Found'),
                                          ),
                                  ),
                                  SingleChildScrollView(
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 5, right: 5),
                                      height: 270,
                                      width: 280,
                                      child:
                                          chidcatId == null ||
                                                  productList.isEmpty
                                              ? const Center(
                                                  child:
                                                      Text('Product Not Found'))
                                              : GridView.builder(
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 10,
                                                    mainAxisSpacing: 10,
                                                    mainAxisExtent: 170,
                                                  ),
                                                  itemCount: productList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        // Navigator.push(
                                                        //     context,
                                                        //     MaterialPageRoute(
                                                        //         builder: (context) =>
                                                        //             ProductDetails(
                                                        //               productId:
                                                        //                   productList[
                                                        //                       index],
                                                        //             )));
                                                      },
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 0),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                Colors.white),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 0),
                                                              child: productList[index]
                                                                              .otherImage
                                                                              ?.first ==
                                                                          null ||
                                                                      productList[index]
                                                                              .otherImage
                                                                              ?.first ==
                                                                          ""
                                                                  ? Center(
                                                                      child:
                                                                          Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/images/placeholder.png",
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ))
                                                                  : Container(
                                                                      height:
                                                                          95,
                                                                      width:
                                                                          120,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: Colors
                                                                            .black,
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              NetworkImage('${productList[index].otherImage?[0]}'),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                              // CarouselSlider(
                                                              //   options:
                                                              //       CarouselOptions(
                                                              //     height: 50,
                                                              //     aspectRatio:
                                                              //         16 / 9,
                                                              //     viewportFraction:
                                                              //         1.0,
                                                              //     initialPage: 0,
                                                              //     enableInfiniteScroll:
                                                              //         true,
                                                              //     reverse: false,
                                                              //     autoPlay: true,
                                                              //     autoPlayInterval:
                                                              //         const Duration(seconds: 3),
                                                              //     autoPlayAnimationDuration:
                                                              //         const Duration(milliseconds: 800),
                                                              //     autoPlayCurve:
                                                              //         Curves.fastOutSlowIn,
                                                              //     enlargeCenterPage: false,
                                                              //     onPageChanged:
                                                              //         (index, reason) {
                                                              //       setState(() {
                                                              //         currentIndex = index;
                                                              //       });
                                                              //     },
                                                              //   ),
                                                              //   items: productList[index].otherImage!.map(
                                                              //         (item) => Padding(padding: const EdgeInsets.only(left: 5, right: 5),
                                                              //           child:
                                                              //               Container(
                                                              //             width: MediaQuery.of(context)
                                                              //                 .size
                                                              //                 .width,
                                                              //             decoration:
                                                              //                 BoxDecoration(
                                                              //               borderRadius:
                                                              //                   BorderRadius.circular(8),
                                                              //               image: DecorationImage(
                                                              //                   image: NetworkImage("$item"),
                                                              //                   fit: BoxFit.fill),
                                                              //             ),
                                                              //           ),
                                                              //         ),
                                                              //       )
                                                              //       .toList(),
                                                              // ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            // Center(
                                                            //   child: SizedBox(
                                                            //     width: 100,
                                                            //     height: 6,
                                                            //     child: Center(
                                                            //       child: ListView
                                                            //           .separated(
                                                            //         shrinkWrap:
                                                            //             true,
                                                            //         itemCount: productList[
                                                            //                     index]
                                                            //                 .otherImage
                                                            //                 ?.length ??
                                                            //             0,
                                                            //         scrollDirection:
                                                            //             Axis.horizontal,
                                                            //         itemBuilder:
                                                            //             (context,
                                                            //                 index) {
                                                            //           return Container(
                                                            //             height: 6,
                                                            //             width: 6,
                                                            //             decoration:
                                                            //                 BoxDecoration(
                                                            //               borderRadius:
                                                            //                   BorderRadius.circular(10),
                                                            //               color: index ==
                                                            //                       currentIndex
                                                            //                   ? colors.secondary
                                                            //                   : const Color(0xffFEE9E9E9),
                                                            //             ),
                                                            //           );
                                                            //         },
                                                            //         separatorBuilder:
                                                            //             (context, index) {
                                                            //           return const SizedBox(
                                                            //             width: 5,
                                                            //           );
                                                            //         },
                                                            //       ),
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                            // ClipRRect(
                                                            //   child: Image.network("${productList[index].productImage}", height: 110),
                                                            // ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    '${productList[index].productName}',
                                                                    style: const TextStyle(
                                                                        color: colors
                                                                            .primary,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  // Text(
                                                                  //   "${productList[index].unit ?? ""}kg",
                                                                  //   style: const TextStyle(
                                                                  //       color: colors
                                                                  //           .primary,
                                                                  //       fontWeight:
                                                                  //           FontWeight
                                                                  //               .w600,
                                                                  //       fontSize:
                                                                  //           16),
                                                                  // ),
                                                                  Text(
                                                                    "\u{20B9} ${productList[index].sellingPrice}",
                                                                    style: const TextStyle(
                                                                        color: colors
                                                                            .primary,
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                          "\u{20B9} ${productList[index].productPrice}",
                                                                          style: const TextStyle(
                                                                              color: colors.primary,
                                                                              decoration: TextDecoration.lineThrough,
                                                                              fontSize: 16)),
                                                                      Spacer(),
                                                                      // InkWell(
                                                                      //   onTap: () async {
                                                                      //     SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                      //     log(prefs.get('category').toString());
                                                                      //     log(prefs.get('catId').toString());
                                                                      //     log(prefs.get('sunCatId').toString());
                                                                      //     log("subid$subcatid");
                                                                      //     print(prefs.get('sub'));
                                                                      //     print(prefs.get('child'));
                                                                      //     if (Selectcat == null ||
                                                                      //         Selectcat == "" ||
                                                                      //         subcatid == null ||
                                                                      //         subcatid!.isEmpty ||
                                                                      //         chidcatId == null ||
                                                                      //         chidcatId!.isEmpty) {
                                                                      //       Fluttertoast.showToast(msg: "Please select Categories");
                                                                      //     } else {
                                                                      //       print("dklsdskds ${productList[index].productId}");
                                                                      //       Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct(isEdit: true, productId:productList[index].productId))).then((value) {
                                                                      //         setState(() {
                                                                      //           subcatid = null;
                                                                      //           chidcatId = null;
                                                                      //           getAll();
                                                                      //         });
                                                                      //       });
                                                                      //     }
                                                                      //   },
                                                                      //
                                                                      //   child: Container(
                                                                      //     alignment: Alignment.bottomRight,
                                                                      //     height: 20,
                                                                      //     width: 50,
                                                                      //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(2),
                                                                      //         color: colors.secondary),
                                                                      //     child: const Center(
                                                                      //       child:
                                                                      //           Text(
                                                                      //         'Edit',
                                                                      //         style: TextStyle(
                                                                      //             color:
                                                                      //                 Colors.white),
                                                                      //       ),
                                                                      //     ),
                                                                      //   ),
                                                                      // ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 93,
                                  ),
                                  widget.isShow == true
                                      ? Center(
                                          child: Container(
                                            height: 40,
                                            width: 200,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.green),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Congratulation()));
                                              },
                                              child: const Text(
                                                'Next',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildproduct({required int index, required String name}) => Container(
        width: 90,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0XFF112c48), borderRadius: BorderRadius.circular(8)),
        child: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
      );
}
