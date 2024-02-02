import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hojayega_seller/Screen/BusinessCard.dart';
import 'package:hojayega_seller/Screen/DeliveryCard.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../AuthView/Login.dart';
import '../Helper/api.path.dart';
import '../Helper/color.dart';
import 'Calender.dart';
import 'Orders.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Homepageimagemodel? homepageimagemodel;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    getSetting();
    getBanner();
  }

  int _pageIndex = 0;

  Future<void> getBanner() async {
    var response = await http.get(Uri.parse(ApiServicves.getBanners));
    if (response.statusCode == 200) {
      setState(() {
        homepageimagemodel =
            Homepageimagemodel.fromJson(json.decode(response.body));
      });
    } else {
      print('image not found');
    }
  }

  var arrNames = ['Manage\nAds', 'Reports', 'Pick\n & \nDrop', 'Track \nOrder'];
  var iconsNames = [
    'assets/images/Manageads.png',
    'assets/images/Reports.png',
    'assets/images/Pickdrop.png',
    'assets/images/trackorder.png'
  ];
  final List<Order> orders = [
    Order('10:00 to 12:00 pm', 'Indore', 'Pending'),
    Order('10:00 to 12:00 pm', 'Ujjain', 'Approved'),
    // Order('10:00 to 12:00 pm', 'Bhopal', 'Approved'),
    // Add more orders as needed
  ];

  List<Map<String, String>> imageList = [
    {"id": "1", "image_path": 'assets/images/c1.jpg'},
    {"id": "2", "image_path": 'assets/images/c2.jpg'},
    {"id": "3", "image_path": 'assets/images/c3.jpg'},
  ];

  // final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  Widget headerCell(String text) {
    return Container(
      height: 32,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget dataCell(String text) {
    return Container(
      height: 50,
      child: Center(child: Text(text)),
    );
  }

  Widget statusCell(String status) {
    Color textColor = Colors.black;
    if (status == 'Pending') {
      textColor = Colors.red; // Replace with your color for pending status
    } else if (status == 'Approved') {
      textColor = Colors.green; // Replace with your color for approved status
    }
    return Container(
      height: 50,
      // width: 0,
      child: Center(
        child: Text(
          status,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  String? card_limit;
  getSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=bfa970b6e13a45a52775a4cd4995efa6026d6895'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getSettings));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finaResult = jsonDecode(result);
      print("responseee $finaResult");
      if (finaResult['status'] == 1) {
        card_limit = finaResult['setting']['cart_limit'];
        await prefs.setString(
            'card_limit', finaResult['setting']['cart_limit'].toString());
        print('____credit data limit is$card_limit ___');
        setState(() {});
        // Fluttertoast.showToast(msg: '${finaResult['message']}');
      } else {
        // Fluttertoast.showToast(msg: "${finaResult['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colors.appbarColor,
      // appBar: AppBar(
      //   leading: Container(
      //     decoration: BoxDecoration(
      //         color: Colors.white, borderRadius: BorderRadius.circular(10)),
      //     margin: EdgeInsets.all(8), // Adjust padding inside container
      //     child: IconButton(
      //       icon: Icon(Icons.menu), // Drawer icon
      //       onPressed: () => _scaffoldKey.currentState?.openDrawer(),
      //     ),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: colors.primary,
      //   foregroundColor: Colors.white, //(0xff112C48),
      //   iconTheme: IconThemeData(color: colors.secondary),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Container(
      //         height: 30,
      //         width: 50,
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10), color: Colors.white),
      //         child: IconButton(
      //           icon: const Icon(Icons.notifications),
      //           onPressed: () {
      //             // Add your notification icon tap logic here
      //           },
      //         ),
      //       ),
      //     ),
      //     const SizedBox(
      //       width: 8,
      //     ),
      //     const CircleAvatar(
      //       backgroundColor: colors.whiteTemp,
      //       maxRadius: 20,
      //       child: Icon(Icons.person, color:colors.primary,)
      //     ),
      //     const SizedBox(
      //       width: 15,
      //     ),
      //   ],
      // ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   color: colors.primary,
      //   height: 70,
      //   backgroundColor: colors.appbarColor,
      //   items: const <Widget>[
      //     Icon(Icons.home,color: colors.whiteTemp),
      //     Icon(Icons.list,color: colors.whiteTemp),
      //     Icon(Icons.production_quantity_limits_sharp,color: colors.whiteTemp),
      //     Icon(Icons.watch_later,color: colors.whiteTemp),
      //   ],
      //   onTap: (index1) {
      //     //Handle button tap
      //     setState(() {
      //       _pageIndex = index1;
      //       // Navigator.push(context, MaterialPageRoute(builder: (context) => Orders()));
      //     });
      //   },
      // ),
      // drawer: Drawer(
      //   child: ListView(
      //       children: [
      //      DrawerHeader(
      //       decoration: const BoxDecoration(
      //         // border: Border(bottom: BorderSide(color: Colors.black)),
      //           gradient: LinearGradient(
      //               begin: Alignment.centerLeft,
      //               end: Alignment.centerRight,
      //               colors: [colors.primary, colors.primary])),
      //       child: Row(
      //         children: [
      //           const SizedBox(
      //             width: 10,
      //           ),
      //           const CircleAvatar(
      //             backgroundImage: AssetImage(
      //               "assets/images/bike.png",
      //             ),
      //             radius: 40,
      //           ),
      //           const SizedBox(
      //             width: 10,
      //           ),
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               const Text(
      //                 'Hello!',
      //                 style: TextStyle(
      //                     fontSize: 24,
      //                     fontWeight: FontWeight.bold,
      //                     color: Colors.white),
      //               ),
      //               vendor_name == null || vendor_name == ""
      //                   ? const Text(
      //                 'Demo',
      //                 style: TextStyle(fontSize: 16, color: Colors.white),
      //                 ): Text(
      //                 '$vendor_name',
      //                 style: TextStyle(fontSize: 16, color: Colors.white),
      //               ),
      //             ],
      //           )
      //         ],
      //       ),
      //     ),
      //     InkWell(
      //       onTap: () {
      //         // Navigator.push(
      //         //   context,
      //         //   MaterialPageRoute(builder: (context) => const  myprofile_screen()),
      //         // );
      //         setState(() {
      //           currentIndex = 1;
      //         });
      //       },
      //       child: DrawerIconTab(
      //         titlee: 'Home',
      //         icon: Icons.home,
      //         tabb: 1,
      //         indexx: currentIndex,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 5,
      //     ),
      //     InkWell(
      //         onTap: () {
      //           // Navigator.push(
      //           //   context,
      //           //   MaterialPageRoute(
      //           //       builder: (context) => const  OfferJobWidget()),
      //           // );
      //           setState(() {
      //             currentIndex = 2;
      //           });
      //         },
      //         child: DrawerIconTab(
      //             titlee: 'My favorite',
      //             icon: Icons.file_present_outlined,
      //             tabb: 2,
      //             indexx: currentIndex)),
      //     SizedBox(
      //       height: 5,
      //     ),
      //     InkWell(
      //         onTap: () {
      //           // Navigator.push(
      //           //   context,
      //           //   MaterialPageRoute(builder: (context) => const CoursesPage()),
      //           // );
      //           setState(() {
      //             currentIndex = 3;
      //           });
      //         },
      //         child: DrawerIconTab(
      //             titlee: 'My Account',
      //             icon: Icons.file_copy,
      //             tabb: 3,
      //             indexx: currentIndex,
      //         ),
      //     ),
      //     SizedBox(
      //       height: 5,
      //     ),
      //     InkWell(
      //         onTap: () {
      //           // Navigator.push(
      //           //   context,
      //           //   MaterialPageRoute(
      //           //       builder: (context) => const  CoursesPage()),
      //           // );
      //           setState(() {
      //             currentIndex = 4;
      //           });
      //         },
      //         child: DrawerIconTab(
      //           titlee: 'Become a merchant',
      //           icon: Icons.file_copy,
      //           tabb: 4,
      //           indexx: currentIndex,
      //         )),
      //     SizedBox(
      //       height: 5,
      //     ),
      //     InkWell(
      //         onTap: () {
      //           // Navigator.push(
      //           //   context,
      //           //   MaterialPageRoute(
      //           //       builder: (context) => const  CoursesPage()),
      //           // );
      //           setState(() {
      //             currentIndex = 5;
      //           });
      //         },
      //         child: DrawerIconTab(
      //           titlee: 'My Bookings',
      //           icon: Icons.file_copy,
      //           tabb: 5,
      //           indexx: currentIndex,
      //         )),
      //     SizedBox(
      //       height: 5,
      //     ),
      //     InkWell(
      //         onTap: () {
      //           // Navigator.push(
      //           //   context,
      //           //   MaterialPageRoute(
      //           //       builder: (context) => const PaymentHistoryPage()),
      //           // );
      //           setState(() {
      //             currentIndex = 6;
      //           });
      //         },
      //         child: DrawerIconTab(
      //           titlee: 'My Orders',
      //           icon: Icons.payment,
      //           tabb: 6,
      //           indexx: currentIndex,
      //         ),
      //     ),
      //     SizedBox(
      //       height: 5,
      //     ),
      //     InkWell(
      //       onTap: () {
      //         // Navigator.push(
      //         //   context,
      //         //   MaterialPageRoute(builder: (context) => const mySubscription()),
      //         // );
      //         setState(() {
      //           currentIndex = 7;
      //         });
      //       },
      //       child: DrawerIconTab(
      //         titlee: 'My Cart',
      //         icon: Icons.my_library_books_sharp,
      //         tabb: 7,
      //         indexx: currentIndex,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 5,
      //     ),
      //     InkWell(
      //         onTap: () {
      //           // Navigator.push(
      //           //   context,
      //           //   MaterialPageRoute(builder: (context) => const MyProfile()),
      //           // );
      //           setState(() {
      //             currentIndex = 8;
      //           });
      //         },
      //         child: DrawerIconTab(
      //           titlee: 'My Profile',
      //           icon: Icons.headphones,
      //           tabb: 8,
      //           indexx: currentIndex,
      //         )),
      //     const SizedBox(
      //       height: 5,
      //     ),
      //     InkWell(
      //       onTap: () {
      //         // Navigator.push(
      //         //   context,
      //         //   MaterialPageRoute(builder: (context) => PrivacyPolicy()),
      //         // );
      //         setState(() {
      //           currentIndex = 9;
      //         });
      //       },
      //       child: DrawerIconTab(
      //         titlee: 'Notification',
      //         icon: Icons.privacy_tip,
      //         tabb: 9,
      //         indexx: currentIndex,
      //       ),
      //     ),
      //     const SizedBox(
      //       height: 5,
      //     ),
      //     InkWell(
      //         onTap: () {
      //           // Navigator.push(
      //           //   context,
      //           //   MaterialPageRoute(
      //           //       builder: (context) => const TermsConditionsWidget()),
      //           // );
      //           setState(() {
      //             currentIndex = 10;
      //           });
      //           // share();
      //         },
      //         child: DrawerIconTab(
      //           titlee: 'Share the app',
      //           icon: Icons.confirmation_num,
      //           tabb: 10,
      //           indexx: currentIndex,
      //         )),
      //     SizedBox(
      //       height: 5,
      //     ),
      //     InkWell(
      //         onTap: () {
      //           // Navigator.push(
      //           //   context,
      //           //   MaterialPageRoute(
      //           //       builder: (context) => const FaqPage()),
      //           // );
      //
      //           setState(() {
      //             currentIndex = 11;
      //           });
      //         },
      //         child: DrawerIconTab(
      //           titlee: 'Send Feedback',
      //           icon: Icons.question_answer,
      //           tabb: 11,
      //           indexx: currentIndex,
      //         )),
      //     SizedBox(
      //       height: 5,
      //     ),
      //     InkWell(
      //         onTap: () {
      //           // Navigator.push(
      //           //   context,
      //           //   MaterialPageRoute(
      //           //       builder: (context) => const LoginPage()),
      //           // );
      //
      //           setState(() {
      //             currentIndex = 12;
      //           });
      //         },
      //         child: DrawerIconTab(
      //           titlee: 'Refer & Earn',
      //           icon: Icons.question_answer,
      //           tabb: 12,
      //           indexx: currentIndex,
      //         )),
      //     SizedBox(
      //       height: 5,
      //     ),
      //     InkWell(
      //         onTap: () {
      //           // Navigator.push(
      //           //   context,
      //           //   MaterialPageRoute(
      //           //       builder: (context) => const LoginPage()),
      //           // );
      //           setState(() {
      //             currentIndex = 13;
      //           });
      //         },
      //         child: DrawerIconTab(
      //           titlee: 'Help & Support',
      //           icon: Icons.question_answer,
      //           tabb: 13,
      //           indexx: currentIndex,
      //         )),
      //     SizedBox(
      //       height: 5,
      //     ),
      //     InkWell(
      //         onTap: () {
      //           // Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUS()),
      //           // );
      //           setState(() {
      //             currentIndex = 14;
      //           });
      //         },
      //         child: DrawerIconTab(
      //           titlee: 'About Us',
      //           icon: Icons.question_answer,
      //           tabb: 14,
      //           indexx: currentIndex,
      //         )),
      //     const SizedBox(
      //       height: 5,
      //     ),
      //     InkWell(
      //         onTap: () {
      //           setState(() {
      //             currentIndex = 15;
      //           });
      //           logout(context);
      //         },
      //         child: DrawerIconTab(
      //           titlee: 'Log Out',
      //           icon: Icons.logout_outlined,
      //           tabb: 15,
      //           indexx: currentIndex,
      //         )),
      //     const SizedBox(
      //       height: 20,
      //     ),
      //   ]),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  height: 100,
                  // width: 280,
                  child: ListView.builder(
                    scrollDirection:
                        Axis.horizontal, // Set the direction to horizontal
                    itemCount: arrNames.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 8),
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  color: colors.primary),
                              child: Image.asset(iconsNames[index]),
                            ),
                            Text(arrNames[index]),
                          ],
                        ),
                      );
                      // Text(
                      //   arrNames[index],
                      //   style: TextStyle(color: Colors.black),
                      // ),
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Calender()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Expanded(
                    child: Column(
                      children: [
                        Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: colors.whiteTemp),
                            child: Image.asset('assets/images/calender.png')),
                        const Text("Calender")
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
            child: Text(
              "Today's Order Status",
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Center(
            child: Table(
              border: TableBorder.all(borderRadius: BorderRadius.circular(10)),
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(125.0),
                1: FixedColumnWidth(125.0),
                2: FixedColumnWidth(90.0),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                // Header Row
                TableRow(
                  children: [
                    headerCell('Time Slot'),
                    headerCell('Region'),
                    headerCell('Order Status'),
                  ],
                ),
                // Data Rows
                ...orders.map((order) {
                  return TableRow(
                    children: [
                      dataCell(order.timeSlot),
                      dataCell(order.region),
                      statusCell(order.status),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
          //
          // Container(
          //   height: 100,
          //   width: 200,
          //   child: homepageimagemodel == null
          //       ? Center(child: CircularProgressIndicator())
          //       : CarouselSlider(
          //     options: CarouselOptions(
          //       autoPlay: true,
          //       aspectRatio: 2,
          //       viewportFraction: 1,
          //     ),
          //     items: homepageimagemodel!.data!.map((item) {
          //       return Builder(
          //         builder: (BuildContext context) {
          //           return Container(
          //             width: MediaQuery.of(context).size.width,
          //             margin: EdgeInsets.symmetric(horizontal: 5.0),
          //             child: Image.network(item.image!, fit: BoxFit.cover),
          //           );
          //         },
          //       );
          //     }).toList(),
          //   ),
          // ),
          //
          // Padding(
          //   padding: const EdgeInsets.only(top:10),
          //   child: CarouselSlider(
          //     items: imageList.map((item) {
          //       return ClipRRect(
          //         borderRadius: BorderRadius.circular(10.0), // Border radius
          //         child: Image.asset(
          //
          //           item[imageUrl]!,
          //           fit: BoxFit.cover,
          //           width: double.infinity,
          //         ),
          //       );
          //     }).toList(), // Convert to List<Widget>
          //     carouselController: carouselController,
          //     options: CarouselOptions(
          //       scrollPhysics: const BouncingScrollPhysics(),
          //       autoPlay: true,
          //       aspectRatio: 2,
          //       viewportFraction: 1,
          //       onPageChanged: (index, reason) {
          //         setState(() {
          //           currentIndex = index;
          //         });
          //       },
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        currentIndex == index ? Color(0xff6EE2F5) : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeliveryCard()));
                  },
                  child: Container(
                    height: 100,
                    width: 170,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/images/homered.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          Text(
                            "Delivery Card",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: colors.whiteTemp,
                                fontSize: 18),
                          ),
                          Text("$card_limit",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: colors.whiteTemp,
                                  fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BusinessCard()));
                  },
                  child: Container(
                    height: 100,
                    width: 170,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/images/homeblue.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          const Text("Busines Card",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: colors.whiteTemp,
                                  fontSize: 18)),
                          Text("$card_limit",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: colors.whiteTemp,
                                  fontSize: 18))
                        ],
                      ),
                    ),
                  ),
                ),
                // Container(
                //   width: 150,
                //   child: Image.asset('assets/images/homeblue.png'),
                // ),
                //   Container(
                //   width: 150,
                //   child: Image.asset('assets/images/homered.png'),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

