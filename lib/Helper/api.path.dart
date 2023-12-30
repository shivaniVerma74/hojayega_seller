import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApiServicves{

  static const String baseUrl = "https://developmentalphawizz.com/hojayega/Vendorapi/";
  static const String imageUrl = "https://developmentalphawizz.com/hojayega/";

  static const String veriftOtp = baseUrl+'verify_otp';
  static const String Vendorregister = baseUrl+'vendor_registration';
  static const String login = baseUrl+'login';
  static const String vendorsendOtp = baseUrl+'send_otp';
  static const String getState = baseUrl+'get_states';
  static const String getCities = baseUrl+'get_cities';
  static const String getArea = baseUrl+'get_regions';
  static const String getBanners = baseUrl+'get_banners';
  static const String getCategories = baseUrl+'get_categories_by_shop_services';
  static const String getSubCategories = baseUrl+'get_categories_by_shop_services';
  static const String productchildCategories = baseUrl+'product_child_category';
  static const String typeofShops = baseUrl+'type_shops';
  static const String addProducts = baseUrl+'add_product';
}

String? vendor_id;
String? vendor_name;
String? vendor_mobile;
String? vendor_email;



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