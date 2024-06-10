import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/api.path.dart';
import '../Helper/color.dart';
import 'package:http/http.dart' as http;
import '../Model/AreaModel.dart';
import '../Model/VehicleModel.dart';
import '../Model/getTimeSlotModel.dart';
import 'BottomBar.dart';

class PickDrop extends StatefulWidget {
  const PickDrop({super.key});

  @override
  State<PickDrop> createState() => _PickDropState();
}

class _PickDropState extends State<PickDrop> {

  String _selectedOption = 'Yes';
  var arrValue = ['Cake', 'fragile', 'Ready', 'Non'];
  Map<int, int> _radioSelections = {};
  Map<int, int> _radioSelections2 = {};

  String? _selectedItem;
  List<String> items = ['Indore', 'Bhopal', 'jaipur', 'Ujjain'];
  String? _selectedItem2;
  List<String> items2 = ['Bhopal', 'Ujjain', 'Indore', 'Jaipur'];

  File? _image;
  final picker = ImagePicker();
  Future getImageGallery() async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image picked');
      }
    });
  }

  File? packageImages;
  Widget packageImage() {
    return Card(
      elevation: 1,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        //margin: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.withOpacity(0.2),
            border: Border.all(color: colors.primary)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: packageImages != null
              ? Image.file(packageImages!, fit: BoxFit.cover)
              : Column(
            children: const [
              Center(child: Icon(Icons.upload_file_outlined, size: 60)),
              Text("Upload")
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectarea1.add(selectedValue);
    selectarea.add(selectedValue1);

    getVehicle();
    getArea();
    getTimeSlot();
    int numberOfCtr = 15;
    for (int i = 0; i < numberOfCtr; i++) {
      addressCtr.add(TextEditingController());
    }

    int numberOfControllers = 15;
    for (int i = 0; i < numberOfControllers; i++) {
      dropLocationCtr.add(TextEditingController());
    }
  }

  Widget imagesView() {
    return Card(
      elevation: 1,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        //margin: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            border: Border.all(color: colors.primary)),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: packageImages != null
                ? Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.file(packageImages!, fit: BoxFit.fill))
                : Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: const [
                  Center(
                    child: Icon(Icons.upload_file_outlined, size: 60),
                  ),
                  Text("Upload")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source, String type) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxHeight: 100,
      maxWidth: 100,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      setState(() {
        if (type == 'uploadImage') {
          packageImages = File(pickedFile.path);
        }
      });
    }
  }

  Future showAlertDialog(BuildContext context, String type) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Image'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                pickImage(ImageSource.gallery, type);
                Navigator.pop(context);
                // getImage(ImageSource.camera, context, 1);
              },
              child: Text('Gallery'),
            ),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
              onPressed: () {
                pickImage(ImageSource.camera, type);
                Navigator.pop(context);
              },
              child: Text('Camera'),
            ),
          ],
        ),
      ),
    ) ??
        false;
  }


  TextEditingController productDescriptionCtr = TextEditingController();
  TextEditingController noteCtr = TextEditingController();

  List<String> latitude = [];
  List<String> longitudes = [];
  List<String> droplatitude = [];
  List<String> droplongitudes = [];
  late String myLoction = "";

  getLocation(i) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey: Platform.isAndroid
              ? "AIzaSyDBDy-PbXUrSevFfZ_8X-lyT5W_LxlXwpM"
              : "AIzaSyDBDy-PbXUrSevFfZ_8X-lyT5W_LxlXwpM",
          onPlacePicked: (result) {
            print(result.formattedAddress);
            setState(() {
              addressCtr[i].text = result.formattedAddress.toString();
              latitude.add(result.geometry!.location.lat.toString());
              longitudes.add(result.geometry!.location.lat.toString());
              // latitude[i] = result.geometry!.location.lat.toString();
              // longitudes[i] = result.geometry!.location.lng.toString();
              myLoction = result.formattedAddress.toString();
            });
            Navigator.of(context).pop();
          },
          initialPosition: LatLng(22.719568, 75.857727),
          useCurrentLocation: true,
        ),
      ),
    );
  }

  getDropLocation(index) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey: Platform.isAndroid
              ? "AIzaSyDBDy-PbXUrSevFfZ_8X-lyT5W_LxlXwpM"
              : "AIzaSyDBDy-PbXUrSevFfZ_8X-lyT5W_LxlXwpM",
          onPlacePicked: (result) {
            print(result.formattedAddress);
            dropLocationCtr[index].text = result.formattedAddress.toString();
            droplatitude.add(result.geometry!.location.lat.toString());
            droplongitudes.add(result.geometry!.location.lat.toString());
            // droplatitude[index] = result.geometry!.location.lat.toString();
            // droplongitudes[index] = result.geometry!.location.lng.toString();
            myLoction = result.formattedAddress.toString();
            print("location isss ${droplongitudes[index]} ${droplatitude[index]}");
            setState(() {
            });
            Navigator.of(context).pop();
          },
          initialPosition: LatLng(22.719568, 75.857727),
          useCurrentLocation: true,
        ),
      ),
    );
  }

  String? countryId;

  dynamic selectTimeslot;
  var timefrom;
  String? time_id;
  List<TimeSlotListBooking> timeSlot = [];
  Future<void> getTimeSlot() async {
    var headers = {
      'Cookie': 'ci_session=c4664ff6d31ce6221e37b407dfcd60d4e14b6df3'
    };
    var request = http.Request('POST', Uri.parse(ApiServicves.timeSlots));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      if (finalresult['status'] == 1) {
        timeSlot = GetTimeSlotModel.fromJson(finalresult).booking ?? [];
        setState(() {});
      } else {
        timeSlot.clear();
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  var timeID;

  String? delCharge;
  pickDropDeliveryCalcuate() async {
    var headers = {
      'Cookie': 'ci_session=fe4c2f6a50f816f350af135dfe5a0d5e1806af69'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.pickDropCalculation));
    request.fields.addAll({
      'pick_longitudes[]': longitudes.join(','),
      'pick_latitudes[]': longitudes.join(','),
      'drop_latitudes[]': '$droplatitude',
      'drop_longitudes[]': '$droplongitudes',
      'cabs': vehicleId.toString(),
      'product': (productitem.indexOf(selectproducts.toString()) + 1).toString(),
      'order': selectOrders.toString()
    });
    print("amount for pick and drop ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData = await response.stream.bytesToString();
      var userData = json.decode(responseData);
      if (userData['response_code'] == "1") {
        delCharge = userData['delivery_charge'];
        print("delivery charge is $delCharge");
        setState(() {
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  String? user_id;
  String? order_Id;
  String? message;

  pickDrop() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString('user_id');
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=45dba773e37254fb67da4bb622986088aa57f12d'
    };
    var request = http.Request('POST', Uri.parse(ApiServicves.pickDropOrder));
    request.body = json.encode({
      "user_id":user_id.toString(),
      "vehicle_type":vehicleId.toString(),
      "product_type":(productitem.indexOf(selectproducts.toString()) + 1).toString(),
      "order_type":selectOrders.toString(),
      "sub_total":delCharge.toString(),
      "product_description":productDescriptionCtr.text,
      "note":noteCtr.text,
      "time":time_id.toString(),
      "drop_data":dropList,
      "pick_data":pickList,
    });
    log("final pick drop para ${request.body}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData = await response.stream.bytesToString();
      var userData = json.decode(responseData);
      if (userData['status'] == true) {
        message = userData['message'];
        Fluttertoast.showToast(msg: "${message}");
        order_Id = userData['orderid'];
        print("order id is ${order_Id}");
        await imageUpload();
        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
        setState(() {});
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  imageUpload() async {
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.pickDropImageUpload));
    request.fields.addAll({
      'order_id': '${order_Id.toString()}'
    });
    print("image upload para ${request.fields}");
    request.files.add(await http.MultipartFile.fromPath('image', packageImages!.path.toString()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  List<AreaModelList> areaList = [];
  var areaid;

  getArea() async {
    print("Area apiii isss");
    var headers = {
      'Cookie': 'ci_session=95bbd5f6f543e31f65185f824755bcb57842c775'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiServicves.getArea));
    request.fields.addAll({
      'city_id': '131',
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("===my technic=======${request.url}===============");
    print("===my technic=======${request.fields}===============");
    if (response.statusCode == 200) {
      String responseData = await response.stream.bytesToString();
      print("===my technic=======${responseData}===============");
      var userData = json.decode(responseData);
      if (userData['response_code'] == "1") {
        setState(() {
          areaList = GetAreaModel.fromJson(userData).data ?? [];
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  String? selectOrders;
  String? selectproducts;

  var productitem = ['Urgent', '2 Way', 'Multiple', 'Flexible'];

  var orderitem = [
    'Cake/Fragile',
    'Cooked Meal',
    'Food',
    'Non-Food',
  ];



  List<String?> selectarea1 = [];
  String? selectedValue;

  List<String?> selectarea = [];
  String? selectedValue1;

  List<TextEditingController> dropLocationCtr = [];
  List<String> dropnameCtr = [''];
  List<String> dropphoneCtr = [''];
  List<String> droptypeaddressCtr = [''];

  List<TextEditingController> addressCtr = [];
  List<String> pickupnameCtr = [''];
  List<String> pickupphoneCtr = [''];
  List<String> typaaddressCtr = [''];

  Widget _buildRow(int index) {
    return Container(
      //  color: Color(0xffEFEFEF),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffEFEFEF),
          border: Border.all(
            color: colors.primary,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Drop Details",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              "Drop Location",
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: TextFormField(
                  onTap: () {
                    getDropLocation(index);
                  },
                  controller: dropLocationCtr[index],
                  onChanged: (value) {
                    setState(() {
                      dropLocationCtr[index].text = value.toString();
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      prefixIcon:
                      Icon(Icons.map, color: colors.secondary),
                      counterText: "",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none),
                      hintText: "Select Location On Map",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: TextFormField(
                  initialValue: dropnameCtr[index],
                  onChanged: (value) {
                    setState(() {
                      dropnameCtr[index] = value;
                    });
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person, color: colors.secondary),
                      counterText: "",
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "Drop Name",
                      hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: TextFormField(
                  maxLength: 10,
                  initialValue: dropphoneCtr[index],
                  onChanged: (value) {
                    setState(() {
                      dropphoneCtr[index] = value;
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone,
                          color: colors.secondary),
                      counterText: "",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none),
                      hintText: "Drop Phone Number",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: TextFormField(
                  initialValue: droptypeaddressCtr[index],
                  onChanged: (value) {
                    setState(() {
                      droptypeaddressCtr[index] = value;
                    });
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.location_on,
                          color: colors.secondary),
                      counterText: "",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none),
                      hintText: "Type Address",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
              ),
            ),
          ),

          Card(
            child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    isExpanded: true,
                    value: selectarea1[index],
                    hint: const Text('Select Zone(Area)'),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: areaList.map((items) {
                      return DropdownMenuItem(
                        value: items.id,
                        child: Container(
                            child: Text(items.name.toString())),
                      );
                    }).toList(),
                    onChanged: (dynamic value) {
                      setState(() {
                        selectarea1[index] = value ;
                        print(
                            "===my technic=======${areaid}===============");
                      });
                    },
                    underline: Container(),
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget _buildRow2(int i) {
    return
      Container(
        //  color: Color(0xffEFEFEF),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffEFEFEF),
          border: Border.all(
            color: colors.primary,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "PickUp Location",
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: TextFormField(
                  onTap: () {
                    getLocation(i);
                  },
                  controller: addressCtr[i],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixIcon:
                    Icon(Icons.map, color: colors.secondary),
                    counterText: "",
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 5, horizontal: 5),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none),
                    hintText: "Select Location On Map",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            Card(
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextFormField(
                    initialValue: pickupnameCtr[i],
                    // keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person,
                            color: colors.secondary),
                        counterText: "",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0, horizontal: 0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none),
                        hintText: "PickUp Name",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                ),
              ),
            ),
            Card(
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextFormField(
                    maxLength: 10,
                    initialValue: pickupphoneCtr[i],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone,
                          color: colors.secondary),
                      counterText: "",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none),
                      hintText: "PickUp Phone Number",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            Card(
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextFormField(
                    initialValue: typaaddressCtr[i],
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_on,
                            color: colors.secondary),
                        counterText: "",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0, horizontal: 0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none),
                        hintText: "Type Address",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                ),
              ),
            ),
            Card(
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    isExpanded: true,
                    value: selectarea[i],
                    hint: const Text('Select Zone(Area)'),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: areaList.map((items) {
                      return DropdownMenuItem(
                        value: items.id,
                        child: Container(
                            child: Text(items.name.toString())),
                      );
                    }).toList(),
                    onChanged: (dynamic value) {
                      setState(() {
                        selectarea[i] = value;
                        areaid = value;
                        print(
                            "===my technic=======${areaid}===============");
                      });
                    },
                    underline: Container(),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }

  VehicleData? selectedVehicle;
  List dropList = [];
  List pickList = [];
  String? vehicleId;
  VehicleModel? vehicleItem;

  getVehicle() async {
    var headers = {
      'Cookie': 'ci_session=a13b5d98bb1165c193782ed72de9bf712b5ece9e'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.vehicleList));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var json = jsonDecode(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      vehicleItem = VehicleModel.fromJson(json);
      setState(() {});
    }
    else {
      print(response.reasonPhrase);
    }
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    print("length ${dropnameCtr.length} ${pickupnameCtr.length}");
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //     foregroundColor: colors.whiteTemp,
        //     elevation: 0,
        //     centerTitle: true,
        //     shape: const RoundedRectangleBorder(
        //       borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.circular(25),
        //         bottomRight: Radius.circular(25),
        //       ),
        //     ),
        //
        //     title: const Text('Pick & Drop'),
        //     backgroundColor: colors.primary),
        backgroundColor: Color(0xffE2EBFE), //colors.bgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Send Package",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Upload image",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                InkWell(
                    onTap: () {
                      showAlertDialog(context, "uploadImage");
                    },
                    child: imagesView()),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: dropnameCtr.length == 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectarea.add(selectedValue1); // Add a new row with default city 'Indore'
                            pickupphoneCtr.add('');
                            pickupnameCtr.add('');
                            // addressCtr.add('');
                            typaaddressCtr.add('');
                            Fluttertoast.showToast(msg: "One More PickUp Added");
                          });
                        },
                        child: Container(
                          width: 34,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colors.primary),
                          child: Center(
                            child: Text(
                              "+",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      pickupnameCtr.length == 1 ? SizedBox():
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectarea.last; // Add a new row with default city 'Indore'
                            pickupphoneCtr.remove('');
                            pickupnameCtr.remove('');
                            // addressCtr.add('');
                            typaaddressCtr.remove('');
                            Fluttertoast.showToast(msg: "One PickUp id Remove");
                          });
                        },
                        child: Container(
                          width: 34,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colors.primary),
                          child: Center(
                            child: Text(
                              "-",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize:25
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  itemCount: pickupnameCtr.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _buildRow2(i),
                    );
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                Visibility(
                  visible: pickupnameCtr.length == 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            droptypeaddressCtr.add('');
                            dropnameCtr.add('');
                            dropphoneCtr.add('');
                            selectarea1.add(selectedValue);
                            Fluttertoast.showToast(msg: "One More Drop Added");
                            // dropLocationCtr.add('');
                          });
                        },
                        child: Container(
                          width: 34,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colors.primary),
                          child: Center(
                            child: Text(
                              "+",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                      dropnameCtr.length ==1 ? SizedBox():
                      InkWell(
                        onTap: () {
                          setState(() {
                            droptypeaddressCtr.remove('');
                            dropnameCtr.remove('');
                            dropphoneCtr.remove('');
                            dropLocationCtr.remove('');
                            selectarea1.last;
                            Fluttertoast.showToast(msg: "Drop is Remove");
                          });
                        },
                        child: Container(
                          width: 34,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colors.primary),
                          child: Center(
                            child: Text(
                              "-",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize:25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   //  color: Color(0xffEFEFEF),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: Color(0xffEFEFEF),
                //       border: Border.all(
                //         color: colors.primary,
                //       )),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Padding(
                //         padding: EdgeInsets.all(8.0),
                //         child: Text(
                //           "Drop Details",
                //           style: TextStyle(
                //               fontSize: 20, fontWeight: FontWeight.bold),
                //         ),
                //       ),
                //       const Padding(
                //         padding: EdgeInsets.only(left: 8),
                //         child: Text(
                //           "Drop Location",
                //           style: TextStyle(
                //               fontSize: 15, fontWeight: FontWeight.bold),
                //         ),
                //       ),
                //       Card(
                //         child: Container(
                //           width: double.infinity,
                //           height: 40,
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(10),
                //               color: Colors.white),
                //           child: Padding(
                //             padding: const EdgeInsets.all(1.0),
                //             child: TextFormField(
                //               onTap: () {
                //                 getDropLocation();
                //               },
                //               controller: dropLocationCtr,
                //               keyboardType: TextInputType.number,
                //               decoration: const InputDecoration(
                //                   prefixIcon:
                //                       Icon(Icons.map, color: colors.secondary),
                //                   counterText: "",
                //                   contentPadding: EdgeInsets.symmetric(
                //                       vertical: 5, horizontal: 5),
                //                   border: OutlineInputBorder(
                //                       borderSide: BorderSide.none),
                //                   hintText: "Select Location On Map",
                //                   hintStyle: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.black)),
                //             ),
                //           ),
                //         ),
                //       ),
                //       Card(
                //         child: Container(
                //           width: double.infinity,
                //           height: 40,
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(10),
                //               color: Colors.white),
                //           child: Padding(
                //             padding: const EdgeInsets.all(1.0),
                //             child: TextFormField(
                //               controller: dropnameCtr,
                //               keyboardType: TextInputType.text,
                //               decoration: const InputDecoration(
                //                   prefixIcon: Icon(Icons.person,
                //                       color: colors.secondary),
                //                   counterText: "",
                //                   contentPadding: EdgeInsets.symmetric(
                //                       vertical: 0, horizontal: 0),
                //                   border: OutlineInputBorder(
                //                       borderSide: BorderSide.none),
                //                   hintText: "Drop Name",
                //                   hintStyle: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.black)),
                //             ),
                //           ),
                //         ),
                //       ),
                //       Card(
                //         child: Container(
                //           width: double.infinity,
                //           height: 40,
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(10),
                //               color: Colors.white),
                //           child: Padding(
                //             padding: const EdgeInsets.all(1.0),
                //             child: TextFormField(
                //               maxLength: 10,
                //               controller: dropphoneCtr,
                //               keyboardType: TextInputType.number,
                //               decoration: const InputDecoration(
                //                   prefixIcon: Icon(Icons.phone,
                //                       color: colors.secondary),
                //                   counterText: "",
                //                   contentPadding: EdgeInsets.symmetric(
                //                       vertical: 0, horizontal: 0),
                //                   border: OutlineInputBorder(
                //                       borderSide: BorderSide.none),
                //                   hintText: "Drop Phone Number",
                //                   hintStyle: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.black)),
                //             ),
                //           ),
                //         ),
                //       ),
                //       Card(
                //         child: Container(
                //             width: double.infinity,
                //             height: 40,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(10),
                //                 color: Colors.white),
                //             child: Padding(
                //               padding: const EdgeInsets.all(1.0),
                //               child: TextFormField(
                //                 controller: droptypeaddressCtr,
                //                 keyboardType: TextInputType.text,
                //                 decoration: const InputDecoration(
                //                     prefixIcon: Icon(Icons.location_on,
                //                         color: colors.secondary),
                //                     counterText: "",
                //                     contentPadding: EdgeInsets.symmetric(
                //                         vertical: 0, horizontal: 0),
                //                     border: OutlineInputBorder(
                //                         borderSide: BorderSide.none),
                //                     hintText: "Type Address",
                //                     hintStyle: TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                         color: Colors.black)),
                //               ),
                //             )),
                //       ),
                //       Card(
                //         child: Container(
                //             width: double.infinity,
                //             height: 40,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(10),
                //                 color: Colors.white),
                //             child: Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: DropdownButton(
                //                 isExpanded: true,
                //                 value: selectarea1,
                //                 hint: const Text('Select Zone(Area)'),
                //                 icon: const Icon(Icons.keyboard_arrow_down),
                //                 items: areaList.map((items) {
                //                   return DropdownMenuItem(
                //                     value: items,
                //                     child: Container(
                //                         child: Text(items.name.toString())),
                //                   );
                //                 }).toList(),
                //                 onChanged: (dynamic value) {
                //                   setState(() {
                //                     selectarea1 = value;
                //                     areaid = value.id.toString();
                //                     print(
                //                         "===my technic=======${areaid}===============");
                //                   });
                //                 },
                //                 underline: Container(),
                //               ),
                //             )),
                //       )
                //     ],
                //   ),
                // ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: dropnameCtr.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _buildRow(index),
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Flexible Time",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio<String>(
                      value: 'Yes',
                      groupValue: _selectedOption,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                    Text('Yes'),
                    Radio<String>(
                      value: 'No',
                      groupValue: _selectedOption,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                    Text('No'),
                    // Add more radio buttons here if needed
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "Time :",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonFormField<TimeSlotListBooking>(
                    value: selectTimeslot,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: colors.primary,
                    ),
                    onChanged: ( newValue) {
                      setState(() {
                        selectTimeslot = newValue;
                        time_id = newValue?.id.toString();
                        timefrom ="${newValue?.fromTime.toString()}-${newValue?.toTime.toString()}";
                        print("time from=======$timefrom time id is $time_id===============");
                      });
                    },
                    items: timeSlot.map((TimeSlotListBooking orderitem) {
                      return DropdownMenuItem(
                        value: orderitem,
                        child: SizedBox(
                            width:
                            MediaQuery.of(context).size.width / 1.5,
                            child: Text("${orderitem.fromTime.toString()} - ${orderitem.toTime.toString()}",
                              style: const TextStyle(
                                  color: colors.secondary),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        hintText: 'Select Time Slot',
                        hintStyle: TextStyle(color: colors.primary),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Product Type",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text("",
                        style: TextStyle(
                            fontSize: 1, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: DropdownButtonFormField<String>(
                    value: selectOrders,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: colors.primary,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectOrders = newValue!;
                        print(
                            "===my technic=======$selectOrders===============");
                      });
                    },
                    items: orderitem.map((String orderitem) {
                      return DropdownMenuItem(
                        value: orderitem,
                        child: Text(
                          orderitem.toString(),
                          style: const TextStyle(color: colors.secondary),
                        ),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        hintText: 'Select Product Type',
                        hintStyle: TextStyle(color: colors.primary),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Order Type",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      Text("",
                          style: TextStyle(
                              fontSize: 1, fontWeight: FontWeight.w400))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: DropdownButtonFormField<String>(
                    value: selectproducts,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: colors.primary,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectproducts = newValue!;
                        print(
                            "===my technic=======$selectOrders===============");
                      });
                    },
                    items: productitem.map((String orderitem) {
                      return DropdownMenuItem(
                        value: orderitem,
                        child: Text(
                          orderitem.toString(),
                          style: const TextStyle(color: colors.secondary),
                        ),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        hintText: 'Select Order Type',
                        hintStyle: TextStyle(color: colors.primary),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Vehicle Type",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      Text("",
                          style: TextStyle(
                              fontSize: 1, fontWeight: FontWeight.w400))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: DropdownButtonFormField<VehicleData>(
                    value: selectedVehicle,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: colors.primary,
                    ),
                    onChanged: (VehicleData? newValue) {
                      setState(() {
                        selectedVehicle = newValue!;
                        vehicleId = selectedVehicle?.id.toString();
                        print("vehicle select${selectedVehicle} vehicle id ${vehicleId}==============");
                        pickDropDeliveryCalcuate();
                        // getDeliveryCharges(
                        //     vType: selectedVehicle.toString());
                      });
                    },
                    items: vehicleItem?.data?.map((VehicleData orderitem) {
                      return DropdownMenuItem(
                        value: orderitem,
                        child: Image.network("https://developmentalphawizz.com/hojayega/${orderitem.image}"),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        hintText: 'Select Vehicle Type',
                        hintStyle: TextStyle(color: colors.primary),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "Product Description(Optional)",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    child: TextFormField(
                      controller: productDescriptionCtr,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          counterText: "",
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          border:
                          OutlineInputBorder(borderSide: BorderSide.none),
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    children: const [
                      Text(
                        "Note",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: TextFormField(
                      controller: noteCtr,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          counterText: "",
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          border:
                          OutlineInputBorder(borderSide: BorderSide.none),
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffFFFFFF),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text(
                            "Amount",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          delCharge ==null || delCharge == "" ?
                          Text("0.0"):
                          Text(
                            "${delCharge.toString()}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, top: 30),
                  child: InkWell(
                    // onTap: () {
                    //   if (addressCtr.isEmpty) {
                    //     Fluttertoast.showToast(msg: "Please Select Address");
                    //   } else if (pickupnameCtr.isEmpty) {
                    //     Fluttertoast.showToast(msg: "Please Select PickupName");
                    //   } else if (pickupphoneCtr.isEmpty) {
                    //     Fluttertoast.showToast(msg: "Please Select PickupPhone");
                    //   } else if (droptypeaddressCtr.isEmpty) {
                    //     Fluttertoast.showToast(msg: "Please Select DropTypeAddress");
                    //   } else if (dropLocationCtr.isEmpty) {
                    //     Fluttertoast.showToast(msg: "Please Select DropAddress");
                    //   } else if (dropnameCtr.isEmpty) {
                    //     Fluttertoast.showToast(msg: "Please Select DropName");
                    //   } else if (dropphoneCtr.isEmpty) {
                    //     Fluttertoast.showToast(msg: "Please Select DropPhone");
                    //   } else if (selectarea1 == null) {
                    //     Fluttertoast.showToast(msg: "Please Select Area");
                    //   } else if (selectarea == null) {
                    //     Fluttertoast.showToast(msg: "Please Select Area");
                    //   } else if (noteCtr.text.isEmpty) {
                    //     Fluttertoast.showToast(msg: "Please Select Note");
                    //   } else if (selectOrders!.isEmpty) {
                    //     Fluttertoast.showToast(msg: "Please Select OrderType");
                    //   } else if (selectproducts!.isEmpty) {
                    //     Fluttertoast.showToast(msg: "Please Select ProductType");
                    //   } else if (selectedVehicle == null || selectedVehicle == "") {
                    //     Fluttertoast.showToast(msg: "Please Select VehicleType");
                    //   }
                    //   else if (packageImages == null || packageImages == "") {
                    //     Fluttertoast.showToast(msg: "Please Select Image");
                    //   } else if (typaaddressCtr.isEmpty) {
                    //     Fluttertoast.showToast(
                    //         msg: "Please Select TypeAddress");
                    //   } else {
                    //     pickDrop();
                    //   }
                    // },
                    onTap: (){
                      for(int i = 0; i<dropnameCtr.length ; i++) {
                        dropList.add((
                            {
                              "drop_location": dropLocationCtr[i].text,
                              "drop_name": dropnameCtr[i],
                              "drop_phone": dropphoneCtr[i],
                              "drop_address_type": droptypeaddressCtr[i],
                              "drop_zone": selectarea1[i],
                              "drop_latitude": droplatitude[i],
                              "drop_longitude": droplongitudes[i]
                            }
                        ));
                      }
                      for(int k = 0; k<pickupnameCtr.length ; k++) {
                        pickList.add((
                            {
                              "pick_location": addressCtr[k].text,
                              "pick_name": pickupnameCtr[k],
                              "pick_phone": pickupphoneCtr[k],
                              "pick_address_type": typaaddressCtr[k],
                              "pick_zone": selectarea[k],
                              "latitude_input": latitude[k],
                              "longitude_input": longitudes[k]
                            }
                        ));
                      }
                      pickDrop();
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: colors.secondary,
                      ),
                      child: const Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
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
    );
  }
}
