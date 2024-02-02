// To parse this JSON data, do
//
//     final getVendorOrderModel = getVendorOrderModelFromJson(jsonString);

import 'dart:convert';

GetVendorOrderModel getVendorOrderModelFromJson(String str) => GetVendorOrderModel.fromJson(json.decode(str));

String getVendorOrderModelToJson(GetVendorOrderModel data) => json.encode(data.toJson());

class GetVendorOrderModel {
  String responseCode;
  String message;
  List<VendorOrders> orders;
  String status;

  GetVendorOrderModel({
    required this.responseCode,
    required this.message,
    required this.orders,
    required this.status,
  });

  factory GetVendorOrderModel.fromJson(Map<String, dynamic> json) => GetVendorOrderModel(
    responseCode: json["response_code"],
    message: json["message"],
    orders: List<VendorOrders>.from(json["orders"].map((x) => VendorOrders.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "response_code": responseCode,
    "message": message,
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
    "status": status,
  };
}

class VendorOrders {
  DriverData driverData;
  String orderId;
  String total;
  DateTime date;
  String username;
  String mobile;
  String paymentMode;
  String address;
  String ordersType;
  String vehicleType;
  String time;
  String orderStatus;
  String paymentStatus;
  String acceptRejectVendor;
  String deliveryCharge;
  String discount;
  String region;
  List<OrderItem> orderItems;
  int count;

  VendorOrders({
    required this.driverData,
    required this.orderId,
    required this.total,
    required this.date,
    required this.username,
    required this.mobile,
    required this.paymentMode,
    required this.address,
    required this.ordersType,
    required this.vehicleType,
    required this.time,
    required this.orderStatus,
    required this.paymentStatus,
    required this.acceptRejectVendor,
    required this.deliveryCharge,
    required this.discount,
    required this.region,
    required this.orderItems,
    required this.count,
  });

  factory VendorOrders.fromJson(Map<String, dynamic> json) => VendorOrders(
    driverData: DriverData.fromJson(json["driver_data"]),
    orderId: json["order_id"],
    total: json["total"],
    date: DateTime.parse(json["date"]),
    username: json["username"],
    mobile: json["mobile"],
    paymentMode: json["payment_mode"],
    address: json["address"],
    ordersType: json["orders_type"],
    vehicleType: json["vehicle_type"],
    time: json["time"],
    orderStatus: json["order_status"],
    paymentStatus: json["payment_status"],
    acceptRejectVendor: json["accept_reject_vendor"],
    deliveryCharge: json["delivery_charge"],
    discount: json["discount"],
    region: json["region"],
    orderItems: List<OrderItem>.from(json["order_items"].map((x) => OrderItem.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "driver_data": driverData.toJson(),
    "order_id": orderId,
    "total": total,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "username": username,
    "mobile": mobile,
    "payment_mode": paymentMode,
    "address": address,
    "orders_type": ordersType,
    "vehicle_type": vehicleType,
    "time": time,
    "order_status": orderStatus,
    "payment_status": paymentStatus,
    "accept_reject_vendor": acceptRejectVendor,
    "delivery_charge": deliveryCharge,
    "discount": discount,
    "region": region,
    "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
    "count": count,
  };
}

class DriverData {
  String name;
  String mobile;
  String email;

  DriverData({
    required this.name,
    required this.mobile,
    required this.email,
  });

  factory DriverData.fromJson(Map<String, dynamic> json) => DriverData(
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile": mobile,
    "email": email,
  };
}

class OrderItem {
  String productId;
  String catId;
  String subcatId;
  String childCategory;
  String productName;
  String productDescription;
  String productPrice;
  String productImage;
  String proRatings;
  String roleId;
  String sellingPrice;
  DateTime productCreateDate;
  String vendorId;
  String otherImage;
  String productStatus;
  String variantName;
  String productType;
  String tax;
  String unit;
  String unitType;
  String qty;

  OrderItem({
    required this.productId,
    required this.catId,
    required this.subcatId,
    required this.childCategory,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productImage,
    required this.proRatings,
    required this.roleId,
    required this.sellingPrice,
    required this.productCreateDate,
    required this.vendorId,
    required this.otherImage,
    required this.productStatus,
    required this.variantName,
    required this.productType,
    required this.tax,
    required this.unit,
    required this.unitType,
    required this.qty,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    productId: json["product_id"],
    catId: json["cat_id"],
    subcatId: json["subcat_id"],
    childCategory: json["child_category"],
    productName: json["product_name"],
    productDescription: json["product_description"],
    productPrice: json["product_price"],
    productImage: json["product_image"],
    proRatings: json["pro_ratings"],
    roleId: json["role_id"],
    sellingPrice: json["selling_price"],
    productCreateDate: DateTime.parse(json["product_create_date"]),
    vendorId: json["vendor_id"],
    otherImage: json["other_image"],
    productStatus: json["product_status"],
    variantName: json["variant_name"],
    productType: json["product_type"],
    tax: json["tax"],
    unit: json["unit"],
    unitType: json["unit_type"],
    qty: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "cat_id": catId,
    "subcat_id": subcatId,
    "child_category": childCategory,
    "product_name": productName,
    "product_description": productDescription,
    "product_price": productPrice,
    "product_image": productImage,
    "pro_ratings": proRatings,
    "role_id": roleId,
    "selling_price": sellingPrice,
    "product_create_date": productCreateDate.toIso8601String(),
    "vendor_id": vendorId,
    "other_image": otherImage,
    "product_status": productStatus,
    "variant_name": variantName,
    "product_type": productType,
    "tax": tax,
    "unit": unit,
    "unit_type": unitType,
    "qty": qty,
  };
}
