import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../Helper/color.dart';
import '../Model/createonlineImageModel.dart';
import '../Model/createonlineModel.dart';


class CreateOnlineStore extends StatefulWidget {
  const CreateOnlineStore({Key? key}) : super(key: key);

  @override
  State<CreateOnlineStore> createState() => _CreateOnlineStoreState();
}

class _CreateOnlineStoreState extends State<CreateOnlineStore> {
  int selectedCheckboxIndex = -1; // To track the selected checkbox

  var index=0;

  var data1=[];
  CreateonlineModel? createOnlineModel;
  CreateonlineImageModel?  createonlineImageModel;
  List<bool> selectedItems = List.generate(15, (index) => false);
  Future<void> fetchData() async {
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/hojayega/Vendorapi/get_categories_by_shop_services?roll=2'));
    request.fields.addAll({
      'roll':'2'
    });

    //request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('aaa11');
      var result = await response.stream.bytesToString();
      var finalResult =  CreateonlineImageModel.fromJson(json.decode(result));
      setState(() {
        createonlineImageModel = finalResult;
        print("images is s ${finalResult} ${createonlineImageModel?.data?.first.img}");
      });
    }
    else {
      print('bbb22');
      print(response.reasonPhrase);
    }

  }


  List<CreateonlineModel> userList = [];
  Future<void> getdata ()async{
    var headers = {
      'Cookie': 'ci_session=75640c7ceba16b47ad9a9ac9d5aee2abffd0c21b'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/hojayega/Vendorapi/type_shops?type=services'));
    request.fields.addAll({
      'type': 'services'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('aaa');
      var result = await response.stream.bytesToString();
      var finalResult = CreateonlineModel.fromJson(json.decode(result));
      setState(() {
        createOnlineModel = finalResult;
        print("data is ${finalResult} ${createOnlineModel?.data?.first.name}");
      });
    }
    else {
      print('bb');
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            child: Form(
              key: _formKey,
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
                    height: 30,
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
                                  maxRadius: 8,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "What kind of Shop Do You Deal In ?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: colors.primary),
                                ),
                              ],
                            ),
                            const Text(
                              "You can select a maximum of 3 if you deal in multiple products in your shop",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: colors.primary,
                                  fontSize: 8),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 30,
                              decoration: BoxDecoration(border: Border.all(color:colors.primary),borderRadius: BorderRadius.circular(5)),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: createOnlineModel!.data!.length,
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
                                        activeColor: colors.primary,
                                      ),
                                      Text(
                                        createOnlineModel!.data![index].name.toString(),
                                        style: TextStyle(color: colors.primary),
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
                                  maxRadius: 8,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Select category's",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: colors.primary),
                                ),
                              ],
                            ),

                            Container(
                             width: double.infinity, // adjust width if needed
                             height: 500, // adjust height if needed
                              child:GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 3,
                                    childAspectRatio: 2 / 2.4
                                ),
                                itemCount: createonlineImageModel!.data!.length,
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
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Image.network("https://developmentalphawizz.com/hojayega/${createonlineImageModel!.data![index].img.toString()}")
                                            ),
                                            Text( createonlineImageModel!.data![index].cName.toString(),)
                                          ],
                                        ),
                                      ),
                                      if (selectedItems[index])
                                        Container(
                                          margin: EdgeInsets.all(10),
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

                            SizedBox(height: 10,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                CircleAvatar(
                                  child: Text(
                                    '5',
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
                                  "How Many Clients You Can Server At Same \nTime?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: colors.primary),
                                ),
                              ],
                            ),
                            SizedBox(height: 8,),
                            Container(
                              decoration: BoxDecoration(border: Border.all(color: colors.primary),borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required Details';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
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
                                SizedBox(
                                  width: 30,
                                ),

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
                           // SizedBox(height: 8,),
                           //  Row(
                           //    children: [
                           //
                           //      Container(
                           //        decoration: BoxDecoration(border: Border.all(color: colors.primary),borderRadius: BorderRadius.circular(10)),
                           //        child: TextFormField(
                           //          decoration: InputDecoration(
                           //            border: InputBorder.none,
                           //          ),
                           //        ),
                           //      ),
                           //    ],
                           //  ),
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

                               // SizedBox(width: 5,),
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

                            Row(
                              children: const [
                                CircleAvatar(
                                  child: Text(
                                    '6',
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
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),

                            Center(
                              child: InkWell(
                                onTap: (){
                                  getdata();
                                  fetchData();
                                 },
                                child: Container(
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.secondary),
                                  child: const Center(
                                    child: Text(
                                      'Next',
                                      style: TextStyle(color: Colors.white),
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
      ),
    );
  }
}

// class MyGridView extends StatefulWidget {
//   @override
//   _MyGridViewState createState() => _MyGridViewState();
// }

// class MyGridView extends StatefulWidget {
//   @override
//   _MyGridViewState createState() => _MyGridViewState();
// }
//
// class _MyGridViewState extends State<MyGridView> {
//   List<bool> selectedItems = List.generate(15, (index) => false);
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         mainAxisSpacing: 3,
//           childAspectRatio: 2 / 2.4
//       ),
//       itemCount: 15,
//       itemBuilder: (BuildContext context, int index) {
//         return Stack(
//           alignment: Alignment.topLeft,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   selectedItems[index] = !selectedItems[index];
//                 });
//               },
//               child: Column(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(10),
//
//                     ),
//                     // width: 100.0,
//                     // height: 100.0,
//                     child: Image.asset(
//                       "assets/images/imgpsh_fullsize_anim.png",
//                      // fit: BoxFit.,
//                     ),
//                   ),
//                   Text("bb")
//                 ],
//               ),
//             ),
//             if (selectedItems[index])
//               Container(
//                 margin: EdgeInsets.all(10),
//               //  padding: EdgeInsets.all(2),
//                 decoration: BoxDecoration(
//                   color: colors.secondary,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(
//                   Icons.check,
//                   color: Colors.white,
//                   size: 15,
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }
// }
