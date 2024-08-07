import 'dart:convert';

import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hojayega_seller/Screen/AllCategory.dart';
import 'package:hojayega_seller/Screen/BusinessCard.dart';
import 'package:hojayega_seller/Screen/Calender.dart';
import 'package:hojayega_seller/Screen/DeliveryCard.dart';
import 'package:hojayega_seller/Screen/Faq.dart';
import 'package:hojayega_seller/Screen/MyProfile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../AuthView/Login.dart';
import '../Helper/api.path.dart';
import '../Helper/appButton.dart';
import '../Helper/color.dart';
import '../Model/GetProfileModel.dart';
import 'CreateOnlineStore.dart';
import 'Earning.dart';
import 'Help.dart';
import 'HomeScreen.dart';
import 'MyPickDrop.dart';
import 'Orders.dart';
import 'PendingBooking.dart';
import 'PendingOrders.dart';
import 'Pick&Drop.dart';
import 'PrivacyPolicy.dart';
import 'PromotionAdds.dart';
import 'Settings.dart';
import 'createPortfolio.dart';
import 'notificationScreen.dart';

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
    int? index = 0;
    if (index == 0) {
      setState(() {
        selectedIndex = 0;
      });
      _child = selectedIndex == 0 ? HomeScreen() : Container();
    } else {
      _child = Container();
    }
    super.initState();
    getData();
    getProfile();
    // if (widget.dIndex != null) {
    //   selectedIndex = widget.dIndex!;
    //   _child = widget.dIndex == 1
    //       ? Container()
    //       : widget.dIndex == 3
    //       ? Container()
    //       : Container();
    // } else {
    //   _child = Container();
    // }
  }

  String? vendorName;
  String? vendorEmail;
  String? roll;

  getData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    vendorName = preferences.getString('vendor_name');
    vendorEmail = preferences.getString('vendor_email');
    // roll =  preferences.getString('roll');
    print("===============  $vendorEmail $vendorName $roll===========");
  }

  String? vendorId;
  GetProfileModel? profileData;
  getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    vendorId = prefs.getString("vendor_id");
    var headers = {
      'Cookie': 'ci_session=1826473be67eeb9329a8e5393f7907573d116ca1'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getProfile));
    request.fields.addAll({'user_id': vendorId.toString()});
    debugPrint("get profile parameters ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = GetProfileModel.fromJson(json.decode(finalResponse));
      print("profile data response $finalResult");
      setState(() {
        profileData = finalResult;
        vendorEmail = profileData?.data?.first.email.toString();
        vendorName = profileData?.data?.first.shopName.toString();
        roll = profileData?.data?.first.roll.toString();
        print("roll herer $roll shop nae $vendorName");
        setState(() {});
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  var onOf = true;

  Future<void> shopStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    vendorId = prefs.getString("vendor_id");
    var headers = {
      'Cookie': 'ci_session=f02741f77bb53eeaf1a6be0a045cb6f11b68f1a6'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.onOffStatus));
    request.fields
        .addAll({'user_id': '$vendorId', 'online_status': onOf ? '1' : '0'});
    print("=======online========${request.fields}======offline=====");
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
      child: WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Confirm Exit"),
                  content: const Text("Are you sure you want to exit?"),
                  actions: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: colors.primary),
                      child: const Text("YES"),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: colors.primary),
                      child: const Text("NO"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
          return true;
        },
        child: Scaffold(
          key: _key,
          backgroundColor: colors.appbarColor,
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(selectedIndex == 4 || selectedIndex == 2
                    ? roll == "2"
                        ? 80
                        : 0
                    : 80),
            child: selectedIndex == 0
                ? homeAppBar(
                    context,
                    text: "Home",
                    ontap: () {
                      _key.currentState!.openDrawer();
                    },
                  )
                : selectedIndex == 0
                    ? Container()
                    : PreferredSize(
                        preferredSize: const Size.fromHeight(80),
                        child: commonAppBar(context,
                            text: selectedIndex == 0
                                ? "Home"
                                : roll == "2"
                                    ? selectedIndex == 3
                                        ? "Pick & Drop"
                                        : "Pending Order"
                                    : selectedIndex == 4
                                        ? "Pick & Drop"
                                        : roll == "2"
                                            ? selectedIndex == 2
                                                ? "Pending Booking"
                                                : "My Bookings"
                                            : "My Orders"),
                      ),
          ),
          body: _child,
          drawer: Drawer(
            child: ListView(children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  // border: Border(bottom: BorderSide(color: Colors.black)),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xff112C48), Color(0xff112C48)],
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 0,
                          ),
                          profileData?.data?.first.shopImage == null ||
                                  profileData?.data?.first.shopImage == ""
                              ? const CircleAvatar(
                                  backgroundImage: AssetImage(
                                    "assets/images/bike.png",
                                  ),
                                  radius: 30,
                                )
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    "https://developmentalphawizz.com/hojayega${profileData?.data?.first.shopImage}",
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
                              Text(
                                '$vendorName',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              vendorEmail == null || vendorEmail == ""
                                  ? const Text(
                                      'Demo',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    )
                                  : Text(
                                      '$vendorEmail',
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        onOf
                            ? const Text(
                                "Online",
                                style: TextStyle(
                                    color: colors.whiteTemp, fontSize: 15),
                              )
                            : const Text("Offline",
                                style: TextStyle(
                                    color: colors.whiteTemp, fontSize: 15)),
                        CupertinoSwitch(
                            trackColor:
                                onOf == true ? Colors.green : Colors.red,
                            value: onOf,
                            onChanged: (value) {
                              setState(() {
                                onOf = value;
                                shopStatus();
                              });
                            }),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyProfile()),
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
              const SizedBox(
                height: 5,
              ),
              roll == "2"
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = 2;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ServicesDetails(
                                  ParentId: parentId.toString())),
                        );
                      },
                      child: DrawerIconTab(
                        titlee: 'Add Services',
                        icon: Icons.design_services_rounded,
                        tabb: 5,
                        indexx: currentIndex,
                      ),
                    )
                  :
                  // InkWell(
                  //     onTap: () {
                  //       // Navigator.push(
                  //       //   context,
                  //       //   MaterialPageRoute(
                  //       //       builder: (context) => const  OfferJobWidget()),
                  //       // );
                  //       setState(() {
                  //         currentIndex = 2;
                  //       });
                  //     },
                  //     child: DrawerIconTab(
                  //         titlee: 'Product Portfolio',
                  //         icon: Icons.file_present_outlined,
                  //         tabb: 2,
                  //         indexx: currentIndex)),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // InkWell(
                  //     onTap: () {
                  //       // Navigator.push(
                  //       //   context,
                  //       //   MaterialPageRoute(builder: (context) => const CoursesPage()),
                  //       // );
                  //       setState(() {
                  //         currentIndex = 3;
                  //       });
                  //     },
                  //     child: DrawerIconTab(
                  //         titlee: 'Switch User',
                  //         icon: Icons.file_copy,
                  //         tabb: 3,
                  //         indexx: currentIndex)),
                  const SizedBox(
                      height: 5,
                    ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationScreen()),
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
                          builder: (context) => const PromotionAdds()),
                    );
                  },
                  child: DrawerIconTab(
                    titlee: 'Promotion & Adds',
                    icon: Icons.file_copy,
                    tabb: 5,
                    indexx: currentIndex,
                  )),
              // SizedBox(
              //   height: 5,
              // ),
              // InkWell(
              //     onTap: () {
              //       // Navigator.push(
              //       //   context,
              //       //   MaterialPageRoute(
              //       //       builder: (context) => const PaymentHistoryPage()),
              //       // );
              //       setState(() {
              //         currentIndex = 6;
              //       });
              //     },
              //     child: DrawerIconTab(
              //       titlee: 'Coupons',
              //       icon: Icons.payment,
              //       tabb: 6,
              //       indexx: currentIndex,
              //     )),
              // SizedBox(
              //   height: 5,
              // ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Earning()),
                  );
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
              // InkWell(
              //     onTap: () {
              //       // Navigator.push(context, MaterialPageRoute(builder: (context) => const MyProfile()),);
              //       setState(() {
              //         currentIndex = 8;
              //       });
              //     },
              //     child: DrawerIconTab(
              //       titlee: 'Order history/Reports',
              //       icon: Icons.history,
              //       tabb: 8,
              //       indexx: currentIndex,
              //     )),
              // const SizedBox(
              //   height: 5,
              // ),
              // InkWell(
              //   onTap: () {
              //     // Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(builder: (context) => PrivacyPolicy()),
              //     // );
              //     setState(() {
              //       currentIndex = 9;
              //     });
              //   },
              //   child: DrawerIconTab(
              //     titlee: 'Library',
              //     icon: Icons.privacy_tip,
              //     tabb: 9,
              //     indexx: currentIndex,
              //   ),
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              // InkWell(
              //     onTap: () {
              //       // Navigator.push(
              //       //   context,
              //       //   MaterialPageRoute(
              //       //       builder: (context) => const TermsConditionsWidget()),
              //       // );
              //       setState(() {
              //         currentIndex = 10;
              //       });
              //       // share();
              //     },
              //     child: DrawerIconTab(
              //       titlee: 'Automatic Booking',
              //       icon: Icons.confirmation_num,
              //       tabb: 10,
              //       indexx: currentIndex,
              //     )),
              // SizedBox(
              //   height: 5,
              // ),
              // InkWell(
              //     onTap: () {
              //       // Navigator.push(
              //       //   context,
              //       //   MaterialPageRoute(
              //       //       builder: (context) => const FaqPage()),
              //       // );
              //
              //       setState(() {
              //         currentIndex = 11;
              //       });
              //     },
              //     child: DrawerIconTab(
              //       titlee: 'Track Order',
              //       icon: Icons.question_answer,
              //       tabb: 11,
              //       indexx: currentIndex,
              //     ),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const BusinessCard(walletAmount: "")),
                    );
                    setState(() {
                      currentIndex = 12;
                    });
                  },
                  child: DrawerIconTab(
                    titlee: 'Business Card',
                    icon: Icons.credit_card,
                    tabb: 12,
                    indexx: currentIndex,
                  )),
              SizedBox(
                height: 5,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const DeliveryCard(walletAmount: "")),
                    );
                    setState(() {
                      currentIndex = 13;
                    });
                  },
                  child: DrawerIconTab(
                    titlee: 'Delivery Card',
                    icon: Icons.credit_card,
                    tabb: 13,
                    indexx: currentIndex,
                  )),
              SizedBox(
                height: 5,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyPickDrop()),
                    );
                    setState(() {
                      currentIndex = 14;
                    });
                  },
                  child: DrawerIconTab(
                    titlee: 'My Pick Drop',
                    icon: Icons.my_library_books_sharp,
                    tabb: 14,
                    indexx: currentIndex,
                  )),
              SizedBox(
                height: 5,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Settings()),
                    );
                    setState(() {
                      currentIndex = 15;
                    });
                  },
                  child: DrawerIconTab(
                    titlee: 'Terms & Condition',
                    icon: Icons.settings,
                    tabb: 15,
                    indexx: currentIndex,
                  )),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrivacyPolicy()),
                  );
                  setState(() {
                    currentIndex = 16;
                  });
                },
                child: DrawerIconTab(
                  titlee: 'Privacy Policy',
                  icon: Icons.settings,
                  tabb: 16,
                  indexx: currentIndex,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactUsScreen()));
                  setState(() {
                    currentIndex = 17;
                  });
                },
                child: DrawerIconTab(
                  titlee: 'Help',
                  icon: Icons.help,
                  tabb: 17,
                  indexx: currentIndex,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FaqPage()));
                  setState(() {
                    currentIndex = 18;
                  });
                },
                child: DrawerIconTab(
                  titlee: 'Faq',
                  icon: Icons.question_mark,
                  tabb: 18,
                  indexx: currentIndex,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 19;
                  });
                  logout(context);
                },
                child: DrawerIconTab(
                  titlee: 'Log Out',
                  icon: Icons.logout_outlined,
                  tabb: 19,
                  indexx: currentIndex,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ]),
          ),
          bottomNavigationBar: FluidNavBar(
            icons: roll == "2"
                ? [
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
                        icon: Icons.list_alt_sharp,
                        // unselectedForegroundColor: Colors.grey,
                        selectedForegroundColor: Colors.white,
                        unselectedForegroundColor: Colors.white,
                        backgroundColor: colors.primary,
                        //  selectedIndex == 1 ? colors.primary : colors.white10,
                        extras: {"label": "My Bookings"}),
                    FluidNavBarIcon(
                        icon: Icons.calendar_month,
                        // unselectedForegroundColor: Colors.grey,
                        selectedForegroundColor: Colors.white,
                        backgroundColor: colors.primary,
                        unselectedForegroundColor: Colors.white,
                        //  selectedIndex == 1 ? colors.primary : colors.white10,
                        extras: {"label": "Pending "}),
                    FluidNavBarIcon(
                        icon: Icons.wheelchair_pickup,
                        // unselectedForegroundColor: Colors.grey,
                        selectedForegroundColor: Colors.white,
                        unselectedForegroundColor: Colors.white,
                        backgroundColor: colors.primary,
                        //  selectedIndex == 1 ? colors.primary : colors.white10,
                        extras: {"label": "Pick & Drop"}),
                  ]
                : [
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
                        icon: Icons.list_alt_sharp,
                        backgroundColor: colors.primary,
                        unselectedForegroundColor: Colors.white,
                        //  selectedIndex == 1 ? colors.primary : colors.white10,
                        extras: {"label": "My Orders"}),
                    FluidNavBarIcon(
                        icon: Icons.shopping_cart,
                        // unselectedForegroundColor: Colors.grey,
                        selectedForegroundColor: Colors.white,
                        unselectedForegroundColor: Colors.white,
                        backgroundColor: colors.primary,
                        //  selectedIndex == 1 ? colors.primary : colors.white10,
                        extras: {"label": "My Cart"}),
                    FluidNavBarIcon(
                        icon: Icons.calendar_month,
                        // unselectedForegroundColor: Colors.grey,
                        selectedForegroundColor: Colors.white,
                        backgroundColor: colors.primary,
                        unselectedForegroundColor: Colors.white,
                        //  selectedIndex == 1 ? colors.primary : colors.white10,
                        extras: {"label": "Pending "}),
                    FluidNavBarIcon(
                        icon: Icons.wheelchair_pickup,
                        // unselectedForegroundColor: Colors.grey,
                        selectedForegroundColor: Colors.white,
                        unselectedForegroundColor: Colors.white,
                        backgroundColor: colors.primary,
                        //  selectedIndex == 1 ? colors.primary : colors.white10,
                        extras: {"label": "Pick & Drop"}),
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
                    margin: const EdgeInsets.only(top: 40),
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
        ),
      ),
    );
  }

  // Future<void> share() async {
  //   await FlutterShare.share(
  //       title: 'HoJayega',
  //       // text: 'Example share text',
  //       linkUrl: 'https://developmentalphawizz.com/dr_booking/',
  //       chooserTitle: 'HoJayega');
  // }

  Future<void> removeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("vendor_id");
    prefs.remove("roll");
    prefs.remove("isLogIn");
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
                child: const Text("YES"),
                onPressed: () async {
                  setState(() {
                    removeSession();
                  });
                  Navigator.pop(context);
                  // SystemNavigator.pop();
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool("isLogIn", false);
                  prefs.clear();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                  // Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
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

  // bool? isTrue = true;
  void _handleNavigationChange(int index) {
    setState(() {
      selectedIndex = index;
      switch (index) {
        case 0:
          _child = HomeScreen();
          break;
        case 1:
          // _child = roll=="2"? Calender(isFromBottom: true,) :Orders();
          _child = roll == "2" ? Calender() : Orders();
          break;
        case 2:
          _child =
              roll == "2" ? const PendingBooking() : AllCategory(isShow: false);
          break;
        case 3:
          _child = roll == "2" ? PickDrop() : PendingOrders();
          break;
        case 4:
          _child = PickDrop();
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