logout(context) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Sign Out"),
          content: const Text("Are you sure to log out?"),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: colors.primary),
              child: Text("YES"),
              onPressed: () async {
                // setState(() {
                //   removesession();
                // });
                // Navigator.pop(context);
                // SystemNavigator.pop();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: colors.primary),
              child: const Text("NO"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}

class Order {
  String timeSlot;
  String region;
  String status;
  Order(this.timeSlot, this.region, this.status);
}

class Homepageimagemodel {
  Homepageimagemodel({
    bool? error,
    String? message,
    List<Data>? data,
  }) {
    _error = error;
    _message = message;
    _data = data;
  }

  Homepageimagemodel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
  Homepageimagemodel copyWith({
    bool? error,
    String? message,
    List<Data>? data,
  }) =>
      Homepageimagemodel(
        error: error ?? _error,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "29"
/// banners_name : "newBanner"
/// image : "https://developmentalphawizz.com/hojayega/uploads/64493919da487.png"
/// role_type : "0"
/// banner_type : "shop"

class Data {
  Data({
    String? id,
    String? bannersName,
    String? image,
    String? roleType,
    String? bannerType,
  }) {
    _id = id;
    _bannersName = bannersName;
    _image = image;
    _roleType = roleType;
    _bannerType = bannerType;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _bannersName = json['banners_name'];
    _image = json['image'];
    _roleType = json['role_type'];
    _bannerType = json['banner_type'];
  }
  String? _id;
  String? _bannersName;
  String? _image;
  String? _roleType;
  String? _bannerType;
  Data copyWith({
    String? id,
    String? bannersName,
    String? image,
    String? roleType,
    String? bannerType,
  }) =>
      Data(
        id: id ?? _id,
        bannersName: bannersName ?? _bannersName,
        image: image ?? _image,
        roleType: roleType ?? _roleType,
        bannerType: bannerType ?? _bannerType,
      );
  String? get id => _id;
  String? get bannersName => _bannersName;
  String? get image => _image;
  String? get roleType => _roleType;
  String? get bannerType => _bannerType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['banners_name'] = _bannersName;
    map['image'] = _image;
    map['role_type'] = _roleType;
    map['banner_type'] = _bannerType;
    return map;
  }
}
