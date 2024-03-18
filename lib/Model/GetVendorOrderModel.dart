class GetVendorOrderModel {
  GetVendorOrderModel({
    required this.responseCode,
    required this.message,
    required this.orders,
    required this.status,
  });

  final String? responseCode;
  final String? message;
  final List<VendorOrder> orders;
  final String? status;

  factory GetVendorOrderModel.fromJson(Map<String, dynamic> json){
    return GetVendorOrderModel(
      responseCode: json["response_code"],
      message: json["message"],
      orders: json["orders"] == null ? [] : List<VendorOrder>.from(json["orders"]!.map((x) => VendorOrder.fromJson(x))),
      status: json["status"],
    );
  }

}

class VendorOrder {
  VendorOrder({
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

  final List<DriverDatum> driverData;
  final String? orderId;
  final String? total;
  final DateTime? date;
  final String? username;
  final String? mobile;
  final String? paymentMode;
  final String? address;
  final String? ordersType;
  final String? vehicleType;
  final String? time;
  final String? orderStatus;
  final String? paymentStatus;
  final String? acceptRejectVendor;
  final String? deliveryCharge;
  final String? discount;
  final String? region;
  final List<OrderItem> orderItems;
  final int? count;

  factory VendorOrder.fromJson(Map<String, dynamic> json){
    return VendorOrder(
      driverData: json["driver_data"] == null ? [] : List<DriverDatum>.from(json["driver_data"]!.map((x) => DriverDatum.fromJson(x))),
      orderId: json["order_id"],
      total: json["total"],
      date: DateTime.tryParse(json["date"] ?? ""),
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
      orderItems: json["order_items"] == null ? [] : List<OrderItem>.from(json["order_items"]!.map((x) => OrderItem.fromJson(x))),
      count: json["count"],
    );
  }

}

class DriverDatum {
  DriverDatum({
    required this.name,
    required this.mobile,
    required this.email,
  });

  final String? name;
  final String? mobile;
  final String? email;

  factory DriverDatum.fromJson(Map<String, dynamic> json){
    return DriverDatum(
      name: json["name"],
      mobile: json["mobile"],
      email: json["email"],
    );
  }

}

class OrderItem {
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

  final String? productId;
  final String? catId;
  final String? subcatId;
  final String? childCategory;
  final String? productName;
  final String? productDescription;
  final String? productPrice;
  final String? productImage;
  final String? proRatings;
  final String? roleId;
  final String? sellingPrice;
  final DateTime? productCreateDate;
  final String? vendorId;
  final String? otherImage;
  final String? productStatus;
  final String? variantName;
  final String? productType;
  final String? tax;
  final String? unit;
  final String? unitType;
  final String? qty;

  factory OrderItem.fromJson(Map<String, dynamic> json){
    return OrderItem(
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
      productCreateDate: DateTime.tryParse(json["product_create_date"] ?? ""),
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
  }

}
