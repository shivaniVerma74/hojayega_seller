
import 'dart:convert';

import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hojayega_seller/Screen/AllCategory.dart';
import 'package:hojayega_seller/Screen/MyProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../AuthView/Login.dart';
import '../Helper/api.path.dart';
import '../Helper/appButton.dart';
import '../Helper/color.dart';
import 'HomeScreen.dart';
import 'Orders.dart';
import 'PendingOrders.dart';
import 'PromotionAdds.dart';
import 'notificationScreen.dart';
import 'package:http/http.dart' as http;

class BottomNavBar extends StatefulWidget {
  int? dIndex;
  BottomNavBar({super.key, this.dIndex});
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Widget? _child;
  int selectedIndex = 0;
  int currentIndex = 99;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  @override
  void initState() {
    getData();
    if (widget.dIndex != null) {
      selectedIndex = widget.dIndex!;
      _child = widget.dIndex == 1
          ? Container()
          : widget.dIndex == 3
          ? Container()
          : Container();
    } else {
      _child = Container();
    }
    super.initState();
  }

  String? vendorName;
  String? vendorEmail;
  getData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    vendorName = preferences.getString('vendor_name');
    vendorEmail = preferences.getString('vendor_email');
    print("===============$vendorEmail $vendorName===========");
  }
  var onOf = false;
  String? vendorId;

  Future<void> shopStatus() async {
     SharedPreferences preferences = await SharedPreferences.getInstance();
    vendorId = preferences.getString('vendorId');
    var headers = {
      'Cookie': 'ci_session=f02741f77bb53eeaf1a6be0a045cb6f11b68f1a6'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiServicves.onOffStatus));
    request.fields.addAll(
        {'user_id': '$vendorId', 'online_status': onOf ? '1' : '0'});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResult = json.decode(finalResult);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          key: _key,
          backgroundColor: colors.appbarColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(selectedIndex == 4 ? 0 : 80),
            child: selectedIndex == 0
                ? homeAppBar(
              context,
              text: "Home",
              ontap: () {
                _key.currentState!.openDrawer();
              },
            ): selectedIndex == 0
                ? Container()
                : PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: commonAppBar(context,
                  text: selectedIndex == 0
                      ? "Home"
                      : selectedIndex == 3
                      ? "Pending Orders"
                      : selectedIndex == 4
                      ? "Pick & Drop"
                      : "My Orders"),
            ),
          ),
          body: _child,
          drawer: Drawer(
            child: ListView(
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      // border: Border(bottom: BorderSide(color: Colors.black)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xff112C48), Color(0xff112C48)])),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 0,
                              ),
                              const CircleAvatar(
                                backgroundImage: AssetImage(
                                  "assets/images/bike.png",
                                ),
                                radius: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Hello!',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  vendorEmail == null || vendorEmail == ""
                                      ? const Text(
                                    'Demo',
                                    style: TextStyle(fontSize: 15, color: Colors.white))
                                      : Text(
                                    '$vendorEmail',
                                    style: TextStyle(fontSize: 15, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            onOf ? const Text("Online", style: TextStyle(color: colors.whiteTemp, fontSize: 15),) :
                            const Text("Offline",style: TextStyle(color: colors.whiteTemp, fontSize: 15)),
                            CupertinoSwitch(
                                trackColor: Colors.green,
                                value: onOf,
                                onChanged: (value) {
                                  setState(() {
                                    onOf = value;
                                    shopStatus();
                                  });
                                }
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyProfile()  ),
                      );
                      setState(() {
                        currentIndex = 1;
                      });
                    },
                    child: DrawerIconTab(
                      titlee: 'Profile',
                      icon: Icons.person,
                      tabb: 1,
                      indexx: currentIndex,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const  OfferJobWidget()),
                        // );
                        setState(() {
                          currentIndex = 2;
                        });
                      },
                      child: DrawerIconTab(
                          titlee: 'Product Portfolio',
                          icon: Icons.file_present_outlined,
                          tabb: 2,
                          indexx: currentIndex)),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const CoursesPage()),
                        // );
                        setState(() {
                          currentIndex = 3;
                        });
                      },
                      child: DrawerIconTab(
                          titlee: 'Switch User',
                          icon: Icons.file_copy,
                          tabb: 3,
                          indexx: currentIndex)),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const  NotificationScreen()),
                        );
                        setState(() {
                          currentIndex = 4;
                        });
                      },
                      child: DrawerIconTab(
                        titlee: 'Notification',
                        icon: Icons.notifications,
                        tabb: 4,
                        indexx: currentIndex,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = 5;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const  PromotionAdds()),
                        );
                      },
                      child: DrawerIconTab(
                        titlee: 'Promotion & Adds',
                        icon: Icons.file_copy,
                        tabb: 5,
                        indexx: currentIndex,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const PaymentHistoryPage()),
                        // );
                        setState(() {
                          currentIndex = 6;
                        });
                      },
                      child: DrawerIconTab(
                        titlee: 'Coupons',
                        icon: Icons.payment,
                        tabb: 6,
                        indexx: currentIndex,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const mySubscription()),
                      // );
                      setState(() {
                        currentIndex = 7;
                      });
                    },
                    child: DrawerIconTab(
                      titlee: 'Earnings',
                      icon: Icons.my_library_books_sharp,
                      tabb: 7,
                      indexx: currentIndex,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const MyProfile()),);
                        setState(() {
                          currentIndex = 8;
                        });
                      },
                      child: DrawerIconTab(
                        titlee: 'Order history/Reports',
                        icon: Icons.file_copy_sharp,
                        tabb: 8,
                        indexx: currentIndex,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => PrivacyPolicy()),
                      // );
                      setState(() {
                        currentIndex = 9;
                      });
                    },
                    child: DrawerIconTab(
                      titlee: 'Library',
                      icon: Icons.privacy_tip,
                      tabb: 9,
                      indexx: currentIndex,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const TermsConditionsWidget()),
                        // );
                        setState(() {
                          currentIndex = 10;
                        });
                        // share();
                      },
                      child: DrawerIconTab(
                        titlee: 'Automatic Booking',
                        icon: Icons.confirmation_num,
                        tabb: 10,
                        indexx: currentIndex,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const FaqPage()),
                        // );

                        setState(() {
                          currentIndex = 11;
                        });
                      },
                      child: DrawerIconTab(
                        titlee: 'Track Order',
                        icon: Icons.question_answer,
                        tabb: 11,
                        indexx: currentIndex,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const LoginPage()),
                        // );

                        setState(() {
                          currentIndex = 12;
                        });
                      },
                      child: DrawerIconTab(
                        titlee: 'Business Card/Delivery Card',
                        icon: Icons.question_answer,
                        tabb: 12,
                        indexx: currentIndex,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const LoginPage()),
                        // );
                        setState(() {
                          currentIndex = 13;
                        });
                      },
                      child: DrawerIconTab(
                        titlee: 'Settings',
                        icon: Icons.question_answer,
                        tabb: 13,
                        indexx: currentIndex,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUS()),);
                        setState(() {
                          currentIndex = 14;
                        });
                      },
                      child: DrawerIconTab(
                        titlee: 'Help',
                        icon: Icons.question_answer,
                        tabb: 14,
                        indexx: currentIndex,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = 15;
                        });
                        logout(context);
                      },
                      child: DrawerIconTab(
                        titlee: 'Log Out',
                        icon: Icons.logout_outlined,
                        tabb: 15,
                        indexx: currentIndex,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
          ),
          bottomNavigationBar: FluidNavBar(
            icons: [
              FluidNavBarIcon(
                  icon: Icons.home,
                  // unselectedForegroundColor: Colors.grey,
                  selectedForegroundColor: Colors.white,
                  //  svgPath: "assets/home.svg",
                  backgroundColor: colors.primary,
                  unselectedForegroundColor: Colors.white,
                  //  selectedIndex == 1 ? colors.primary : colors.white10,
                  extras: {"label": "Home"}),
              FluidNavBarIcon(
                // unselectedForegroundColor: Colors.grey,
                  selectedForegroundColor: Colors.white,
                  icon: Icons.shopping_cart,
                  backgroundColor: colors.primary,
                  unselectedForegroundColor: Colors.white,
                  //  selectedIndex == 1 ? colors.primary : colors.white10,
                  extras: {"label": "My Cart"}),
              FluidNavBarIcon(
                  icon: Icons.list_alt_sharp,
                  // unselectedForegroundColor: Colors.grey,
                  selectedForegroundColor: Colors.white,
                  unselectedForegroundColor: Colors.white,
                  backgroundColor: colors.primary,
                  //  selectedIndex == 1 ? colors.primary : colors.white10,
                  extras: {"label": "My Orders"}),
              FluidNavBarIcon(
                  icon: Icons.calendar_month,
                  // unselectedForegroundColor: Colors.grey,
                  selectedForegroundColor: Colors.white,
                  backgroundColor: colors.primary,
                  unselectedForegroundColor: Colors.white,
                  //  selectedIndex == 1 ? colors.primary : colors.white10,
                  extras: {"label": "Pending History"}),
              // FluidNavBarIcon(
              //     icon: Icons.wheelchair_pickup,
              //     // unselectedForegroundColor: Colors.grey,
              //     selectedForegroundColor: Colors.white,
              //     unselectedForegroundColor: Colors.white,
              //     backgroundColor: colors.primary,
              //     //  selectedIndex == 1 ? colors.primary : colors.white10,
              //     extras: {"label": "Pick & Drop"}),
            ],
            onChange: _handleNavigationChange,
            style: const FluidNavBarStyle(
              barBackgroundColor: colors.primary,
            ),
            scaleFactor: 1.2,
            defaultIndex: selectedIndex,
            animationFactor: 0.5,
            itemBuilder: (icon, item) => Semantics(
              label: icon.extras!["label"],
              container: true,
              enabled: true,
              child: Stack(
                children: [
                  item,
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25 - 25,
                    margin: EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        icon.extras!["label"],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  // Future<void> share() async {
  //   await FlutterShare.share(
  //       title: 'HoJayega',
  //       // text: 'Example share text',
  //       linkUrl: 'https://developmentalphawizz.com/dr_booking/',
  //       chooserTitle: 'HoJayega');
  // }

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
                  Navigator.pop(context);
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

  void _handleNavigationChange(int index) {
    setState(() {
      selectedIndex = index;
      switch (index) {
        case 0:
          _child = HomeScreen();
          break;
        case 1:
          _child = Orders();
          break;
        case 2:
          _child = AllCategory();
          break;
        case 3:
          _child = PendingOrders();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.bounceOut,
        switchOutCurve: Curves.bounceIn,
        duration: Duration(milliseconds: 100),
        child: _child,
      );
    });
  }
}

class DrawerIconTab extends StatefulWidget {
  final IconData? icon;
  final String? titlee;
  final int? tabb;
  final int? indexx;

  DrawerIconTab({Key? key, this.icon, this.titlee, this.tabb, this.indexx})
      : super(key: key);

  @override
  State<DrawerIconTab> createState() => _DrawerIconTabState();
}

class _DrawerIconTabState extends State<DrawerIconTab> {
  var Select = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          gradient: widget.indexx == widget.tabb
              ? LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff112C48), Color(0xff112C48)])
              : null),
      // color:
      //     widget.indexx == widget.tabb ? colors.secondary : Colors.transparent,
      child: Row(
        children: [
          SizedBox(
            width: 13,
          ),
          Container(
            decoration:
            BoxDecoration(color: Color(0xff112C48), shape: BoxShape.circle),
            height: 40,
            width: 40,
            child: Center(
                child: Icon(
                  widget.icon,
                  color: widget.indexx == widget.tabb ? Colors.white : Colors.grey,
                  size: 20,
                )),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            '${widget.titlee}',
            style: TextStyle(
                fontSize: 15,
                fontWeight: widget.indexx == widget.tabb
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: widget.indexx == widget.tabb
                    ? Colors.white
                    : Color(0xff112C48)),
          ),
        ],
      ),
    );
  }
}

// class DrawerImageTab extends StatefulWidget {
//   final String? titlee;
//   final String? img;
//   final int? tabb;
//   final int? indexx;
//   DrawerImageTab({Key? key, this.titlee, this.img, this.tabb, this.indexx})
//       : super(key: key);

//   @override
//   State<DrawerImageTab> createState() => _DrawerImageTabState();
// }

// class _DrawerImageTabState extends State<DrawerImageTab> {
//   var Select = 0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 50,
//       color:
//           widget.indexx == widget.tabb ? colors.secondary : Colors.transparent,
//       child: Row(
//         children: [
//           SizedBox(
//             width: 15,
//           ),
//           Container(
//             height: 25,
//             width: 25,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage('${widget.img}'), fit: BoxFit.fill)),
//           ),
//           SizedBox(
//             width: 20,
//           ),
//           Text(
//             '${widget.titlee}',
//             style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: widget.indexx == widget.tabb
//                     ? FontWeight.bold
//                     : FontWeight.normal,
//                 color: Colors.black),
//           ),
//         ],
//       ),
//     );
//   }
// }
