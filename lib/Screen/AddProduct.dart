import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hojayega_seller/Helper/api.path.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Custom_Text.dart';
import '../Helper/Custom_textForm.dart';
import '../Helper/appButton.dart';
import '../Helper/color.dart';
import '../Model/CategoryModel.dart';
import '../Model/ChildCategoryModel.dart';
import '../Model/GetAddProductModel.dart';
import '../Model/SubCategoryModel.dart';
import '../Model/UnitTypeModel.dart';

class AddProduct extends StatefulWidget {
  bool? isEdit;

  String? productId;
  AddProduct({
    Key? key,
    this.isEdit,
    this.productId,
  }) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

List<String> otherImageList = [];
String? productImageUrl1;
String? broncherImageUrl1;

String? category_id;
var category;
var subcat;
int count = 0;

String? myCategory;
String? mySub;
String? myChild;

int videoLinkindex = 0;
int pressed = 0;
bool _isChecked = false;
int product = 0;

final _formKey = GlobalKey<FormState>();

class _AddProductState extends State<AddProduct> {
  final TextEditingController _nameCtr = TextEditingController();
  final TextEditingController _priceCtr = TextEditingController();
  final TextEditingController _unitCtr = TextEditingController();
  final TextEditingController _unittypeCtr = TextEditingController();
  final TextEditingController _sellingPriceCtr = TextEditingController();

  final TextEditingController _shortDesCtr = TextEditingController();
  final TextEditingController _fullDesCtr = TextEditingController();
  final TextEditingController _extraDesCtr = TextEditingController();
  final TextEditingController _videoLink = TextEditingController();
  String videoType = 'None';
  var videoList = ['None', 'Youtube'];
  String prodType = 'Select Type';
  var prodList = [
    'Select Type',
    'Simple Product',
  ];
  String stockStatus = 'In Stock';
  var stockList = ['In Stock', 'Out Of Stock'];
  var cat_id;

  var category;
  var sub;
  var child;

  void initState() {
    super.initState();
    // TODO: implement initState
    // fetchData();
    unitTypes.add(selectedValue);
    count = 0;
    // getData();
    getUnits();
    getCategory("");
    getAddProduct();
    getSubCategory(" ", " ");
  }

  onclick() async {
    CustomTextFormField(
      controller: _videoLink,
      hintText: 'Paste Youtube/video link',
    );
  }

