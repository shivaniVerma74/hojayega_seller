import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApiServicves{

  static const String baseUrl = "https://developmentalphawizz.com/hojayega/Vendorapi/";
  static const String imageUrl = "https://developmentalphawizz.com/hojayega/";

  static const String veriftOtp = baseUrl+'verify_otp';
  static const String vendorregister = baseUrl+'vendor_registration';
  static const String login = baseUrl+'login';
  static const String getProfile = baseUrl+'get_profile';
  static const String vendorsendOtp = baseUrl+'send_otp';
  static const String updateProfile = baseUrl+'vendor_update';
  static const String getState = baseUrl+'get_states';
  static const String getCities = baseUrl+'get_cities';
  static const String sendOtpforgetpassword = baseUrl + 'forgot_pass_user';
  static const String getArea = baseUrl+'get_regions';
  static const String resetpassword = baseUrl + 'reset_password';
  static const String getBanners = baseUrl+'get_banners';
  static const String getCategories = baseUrl+'get_categories_by_shop_services';
  static const String getVendorServices = baseUrl+'get_vendor_services';
  static const String deleteService = baseUrl+'delete_service';
  static const String updateServiceStatus = baseUrl+'update_service_status';
  static const String vendorDeals = baseUrl+'vendor_deals';
  static const String addServicesVendor = baseUrl+'add_services_vendor';
  static const String updateServicesVendor = baseUrl+'update_service_vendor';
  static const String getVendorProduct = baseUrl+'get_vendor_products';
  static const String getSubCategories = baseUrl+'get_categories_by_shop_services';
  static const String productchildCategories = baseUrl+'product_child_category';
  static const String typeofShops = baseUrl+'type_shops';
  static const String addProducts = baseUrl+'add_product';
  static const String vendorOrders = baseUrl+'get_vendor_orders';
  static const String getVendorBookings = baseUrl+'get_bookings';
  static const String timeSlots = baseUrl+'get_time_slot';
  static const String acceptRejectOrder = baseUrl+'accept_reject_order';
  static const String notifications = baseUrl+'notifications';
  static const String clearNotification = baseUrl+'clear_all';
  static const String addAmount = baseUrl+'add_wallet';
  static const String walletTransaction = baseUrl+'get_wallet_transactions';
  static const String onOffStatus = baseUrl+'update_open_close_status';
  static const String promotionList = baseUrl+'get_promotion_banner';
  static const String sec15ListApi = baseUrl+'get_15_secound_ads';
  static const String updateOrderItem = baseUrl+'update_orders_items';
  static const String updateOrders = baseUrl+'update_orders';
  static const String checkAvailablity = baseUrl+'check_availibility';
  static const String promotionAdd = baseUrl+'add_promotion';
  static const String getSettings = baseUrl+'general_setting';
  static const String offers = baseUrl+'offer_add';
  static const String completeBookings = baseUrl+'complete_booking';
  static const String vehicleList = baseUrl+'get_vehicle_list';
  static const String deliveryChargeByDistance = baseUrl+'get_delivery_charge_distacee';
  static const String getAllAddProduct = baseUrl+'get_vendor_all_products';
  static const String unitsAPi = baseUrl+'get_unit_list';
}

String? vendor_name;
String? vendor_mobile;
String? vendor_email;

class DrawerIconTab extends StatefulWidget {
  final IconData? icon;
  final String? titlee;
  final int? tabb;
  final int? indexx;

  DrawerIconTab({Key? key, this.icon, this.titlee, this.tabb, this.indexx}) : super(key: key);

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