  List<Unitdata> unitList = [];
  getUnits() async {
    var headers = {
      'Cookie': 'ci_session=232493a0eb7c4997f470f700c8a4a4303b973e5d'
    };
    var request = http.Request('POST', Uri.parse(ApiServicves.unitsAPi));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = UnitTypeModel.fromJson(json.decode(finalResponse));
      setState(() {
        unitList = jsonResponse.data!.toList();
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  CategoryModel? getCatModel;
  getCategory(service_Id) async {
    //SharedPreferences preferences = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=ea5681bb95a83750e0ee17de5e4aa2dca97184ef'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getCategories));
    request.fields.addAll({'parent_id': service_Id.toString(), 'roll': '1'});
    print("get category is ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = CategoryModel.fromJson(json.decode(finalResponse));
      print('____dsdsfds______${finalResponse}_________');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(prefs.get('category'));
      print(prefs.get('sub'));
      print(prefs.get('child'));

      //  myCategory=prefs.get('category') as String?;
      String? s1 = prefs.get('category') as String?;
      myCategory = s1 == null ? "" : s1;

      String? s2 = prefs.get('sub') as String?;
      mySub = s2 == null ? "" : s2;

      String? s3 = prefs.get('child') as String?;
      myChild = s3 == null ? "" : s3;

      for (int i = 0; i < jsonResponse.data!.length; i++) {
        print("${jsonResponse.data?[i].id}");
        category_id = jsonResponse.data?[i].id ?? "";
      }
      setState(() {
        getCatModel = jsonResponse;
      });
      //  SharedPreferences prefs = await SharedPreferences.getInstance();
      // Object? s1=prefs.get('category');
      //
      //  SharedPreferences prefs = await SharedPreferences.getInstance();
      //  String? id = prefs.getString('id');
      //  int i=int.parse(id!);
      //
      //  print(prefs.get('category'));
      //  print(prefs.get('sub'));
      //  print(prefs.get('child'));
    } else {
      print(response.reasonPhrase);
    }
  }

  String? catId;
  String? service_Id;

  SubCategoryModel? getSubCatModel;
  getSubCategory(var catId, service_Id) async {
    var headers = {
      'Cookie': 'ci_session=42a446b2158b0665d69eb924baea971b3adf8b1d'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getSubCategories));
    request.fields.addAll({
      'parent_id': service_Id.toString(),
      'roll': '1',
      'cat_id': catId.toString(),
    });
    print("sub category paraa ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse =
          SubCategoryModel.fromJson(json.decode(finalResponse));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idSub = prefs.getString('sub');
      int kk = int.parse(idSub!);
      for (int i = 0; i < jsonResponse.data!.length; i++) {
        print("sub cat:${jsonResponse.data?[i].id}");
        subCatId = jsonResponse.data?[i].id ?? "";

        print(subCatId);
        print("aaaaaaaaaa111");
        print(idSub);
        if (subCatId == idSub) {
          setState(() {
            sub = jsonResponse.data?[i].cName;
          });
          print("------mm-------pp-------");
          print(sub);
        }
      }
      setState(() {
        getSubCatModel = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  GetAddProductModel? productData;
  getAddProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    vendorId = prefs.getString("vendor_id");
    var headers = {
      'Cookie': 'ci_session=fb41c6310d2373ff3ea167bc9dea47a17138531f'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getAllAddProduct));
    request.fields.addAll({
      'vid': vendorId.toString(),
      'product_id': '${widget.productId}',
    });
    print("get add productt ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult =
          GetAddProductModel.fromJson(json.decode(finalResponse));
      print("child category responsee $finalResult");
      setState(() {
        productData = finalResult;
        for (int i = 0;
            i < productData!.products.first.productUnits.length;
            i++) {
          if (widget.isEdit == true) {
            print(
                "here product name ${productData?.products.first.productName}");
            _nameCtr.text = productData?.products.first.productName ?? "";
            _priceCtr.text = productData?.products.first.productPrice ?? "";
            _sellingPriceCtr.text =
                productData?.products.first.sellingPrice ?? "";
            _fullDesCtr.text =
                productData?.products.first.productDescription ?? "";
            // unit[i] = productData?.products.first.productUnits[i].unit ?? "";
            // lang = widget.addressList?.lng ?? "";
          }
        }
        print(
            "product name is nowww ${productData?.products.first.productName}");
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  ChildCategoryModel? childCategoryModel;
  getChildCat(var sub_Id) async {
    var headers = {
      'Cookie': 'ci_session=e456fb4275aab002e5eb6c860cc3811ebb3a9fa7'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiServicves.productchildCategories));
    request.fields.addAll({'sub_cat_id': sub_Id.toString()});
    print("child categuruyry parar ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult =
          ChildCategoryModel.fromJson(json.decode(finalResponse));
      print("child category responsee $finalResult");
      setState(() {
        childCategoryModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  File? _image;
  final picker = ImagePicker();
  var imageCode;
  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null && imageCode == 1) {
        _image = File(pickedFile.path);
      } else {
        print('no image picked');
      }
    });
  }

  String? vendorId;

  // getData() async {
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   vendorId = preferences.getString('vendor_id');
  //   print("vendor id add product screen $vendorId");
  // }

  // addProductApi() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   category_Id = prefs.getString("catId");
  //   subCatId = prefs.getString("subCatId");
  //   childCatId = prefs.getString("childCatId");
  //   print("catid $category_Id");
  //   print("subcatid $subCatId");
  //   print("childcatid $childCatId");
  //   var headers = {
  //     'Cookie': 'ci_session=2844e71eb13a14bad7faba0b8d00d5626590d23e'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.addProducts));
  //   request.fields.addAll({
  //     'name': _nameCtr.text,
  //     'product_description': _fullDesCtr.text,
  //     'product_price': _priceCtr.text,
  //     'selling_price': _sellingPriceCtr.text,
  //     'cat_id': category_Id.toString(),
  //     'sub_cat_id': subCatId.toString(),
  //     'child_cat_id': childCatId.toString(),
  //     // 'unit': _unitCtr.text,
  //     // 'unit_type': unitValue.toString(),
  //     'vid': vendorId.toString(),
  //
  //   });
  //   List<Map<String, String>> unittList = [];
  //   for (int i = 0; i < unit.length; i++) {
  //     Map<String, String> unitData = {
  //       'unit': unit[i].toString(),
  //     };
  //     unittList.add(unitData);
  //   }
  //   int k = 0;
  //   for (int i = 0; i < unitType.length; i++) {
  //     Map<String, String> unitTypeData = {
  //       'unit_type': unitType[i].toString(),
  //     };
  //     unittList.add(unitTypeData);
  //   }
  //   Map data = addMapListToData(param, unittList);
  //
  //   print("add producttt apiii ${request.fields}");
  //   for (var i = 0; i < (imagePathList.length ?? 0); i++) {
  //     print('Imageeeeeeeeeeee $imagePathList');
  //     imagePathList[i] == ""
  //         ? null
  //         : request.files.add(await http.MultipartFile.fromPath(
  //         'main_image[]', imagePathList[i].toString()));
  //   }
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var result = await response.stream.bytesToString();
  //     var finalResult = jsonDecode(result);
  //     print("finalresult $finalResult");
  //     Fluttertoast.showToast(msg: "${finalResult['message']}");
  //     Navigator.pop(context);
  //     // Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
  //     setState(() {
  //       isLodding = false;
  //     });
  //   } else {
  //     setState(() {
  //       isLodding = false;
  //     });
  //     print("rasponse"+response.reasonPhrase.toString());
  //   }
  // }

  addProductApi() async {
    setState(() {
      isLodding = true;
    });
    var headers = {
      'Cookie': 'ci_session=2844e71eb13a14bad7faba0b8d00d5626590d23e'
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    category_Id = prefs.getString("catId");
    subCatId = prefs.getString("subCatId");
    childCatId = prefs.getString("childCatId");
    print("catid $category_Id");
    print("subcatid $subCatId");
    print("childcatid $childCatId");
    var param = {
      'name': _nameCtr.text,
      'product_description': _fullDesCtr.text,
      'product_price': _priceCtr.text,
      'selling_price': _sellingPriceCtr.text,
      'cat_id': category_Id.toString(),
      'sub_cat_id': subCatId.toString(),
      'child_cat_id': childCatId.toString(),
      // 'unit': _unitCtr.text,
      // 'unit_type': unitValue.toString(),
      'vid': vendorId.toString(),
    };
    // for (var i = 0; i < (imagePathList.length ?? 0); i++) {
    //   print('Imageeeeee $imagePathList');
    //   imagePathList[i] == ""
    //       ? null
    //       : request.files.add(await http.MultipartFile.fromPath(
    //       'main_image[]', imagePathList[i].toString()));
    // }
    List<Map<String, String>> unittList = [];
    for (int i = 0; i < unit.length; i++) {
      Map<String, String> unitData = {
        'unit': unit.join(","),
      };
      unittList.add(unitData);
    }
    int k = 0;
    for (int i = 0; i < unitTypes.length; i++) {
      Map<String, String> unitTypeData = {
        'unit_type': unitTypes.join(","),
      };
      unittList.add(unitTypeData);
    }
    Map data = addMapListToData(param, unittList);
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.addProducts));
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    print("add product api parar ${request.fields} hrerer $param");
    for (var i = 0; i < (imagePathList.length ?? 0); i++) {
      print('Imageeeeee $imagePathList');
      imagePathList[i] == ""
          ? null
          : request.files.add(await http.MultipartFile.fromPath(
              'main_image[]', imagePathList[i].toString()));
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}");
      Navigator.pop(context);
      setState(() {
        isLodding = false;
      });
    } else {
      setState(() {
        isLodding = false;
      });
      print("rasponse" + response.reasonPhrase.toString());
    }
  }

  editProductApi() async {
    setState(() {
      isLodding = true;
    });
    var headers = {
      'Cookie': 'ci_session=2844e71eb13a14bad7faba0b8d00d5626590d23e'
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    category_Id = prefs.getString("catId");
    subCatId = prefs.getString("subCatId");
    childCatId = prefs.getString("childCatId");
    print("catid $category_Id");
    print("subcatid $subCatId");
    print("childcatid $childCatId");
    var param = {
      'name': _nameCtr.text,
      'product_description': _fullDesCtr.text,
      'product_price': _priceCtr.text,
      'selling_price': _sellingPriceCtr.text,
      'cat_id': category_Id.toString(),
      'sub_cat_id': subCatId.toString(),
      'child_cat_id': childCatId.toString(),
      // 'unit': _unitCtr.text,
      // 'unit_type': unitValue.toString(),
      'vid': vendorId.toString(),
      'product_id': '',
    };
    // for (var i = 0; i < (imagePathList.length ?? 0); i++) {
    //   print('Imageeeeee $imagePathList');
    //   imagePathList[i] == ""
    //       ? null
    //       : request.files.add(await http.MultipartFile.fromPath(
    //       'main_image[]', imagePathList[i].toString()));
    // }
    List<Map<String, String>> unittList = [];
    for (int i = 0; i < unit.length; i++) {
      Map<String, String> unitData = {
        'unit': unit.join(","),
      };
      unittList.add(unitData);
    }
    int k = 0;
    for (int i = 0; i < unitTypes.length; i++) {
      Map<String, String> unitTypeData = {
        'unit_type': unitTypes.join(","),
      };
      unittList.add(unitTypeData);
    }
    Map data = addMapListToData(param, unittList);
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.addProducts));
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    print("add product api parar ${request.fields} hrerer $param");
    for (var i = 0; i < (imagePathList.length ?? 0); i++) {
      print('Imageeeeee $imagePathList');
      imagePathList[i] == ""
          ? null
          : request.files.add(await http.MultipartFile.fromPath(
              'main_image[]', imagePathList[i].toString()));
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}");
      Navigator.pop(context);
      setState(() {
        isLodding = false;
      });
    } else {
      setState(() {
        isLodding = false;
      });
      print("rasponse" + response.reasonPhrase.toString());
    }
  }

  Map<String, String> addMapListToData(
      Map<String, String> data, List<Map<String, dynamic>> mapList) {
    for (var map in mapList) {
      map.forEach((key, value) {
        data[key] = value;
      });
    }
    return data;
  }

  int? selectedSateIndex;
  int? selectedchildCatIndex;
  String? selectedState;
  String? selectedSub;
  String? selectedChild;
  String? category_Id;
  String? serviceId;
  String? subCatId;
  String? childCatId;
  String? unitValue = 'Kg';
  // List<String> unitTypes = ['Kg', 'g',];
  List<String?> unitTypes = [];

  String? selectedValue;

  List<String?> unit = [''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          title: widget.isEdit == true
              ? const Text(
                  'Edit Product',
                  style: TextStyle(
                      color: colors.whiteTemp, fontWeight: FontWeight.bold),
                )
              : const Text(
                  'Add Product',
                  style: TextStyle(
                      color: colors.whiteTemp, fontWeight: FontWeight.bold),
                ),
          backgroundColor: colors.primary),
      body:
          // getBrandModel == null ? const Center(
          //     child: CircularProgressIndicator()) :
          SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Card(
            margin: const EdgeInsets.all(15),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                  Custom_Text(
                    text: 'Name',
                    text2: '*',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                      controller: _nameCtr, hintText: 'Product Name'),
                  const SizedBox(
                    height: 10,
                  ),
                  Custom_Text(
                    text: 'Price',
                    text2: '*',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                      controller: _priceCtr, hintText: 'Product Price'),
                  const SizedBox(
                    height: 10,
                  ),
                  Custom_Text(
                    text: 'Selling Price',
                    text2: '*',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                      controller: _sellingPriceCtr, hintText: 'Selling Price'),
                  const SizedBox(
                    height: 20,
                  ),
                  Custom_Text(
                    text: 'Product Description',
                    text2: '',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    maxLines: 3,
                    controller: _fullDesCtr,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Product Description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Custom_Text(
                    text: 'Category',
                    text2: ' *',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(myCategory ?? ""),
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // getCatModel == null
                  //     ? const Center(child: CircularProgressIndicator())
                  //     : SizedBox(
                  //         height: 50,
                  //         // decoration: BoxDecoration(
                  //         //     borderRadius: BorderRadius.circular(10),
                  //         //     border: Border.all(color: colors.black)
                  //         // ),
                  //         child: DropdownButton<String>(
                  //           isExpanded: true,
                  //           hint: const Text(
                  //             'Select Category',
                  //             style: TextStyle(
                  //                 color: colors.black54,
                  //                 fontWeight: FontWeight.w500,
                  //                 fontSize: 15),
                  //           ),
                  //           // dropdownColor: colors.primary,
                  //           value: category,
                  //           icon: const Padding(
                  //             padding: EdgeInsets.only(left: 10.0, top: 10),
                  //             child: Icon(
                  //               Icons.keyboard_arrow_down_rounded,
                  //               color: Colors.grey,
                  //               size: 25,
                  //             ),
                  //           ),
                  //           // elevation: 16,
                  //           style: const TextStyle(
                  //               color: colors.secondary,
                  //               fontWeight: FontWeight.bold),
                  //           underline: Padding(
                  //             padding: const EdgeInsets.only(left: 0, right: 0),
                  //             child: Container(
                  //               // height: 2,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           onChanged: (String? value) {
                  //             // This is called when the user selects an item.
                  //             setState(() {
                  //               selectedState = value!;
                  //               getCatModel!.data!.forEach((element) {
                  //                 if (element.cName == value) {
                  //                   selectedSateIndex = getCatModel!.data!.indexOf(element);
                  //                   category_Id = element.id;
                  //                   serviceId = element.serviceType;
                  //                   print("select category id is $category_Id");
                  //                   getSubCategory(category_Id!, serviceId);
                  //                 }
                  //               });
                  //             });
                  //           },
                  //           items: getCatModel!.data!.map((items) {
                  //             return DropdownMenuItem(
                  //               value: items.cName.toString(),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Padding(
                  //                     padding: const EdgeInsets.only(top: 5),
                  //                     child: Container(
                  //                       width:
                  //                           MediaQuery.of(context).size.width /
                  //                               1.42,
                  //                       child: Padding(
                  //                         padding:
                  //                             const EdgeInsets.only(top: 10),
                  //                         child: Text(
                  //                           items.cName.toString(),
                  //                           overflow: TextOverflow.ellipsis,
                  //                           style: const TextStyle(
                  //                               color: colors.text),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             );
                  //           }).toList(),
                  //         ),
                  //       ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Custom_Text(
                    text: 'Sub Category',
                    text2: '*',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(mySub! ?? ""),
                  ),
                  // getSubCatModel == null
                  //     ? SizedBox.shrink()
                  //     : Container(
                  //         height: 50,
                  //         child:
                  //         DropdownButton<String>(
                  //           isExpanded: true,
                  //           hint: const Text(
                  //             'Select Subcategory',
                  //             style: TextStyle(
                  //                 color: colors.text,
                  //                 fontWeight: FontWeight.w500,
                  //                 fontSize: 15),
                  //           ),
                  //           // dropdownColor: colors.primary,
                  //           value: selectedSub,
                  //           icon: const Padding(
                  //             padding: EdgeInsets.only(left: 10.0, top: 10),
                  //             child: Icon(
                  //               Icons.keyboard_arrow_down_rounded,
                  //               color: Colors.grey,
                  //               size: 25,
                  //             ),
                  //           ),
                  //           // elevation: 16,
                  //           style: const TextStyle(
                  //               color: colors.secondary,
                  //               fontWeight: FontWeight.bold),
                  //           underline: Padding(
                  //             padding: const EdgeInsets.only(left: 0, right: 0),
                  //             child: Container(
                  //               // height: 2,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           onChanged: (String? value) {
                  //             // This is called when the user selects an item.
                  //             setState(() {
                  //               selectedSub = value;
                  //               getSubCatModel?.data?.forEach((element) {
                  //                 if (element.cName == value) {
                  //                   selectedSateIndex = getSubCatModel!.data!.indexOf(element);
                  //                   subCatId = element.id;
                  //                   getChildCat(subCatId);
                  //                   //getStateApi();
                  //                 }
                  //               });
                  //             });
                  //           },
                  //           items: getSubCatModel!.data!.map((items) {
                  //             return DropdownMenuItem(
                  //               value: items.cName.toString(),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Padding(
                  //                     padding: const EdgeInsets.only(top: 5),
                  //                     child: Container(
                  //                       width:
                  //                           MediaQuery.of(context).size.width /
                  //                               1.42,
                  //                       child: Padding(
                  //                         padding:
                  //                             const EdgeInsets.only(top: 10),
                  //                         child: Text(
                  //                           items.cName.toString(),
                  //                           overflow: TextOverflow.ellipsis,
                  //                           style: const TextStyle(
                  //                               color: colors.text),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             );
                  //           }).toList(),
                  //         ),
                  //       ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Custom_Text(
                    text: 'Child Category',
                    text2: '*',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(myChild!.toString()),
                  ),
                  // getSubCatModel == null
                  //     ? SizedBox.shrink()
                  //     : Container(
                  //         height: 50,
                  //         child: DropdownButton<String>(
                  //           isExpanded: true,
                  //           hint: const Text(
                  //             'Select ChildCategory',
                  //             style: TextStyle(
                  //                 color: colors.text,
                  //                 fontWeight: FontWeight.w500,
                  //                 fontSize: 15),
                  //           ),
                  //           // dropdownColor: colors.primary,
                  //           value: selectedChild,
                  //           icon: const Padding(
                  //             padding: EdgeInsets.only(left: 10.0, top: 10),
                  //             child: Icon(
                  //               Icons.keyboard_arrow_down_rounded,
                  //               color: Colors.grey,
                  //               size: 25,
                  //             ),
                  //           ),
                  //           // elevation: 16,
                  //           style: const TextStyle(
                  //               color: colors.secondary,
                  //               fontWeight: FontWeight.bold),
                  //           underline: Padding(
                  //             padding: const EdgeInsets.only(left: 0, right: 0),
                  //             child: Container(
                  //               // height: 2,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           onChanged: (String? value) {
                  //             // This is called when the user selects an item.
                  //             setState(() {
                  //               selectedChild = value;
                  //               childCategoryModel!.data!.forEach((element) {
                  //                 if (element.cName == value) {
                  //                   selectedchildCatIndex =
                  //                       childCategoryModel!.data!.indexOf(element);
                  //                   childCatId = element.id;
                  //                   //getStateApi();
                  //                 }
                  //               });
                  //             });
                  //           },
                  //           items: childCategoryModel?.data?.map((items) {
                  //             return DropdownMenuItem(
                  //               value: items.cName.toString(),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Padding(
                  //                     padding: const EdgeInsets.only(top: 5),
                  //                     child: Container(
                  //                       width:
                  //                           MediaQuery.of(context).size.width /
                  //                               1.42,
                  //                       child: Padding(
                  //                         padding:
                  //                             const EdgeInsets.only(top: 10),
                  //                         child: Text(
                  //                           items.cName.toString(),
                  //                           overflow: TextOverflow.ellipsis,
                  //                           style: const TextStyle(
                  //                               color: colors.text),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             );
                  //           }).toList(),
                  //         ),
                  //       ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  // Card(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(15.0),
                  //   ),
                  //   elevation: 5,
                  //   child:  Padding(
                  //     padding: const EdgeInsets.only(left: 5, top: 5),
                  //     child: Column(
                  //       children: [
                  //         Custom_Text(
                  //           text: 'Unit',
                  //           text2: '*',
                  //         ),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //       TextFormField(
                  //         keyboardType: TextInputType.number,
                  //         cursorHeight: 25,
                  //         controller: _unitCtr,
                  //         decoration: const InputDecoration(
                  //           hintText: "Unit",
                  //           hintStyle: TextStyle(
                  //               color: Colors.grey,
                  //               fontSize: 14
                  //           ),
                  //         ),
                  //         validator:(value) {
                  //           if (value == null || value.isEmpty) {
                  //             return 'Please enter Unit .';
                  //           }
                  //           return null;
                  //         },
                  //       ),
                  //         // CustomTextFormField(controller: _unitCtr, hintText: 'Unit'),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         Custom_Text(
                  //           text: 'Unit Type',
                  //           text2: '*',
                  //         ),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         DropdownButton<String>(
                  //           isExpanded: true,
                  //           hint: const Text(
                  //             'Select Unit',
                  //             style: TextStyle(
                  //                 color: colors.text,
                  //                 fontWeight: FontWeight.w500,
                  //                 fontSize: 15),
                  //           ),
                  //           // dropdownColor: colors.primary,
                  //           value: unitValue,
                  //           icon: const Padding(
                  //             padding: EdgeInsets.only(left: 10.0, top: 5),
                  //             child: Icon(
                  //               Icons.keyboard_arrow_down_rounded,
                  //               color: Colors.grey,
                  //               size: 25,
                  //             ),
                  //           ),
                  //           // elevation: 16,
                  //           style: const TextStyle(
                  //               color: colors.secondary,
                  //               fontWeight: FontWeight.bold),
                  //           underline: Padding(
                  //             padding: const EdgeInsets.only(left: 0, right: 0),
                  //             child: Container(
                  //               // height: 2,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           onChanged: (String? value) {
                  //             // This is called when the user selects an item.
                  //             setState(() {
                  //               unitValue = value;
                  //             });
                  //           },
                  //           items: unitTypes.map((items) {
                  //             return DropdownMenuItem(
                  //               value: items.toString(),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Padding(
                  //                     padding: const EdgeInsets.only(top: 5),
                  //                     child: Container(
                  //                       width:
                  //                       MediaQuery.of(context).size.width/1.42,
                  //                       child: Padding(
                  //                         padding:
                  //                         const EdgeInsets.only(top: 5),
                  //                         child: Text(
                  //                           items.toString(),
                  //                           overflow: TextOverflow.ellipsis,
                  //                           style: const TextStyle(
                  //                               color: colors.text),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             );
                  //           }).toList(),
                  //         ),
                  //         const Divider(color: Colors.grey,),
                  //         Container(
                  //           height: 30,
                  //           width: 40,
                  //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color:colors.primary),
                  //           child: Positioned(
                  //             top: 0,
                  //             // right: 65,
                  //             child: InkWell(
                  //               onTap: () {
                  //                 setState(() {
                  //                   unit.add("");
                  //                   unitType.add("kg");
                  //                 });
                  //               },
                  //               child: const Icon(
                  //                 Icons.add,
                  //                 size: 30,
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         const SizedBox(height: 5,),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  widget.isEdit == true
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              productData!.products[0].productUnits.length,
                          itemBuilder: (context, j) {
                            return editUnit(j);
                          },
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: unit.length,
                          itemBuilder: (context, index) {
                            return addonUnit(index);
                          },
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.only(top: 10, left: 6),
                  //   child: Text(
                  //     "Product Image",
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.bold, color: colors.text),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     imageCode = 1;
                  //     getImageGallery();
                  //   },
                  //   child: Card(
                  //     child: Container(
                  //       height: 140,
                  //       width: MediaQuery.of(context).size.width/1.2,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         color: Colors.white,
                  //         // image: DecorationImage(image:FileImage(_image!.absolute) )
                  //       ),
                  //       child: _image != null
                  //           ? Image.file(
                  //         _image!.absolute,
                  //         fit: BoxFit.fill,
                  //       )
                  //           : Icon(
                  //         Icons.file_upload_outlined,
                  //         color: colors.secondary,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 20,),
                  // Custom_Text(text: 'Short Description', text2: ' *',),
                  // SizedBox(height: 15,),
                  // TextFormField(
                  //   maxLines: 3,
                  //   controller: _shortDesCtr,
                  //   decoration: const InputDecoration(
                  //     contentPadding: EdgeInsets.symmetric(
                  //         vertical: 10, horizontal: 10),
                  //     border: OutlineInputBorder(),
                  //     hintStyle: TextStyle(color: Colors.grey),
                  //     hintText: 'Product Short Description',
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter Product Short Description .';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // SizedBox(height: 20,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     Custom_Text(text: 'Tags', text2: ' *',),
                  //     const Text('(These tags help you in search result )',
                  //       style: TextStyle(fontSize: 12),)
                  //   ],
                  // ),
                  // SizedBox(height: 10,),
                  // TextFormField(
                  //   controller: tagC,
                  //   decoration: const InputDecoration(
                  //     hintText: 'Type in some tags for example AC,Cooler,Flagship Smartphone,Mobiles,Sport Shose ect',
                  //     hintStyle: TextStyle(color: Colors.grey),
                  //     //
                  //     // contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  //     // border: OutlineInputBorder(),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter tags .';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // Divider(color: Colors.grey,),
                  // SizedBox(height: 20,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     Custom_Text(text: 'Main Image', text2: ' *',),
                  //     const SizedBox(width: 20,),
                  //     SizedBox(
                  //       width: MediaQuery
                  //           .of(context)
                  //           .size
                  //           .width / 2.8,
                  //       child: const Text(' (Recommended Size: 180 x 180 pixels)',
                  //         style: TextStyle(fontSize: 12),),
                  //     )
                  //   ],
                  // ),
                  // const SizedBox(height: 20),
                  // InkWell(
                  //   onTap: () async {
                  //     // showExitPopup1();
                  //     var result = await Navigator.push(
                  //         context, MaterialPageRoute(
                  //         builder: (context) => Media(from: 'main',)));
                  //     if (result != null) {
                  //       setState(() {
                  //         productImageUrl1 = result;
                  //       });
                  //     }
                  //   },
                  //   child: Container(
                  //     width: 100,
                  //     color: colors.primary,
                  //     height: productImageUrl1 == null ? 50 : 100,
                  //     child: productImageUrl1 == null || productImageUrl1 == ""
                  //         ? const Center(
                  //         child: Text("Upload ",
                  //           style: TextStyle(color: Colors.white),))
                  //         : Column(
                  //       children: [
                  //         ClipRRect(
                  //           borderRadius: BorderRadius.circular(0),
                  //           child: Image.network(
                  //             productImageUrl1!,
                  //             height: 100,
                  //             width: 100,
                  //             fit: BoxFit.fill,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Custom_Button(text: 'Update',onPressed: (){_showImagePicker(context);},),
                  // SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     Custom_Text(text: 'Other Image', text2: '',),
                  //     const SizedBox(width: 20,),
                  //     SizedBox(
                  //       width: MediaQuery
                  //           .of(context)
                  //           .size
                  //           .width / 2.8,
                  //       child: const Text(
                  //         ' (Recommended Size: 180 x 180 pixels)',
                  //         style: TextStyle(fontSize: 12),),
                  //     )
                  //   ],
                  // ),
                  // const SizedBox(height: 20),
                  // InkWell(
                  //   onTap: () async {
                  //     otherImageList.clear();
                  //     //  showExitPopup2();
                  //     List <String> result = await Navigator.push(
                  //         context, MaterialPageRoute(
                  //         builder: (context) => Media(from: 'other',)));
                  //     if (result != null) {
                  //       setState(() {
                  //         otherImageList = result;
                  //       });
                  //     }
                  //   },
                  //   child: Container(
                  //       color:
                  //       otherImageList.isEmpty ?
                  //       colors.primary : Colors.white,
                  //       height: otherImageList.isEmpty ? 50 : 100,
                  //       child: otherImageList == null || otherImageList.isEmpty
                  //           ? const Center(
                  //           child: Text("Upload ",
                  //             style: TextStyle(color: Colors.white),))
                  //           : ListView.builder(scrollDirection: Axis.horizontal,
                  //         itemCount: otherImageList.length,
                  //
                  //         itemBuilder: (context, index) {
                  //           return
                  //             Padding(
                  //               padding: const EdgeInsets.only(right: 10),
                  //               child: ClipRRect(
                  //                 borderRadius: BorderRadius.circular(0),
                  //                 child: Image.network(
                  //                   'https://developmentalphawizz.com/B2B${otherImageList[index]}',
                  //                   height: 100,
                  //                   width: 100,
                  //                   fit: BoxFit.fill,
                  //                 ),
                  //               ),
                  //             );
                  //         },)
                  //   ),
                  // ),
                  // SizedBox(height: 20),
                  // InkWell(
                  //   onTap: () async {
                  //     // showExitPopup3();
                  //     var result = await Navigator.push(
                  //         context, MaterialPageRoute(
                  //         builder: (context) => Media(from: 'Broncherimage',)));
                  //     if (result != null) {
                  //       setState(() {
                  //         broncherImageUrl1 = result.toString();
                  //       });
                  //     }
                  //   },
                  //   child: Container(
                  //     width: 100,
                  //     color: colors.primary,
                  //     height: broncherImageUrl1 == null ? 50 : 100,
                  //     child: broncherImageUrl1 == null || broncherImageUrl1 == ""
                  //         ? const Center(
                  //         child: Text("Upload ",
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //     )
                  //         : Column(
                  //       children: [
                  //         ClipRRect(
                  //           borderRadius: BorderRadius.circular(0),
                  //           child: Image.network(
                  //             broncherImageUrl1!,
                  //             height: 100,
                  //             width: 100,
                  //             fit: BoxFit.fill,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 20,),
                  // Custom_Text(text: 'Video Type', text2: '',),
                  // SizedBox(height: 10,),
                  // DropdownButtonFormField<String>(
                  //   value: videoType,
                  //   decoration: const InputDecoration(
                  //     contentPadding:
                  //     EdgeInsets.only(left: 20),
                  //   ),
                  //   hint: Text('None', style: TextStyle(color: Colors.grey),),
                  //   icon: Icon(
                  //     Icons.keyboard_arrow_down_sharp, color: Colors.grey,),
                  //   items: videoList.map((String item) {
                  //     return DropdownMenuItem<String>(
                  //       value: item,
                  //       child: Text(item),
                  //     );
                  //   }).toList(),
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       videoType = newValue!;
                  //       if (newValue == 'Youtube') {
                  //         videoLinkindex = 1;
                  //         print(newValue);
                  //       }
                  //       if (newValue != 'Youtube') {
                  //         videoLinkindex = 0;
                  //       }
                  //     });
                  //   },
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please select an option';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // (videoLinkindex == 1) ? Container(
                  //   child: Column(
                  //     children: [
                  //       SizedBox(height: 15,),
                  //       Custom_Text(text: 'Video Link', text2: ' *',),
                  //       CustomTextFormField(controller: _videoLink,
                  //         hintText: 'Paste Youtube/video link',),
                  //       SizedBox(height: 15,),
                  //     ],
                  //   ),
                  // ) // CustomTextFormField(controller: _videoLink,hintText: 'Paste Youtube/video link',);
                  //     : Container(),
                  // SizedBox(height: 20,),
                  // Column(
                  //   children: [
                  //     Container(
                  //       height: 150,
                  //       child: ListView.builder(
                  //           itemCount: controllersOfController.length,
                  //           itemBuilder: (context, index) =>
                  //               Padding(
                  //                 padding: const EdgeInsets.only(top: 8.0),
                  //                 child: Row(
                  //                   children: [
                  //                     Expanded(
                  //                       child: Container(
                  //                         height: 45,
                  //                         decoration: BoxDecoration(
                  //                             borderRadius: BorderRadius
                  //                                 .circular(5),
                  //                             border: Border.all()
                  //                         ),
                  //                         child: TextFormField(
                  //                           controller: controllersOfController[index][0],
                  //                           decoration: const InputDecoration(
                  //                               contentPadding: EdgeInsets.only(
                  //                                   left: 5),
                  //                               hintText: 'Title',
                  //                               border: InputBorder.none
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     const SizedBox(width: 5,),
                  //                     Expanded(
                  //                       child: Container(
                  //                         height: 45,
                  //                         decoration: BoxDecoration(
                  //                             borderRadius: BorderRadius
                  //                                 .circular(5),
                  //                             border: Border.all()
                  //                         ),
                  //                         child: TextFormField(
                  //                           controller: controllersOfController[index][1],
                  //                           decoration: const InputDecoration(
                  //                               contentPadding: EdgeInsets.only(
                  //                                   left: 5),
                  //                               hintText: 'Value',
                  //                               border: InputBorder.none
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //       ),
                  //     ),
                  //     Btn(
                  //       height: 45,
                  //       title: "Add",
                  //       onPress: () {
                  //         addToMyList();
                  //         List<TextEditingController> controlle1 = [];
                  //         controlle1.add(TextEditingController());
                  //         controlle1.add(TextEditingController());
                  //         controllersOfController.add(controlle1);
                  //         print('_____ssas_____${myList.join(', ')}_________');
                  //         setState(() {
                  //           // addData(controller1, controller2);
                  //         });
                  //       },
                  //     )
                  //   ],
                  // ),
                  const SizedBox(height: 10),
                  // widget.isEdit == true ?
                  // uploadMultiImmageEdit():
                  uploadMultiImmage(),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Btn(
                        height: 50,
                        width: 150,
                        title: isLodding
                            ? "please wait..."
                            :
                            // widget.isEdit == true ?
                            "Add Product",
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            if (imagePathList.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please Select Images");
                            } else {
                              addProductApi();
                            }
                            // widget.isEdit == true ?
                            // : editProductApi();
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  editUnit(int j) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, top: 5),
        child: Column(
          children: [
            Custom_Text(
              text: 'Unit(Price)',
              text2: '*',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  // unit[j] = value;
                });
              },
              // initialValue : unit[j],
              keyboardType: TextInputType.text,
              cursorHeight: 25,
              // controller: _unitCtr,
              decoration: InputDecoration(
                hintText: "${productData?.products.first.productUnits[j].unit}",
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Unit .';
                }
                return null;
              },
            ),
            // CustomTextFormField(controller: _unitCtr, hintText: 'Unit'),
            const SizedBox(
              height: 10,
            ),
            Custom_Text(
              text: 'Unit Type',
              text2: '*',
            ),
            const SizedBox(
              height: 10,
            ),
            // DropdownButton<String?>(
            //   isExpanded: true,
            //   hint: const Text(
            //     'Select Unit',
            //     style: TextStyle(
            //         color: colors.text,
            //         fontWeight: FontWeight.w500,
            //         fontSize: 15),
            //   ),
            //   // dropdownColor: colors.primary,
            //   value: unitType[j],
            //   icon: const Padding(
            //     padding: EdgeInsets.only(left: 10.0, top: 5),
            //     child: Icon(
            //       Icons.keyboard_arrow_down_rounded,
            //       color: Colors.grey,
            //       size: 25,
            //     ),
            //   ),
            //   // elevation: 16,
            //   style: const TextStyle(
            //       color: colors.secondary,
            //       fontWeight: FontWeight.bold),
            //   underline: Padding(
            //     padding: const EdgeInsets.only(left: 0, right: 0),
            //     child: Container(
            //       // height: 2,
            //       color: Colors.white,
            //     ),
            //   ),
            //   onChanged: (String? value) {
            //     print("=====unit typee is ==========${unitType[j]}===========");
            //     // This is called when the user selects an item.
            //     setState(() {
            //       unitType[j] = value ?? unitType[j] ;
            //     });
            //   },
            //   items: unitTypes.map((items) {
            //     return DropdownMenuItem(
            //       value: items.toString(),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.only(top: 5),
            //             child: Container(
            //               width:
            //               MediaQuery.of(context).size.width/1.42,
            //               child: Padding(
            //                 padding:
            //                 const EdgeInsets.only(top: 5),
            //                 child: Text(
            //                   items.toString(),
            //                   overflow: TextOverflow.ellipsis,
            //                   style: const TextStyle(
            //                       color: colors.text),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     );
            //   }).toList(),
            // ),
            const Divider(
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: colors.primary),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        unit.add("");
                        unitTypes.add("Kg");
                      });
                    },
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: colors.primary),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          unit.remove("");
                          unitTypes.last;
                        });
                      },
                      child: const Icon(
                        Icons.remove,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  addonUnit(int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, top: 5),
        child: Column(
          children: [
            Custom_Text(
              text: 'Unit(Price)',
              text2: '*',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  unit[index] = value;
                });
              },
              initialValue: unit[index],
              keyboardType: TextInputType.text,
              cursorHeight: 25,
              // controller: _unitCtr,
              decoration: const InputDecoration(
                hintText: "Unit",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Unit .';
                }
                return null;
              },
            ),
            // CustomTextFormField(controller: _unitCtr, hintText: 'Unit'),
            const SizedBox(
              height: 10,
            ),
            Custom_Text(
              text: 'Unit Type',
              text2: '*',
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButton(
              isExpanded: true,
              value: unitTypes[index],
              hint: Text('Select Unit'),
              icon: Icon(Icons.keyboard_arrow_down),
              items: unitList.map((items) {
                return DropdownMenuItem(
                  value: items.name,
                  child: Container(child: Text(items.name.toString())),
                );
              }).toList(),
              onChanged: (dynamic value) {
                print("unit select value $value");
                setState(() {
                  unitTypes[index] = value;
                });
              },
              underline: Container(),
            ),
            // DropdownButton<Unitdata>(
            //   isExpanded: true,
            //   hint: const Text(
            //     'Select Unit',
            //     style: TextStyle(
            //         color: colors.text,
            //         fontWeight: FontWeight.w500,
            //         fontSize: 15),
            //   ),
            //   // dropdownColor: colors.primary,
            //   value: unitType[index],
            //   icon: const Padding(
            //     padding: EdgeInsets.only(left: 10.0, top: 5),
            //     child: Icon(
            //       Icons.keyboard_arrow_down_rounded,
            //       color: Colors.grey,
            //       size: 25,
            //     ),
            //   ),
            //   // elevation: 16,
            //   style: const TextStyle(
            //       color: colors.secondary,
            //       fontWeight: FontWeight.bold),
            //   underline: Padding(
            //     padding: const EdgeInsets.only(left: 0, right: 0),
            //     child: Container(
            //       // height: 2,
            //       color: Colors.white,
            //     ),
            //   ),
            //   onChanged: (dynamic value) {
            //     print("=====unit typee is ==========${unitType[index]}===========");
            //     // This is called when the user selects an item.
            //     setState(() {
            //       unitType[index] = value ?? unitType[index] ;
            //     });
            //   },
            //   items: unitTypes.data.map((items) {
            //     return DropdownMenuItem(
            //       value: items.toString(),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.only(top: 5),
            //             child: Container(
            //               width:
            //               MediaQuery.of(context).size.width/1.42,
            //               child: Padding(
            //                 padding:
            //                 const EdgeInsets.only(top: 5),
            //                 child: Text(
            //                   items.toString(),
            //                   overflow: TextOverflow.ellipsis,
            //                   style: const TextStyle(
            //                       color: colors.text),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     );
            //   }).toList(),
            // ),
            const Divider(color: Colors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: colors.primary),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        unit.add("");
                        unitTypes.add(selectedValue);
                      });
                    },
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                unit.length == 1
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: colors.primary),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                unit.remove("");
                                unitTypes.last;
                              });
                            },
                            child: const Icon(
                              Icons.remove,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget uploadMultiImmageEdit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () async {
            if (count <= 3) {
              pickImageDialog(context, 1);
            }
            // await pickImages();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 145,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colors.primary),
                child: const Center(
                  child: Text(
                    "Upload Images",
                    style: TextStyle(
                        color: colors.whiteTemp,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ),
              // SizedBox(height: 5,),
              // const Text("You Can Select Only 4 Imgaes", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),)
            ],
          ),
        ),
        const SizedBox(height: 10),
        buildGridViewEdit(),
      ],
    );
  }

  Widget uploadMultiImmage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () async {
            if (count <= 3) {
              pickImageDialog(context, 1);
            }
            // await pickImages();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 145,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colors.primary),
                child: const Center(
                  child: Text(
                    "Upload Images",
                    style: TextStyle(
                        color: colors.whiteTemp,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              const Text(
                "You Can Select Only 4 Imgaes",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        Visibility(visible: isImages, child: buildGridView()),
      ],
    );
  }

  Widget buildGridViewEdit() {
    return Container(
      height: 270,
      child: GridView.builder(
        itemCount: productData!.products.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colors.primary)),
                  width: MediaQuery.of(context).size.width / 2.8,
                  height: 170,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Image.network(
                        productData!.products.first.otherImage[index],
                        fit: BoxFit.cover,
                      )
                      // Image.file(File(productData!.products.first.otherImage[index]), fit: BoxFit.cover),
                      ),
                ),
              ),
              Positioned(
                left: 109,
                // bottom: 10,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      imagePathList.remove(imagePathList[index]);
                      count--;
                    });
                  },
                  child: Icon(
                    Icons.remove_circle,
                    size: 30,
                    color: Colors.red.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildGridView() {
    return Container(
      height: 270,
      child: GridView.builder(
        itemCount: imagePathList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colors.primary)),
                  width: MediaQuery.of(context).size.width / 2.8,
                  height: 170,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image.file(File(imagePathList[index]),
                        fit: BoxFit.contain),
                  ),
                ),
              ),
              Positioned(
                left: 109,
                // bottom: 10,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      imagePathList.remove(imagePathList[index]);
                      count--;
                    });
                  },
                  child: Icon(
                    Icons.remove_circle,
                    size: 30,
                    color: Colors.red.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void pickImageDialog(BuildContext context, int i) async {
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  _getFromGallery();
                },
                child: Container(
                  child: ListTile(
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.image,
                      color: colors.primary,
                    ),
                  ),
                ),
              ),
              Container(
                width: 200,
                height: 1,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () async {
                  _getFromCamera();
                  // getImage(ImgSource.Camera, context, i);
                },
                child: Container(
                  child: ListTile(
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: colors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  File? _imageFile;

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        count++;
        _imageFile = File(pickedFile.path);
        imagePathList.add(_imageFile?.path ?? "");
        isImages = true;
      });
      Navigator.pop(context);
    }
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        count++;
        _imageFile = File(pickedFile.path);
        imagePathList.add(_imageFile?.path ?? "");
        isImages = true;
      });
      Navigator.pop(context);
    }
  }

  List imagePathList = [];
  bool isImages = false;
  Future<void> getFromGallery() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      allowCompression: true,
    );
    if (result != null) {
      setState(() {
        isImages = true;
        // servicePic = File(result.files.single.path.toString());
      });
      imagePathList = result.paths.toList();
      // imagePathList.add(result.paths.toString()).toList();
      print("Sproduct image === $imagePathList");
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      // User canceled the picker
    }
  }

  TextEditingController tagC = TextEditingController();

  addData(TextEditingController controller1, controller2) {
    return rows.add(Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), border: Border.all()),
              child: TextFormField(
                controller: controller1,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 5),
                    hintText: 'Title ',
                    border: InputBorder.none),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), border: Border.all()),
              child: TextFormField(
                controller: controller2,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 5),
                    hintText: 'Value',
                    border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  List<Widget> textFormFields = [];
  List<Widget> rows = [];
  List<List<TextEditingController>> controllersOfController = [];

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  TextEditingController nameC = TextEditingController();

  bool isLodding = false;
  // addProductApi() async {
  //   setState(() {
  //     isLodding = true;
  //   });
  //   var headers = {
  //     'Cookie': 'ci_session=cab7ed449e294e8cd139fc530309156a2468b1d0'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse(
  //       '${baseUrl}add_products'));
  //   request.fields.addAll({
  //     'seller_id': userId.toString(),
  //     'pro_input_name':_nameCtr.text,
  //     'short_description':_shortDesCtr.text,
  //     'tags': tagC.text,
  //     'pro_input_tax': 'tax_id',
  //     'indicator': '1',
  //     'made_in': 'ind',
  //     'hsn_code': '456',
  //     'brand': selectBrand ?? 'adidas',
  //     'total_allowed_quantity': '100',
  //     'minimum_order_quantity': '12',
  //     'quantity_step_size': '1',
  //     'warranty_period': '1 month',
  //     'guarantee_period': '1 month',
  //     'deliverable_type': '1',
  //     'deliverable_zipcodes': '1,2,3',
  //     'is_prices_inclusive_tax': '0',
  //     'cod_allowed': '1',
  //     'categorys_id': stateId ?? '1',
  //     'sub_cat_id': subCatId ?? '1',
  //     'product_type': 'simple_type',
  //     'pro_input_image': productImageUrl1?.split('B2B')[1] ?? '',
  //     'other_images': otherImageList.join(','),
  //     'attribute_values': '1',
  //     'simple_price': '4',
  //     'simple_special_price': '2',
  //     'attribute_title': myList.join(','),
  //     'attribute_value': myList.join(','),
  //     'short_description':_fullDesCtr.text,
  //     'description':_fullDesCtr.text,
  //     'extra_input_description':_extraDesCtr.text
  //   });
  //   print("------this ------------>${request.fields}");
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     otherImageList.clear();
  //     selectedSubCategory = null;
  //     productImageUrl1 = null;
  //     broncherImageUrl1 = null;
  //     getSubCatModel = null;
  //     var result = await response.stream.bytesToString();
  //     var finalResult = jsonDecode(result);
  //     Fluttertoast.showToast(msg: "${finalResult['message']}");
  //
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>B2BHome()));
  //
  //     setState(() {
  //       isLodding = false;
  //     });
  //   }
  //
  //   else {
  //     setState(() {
  //       isLodding = false;
  //     });
  //     print(response.reasonPhrase);
  //   }
  // }
  //
  // addMedia() async {
  //   var headers = {
  //     'Cookie': 'ci_session=132520c09b577cf52b95da927b9b0491da5d3bda'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}upload_media'));
  //   request.files.add(await http.MultipartFile.fromPath('documents[]', '/C:/Users/indian 5/Downloads/no-image-icon.png'));
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var result = await response.stream.bytesToString();
  //     var finalResult =  jsonDecode(result);
  //
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  //
  // }
  // List<String> myList = [];

  // void addToMyList() {
  //   //  String text = controller1.text;
  //   for (int i=0;i<controllersOfController.length ; i++) {
  //     controllersOfController[i].forEach((element) {
  //       myList.add(element.text);
  //     });
  //   }
  // }

  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    super.dispose();
    _nameCtr.dispose();
    _shortDesCtr.dispose();
    _fullDesCtr.dispose();
    _extraDesCtr.dispose();
    _videoLink.dispose();
    print("---66---77---88---99");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // myCategory=prefs.get('category') as String?;
    // mySub=prefs.get('sub') as String?;
    // myChild=prefs.get('child') as String?;

    prefs.remove('category'); //only
    prefs.remove('sub'); //only
    prefs.remove('child'); //only
  }
}
