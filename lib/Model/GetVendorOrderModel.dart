class GetVendorOrderModel {
  String? responseCode;
  String? message;
  List<VendorOrder>? orders;
  String? status;

  GetVendorOrderModel(
      {this.responseCode, this.message, this.orders, this.status});

  GetVendorOrderModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['orders'] != null) {
      orders = <VendorOrder>[];
      json['orders'].forEach((v) {
        orders!.add(new VendorOrder.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class VendorOrder {
  List<DriverData>? driverData;
  String? orderId;
  String? total;
  String? vehicleType;
  String? invoice;
  String? date;
  String? username;
  String? mobile;
  String? paymentMode;
  String? address;
  String? ordersType;
  String? time;
  String? orderStatus;
  String? paymentStatus;
  String? acceptRejectVendor;
  String? deliveryCharge;
  String? discount;
  String? lat;
  String? lang;
  String? vendorLat;
  String? vendorLang;
  String? region;
  List<OrderItems>? orderItems;
  int? count;

  VendorOrder(
      {this.driverData,
        this.orderId,
        this.total,
        this.vehicleType,
        this.invoice,
        this.date,
        this.username,
        this.mobile,
        this.paymentMode,
        this.address,
        this.ordersType,
        this.time,
        this.orderStatus,
        this.paymentStatus,
        this.acceptRejectVendor,
        this.deliveryCharge,
        this.discount,
        this.lat,
        this.lang,
        this.vendorLat,
        this.vendorLang,
        this.region,
        this.orderItems,
        this.count});

  VendorOrder.fromJson(Map<String, dynamic> json) {
    if (json['driver_data'] != null) {
      driverData = <DriverData>[];
      json['driver_data'].forEach((v) {
        driverData!.add(new DriverData.fromJson(v));
      });
    }
    orderId = json['order_id'];
    total = json['total'];
    vehicleType = json['vehicle_type'];
    invoice = json['invoice'];
    date = json['date'];
    username = json['username'];
    mobile = json['mobile'];
    paymentMode = json['payment_mode'];
    address = json['address'];
    ordersType = json['orders_type'];
    time = json['time'];
    orderStatus = json['order_status'];
    paymentStatus = json['payment_status'];
    acceptRejectVendor = json['accept_reject_vendor'];
    deliveryCharge = json['delivery_charge'];
    discount = json['discount'];
    lat = json['lat'];
    lang = json['lang'];
    vendorLat = json['vendor_lat'];
    vendorLang = json['vendor_lang'];
    region = json['region'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.driverData != null) {
      data['driver_data'] = this.driverData!.map((v) => v.toJson()).toList();
    }
    data['order_id'] = this.orderId;
    data['total'] = this.total;
    data['vehicle_type'] = this.vehicleType;
    data['invoice'] = this.invoice;
    data['date'] = this.date;
    data['username'] = this.username;
    data['mobile'] = this.mobile;
    data['payment_mode'] = this.paymentMode;
    data['address'] = this.address;
    data['orders_type'] = this.ordersType;
    data['time'] = this.time;
    data['order_status'] = this.orderStatus;
    data['payment_status'] = this.paymentStatus;
    data['accept_reject_vendor'] = this.acceptRejectVendor;
    data['delivery_charge'] = this.deliveryCharge;
    data['discount'] = this.discount;
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    data['vendor_lat'] = this.vendorLat;
    data['vendor_lang'] = this.vendorLang;
    data['region'] = this.region;
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class DriverData {
  String? name;
  String? mobile;
  String? email;

  DriverData({this.name, this.mobile, this.email});

  DriverData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    return data;
  }
}

class OrderItems {
  String? productId;
  String? catId;
  String? subcatId;
  String? childCategory;
  String? productName;
  String? productDescription;
  String? productPrice;
  String? productImage;
  String? proRatings;
  String? roleId;
  String? sellingPrice;
  String? productCreateDate;
  String? vendorId;
  String? otherImage;
  String? productStatus;
  String? variantName;
  String? productType;
  String? tax;
  String? unit;
  String? unitType;
  String? qty;
  String? subtotal;

  OrderItems(
      {this.productId,
        this.catId,
        this.subcatId,
        this.childCategory,
        this.productName,
        this.productDescription,
        this.productPrice,
        this.productImage,
        this.proRatings,
        this.roleId,
        this.sellingPrice,
        this.productCreateDate,
        this.vendorId,
        this.otherImage,
        this.productStatus,
        this.variantName,
        this.productType,
        this.tax,
        this.unit,
        this.unitType,
        this.qty,
        this.subtotal});

  OrderItems.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    catId = json['cat_id'];
    subcatId = json['subcat_id'];
    childCategory = json['child_category'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    productPrice = json['product_price'];
    productImage = json['product_image'];
    proRatings = json['pro_ratings'];
    roleId = json['role_id'];
    sellingPrice = json['selling_price'];
    productCreateDate = json['product_create_date'];
    vendorId = json['vendor_id'];
    otherImage = json['other_image'];
    productStatus = json['product_status'];
    variantName = json['variant_name'];
    productType = json['product_type'];
    tax = json['tax'];
    unit = json['unit'];
    unitType = json['unit_type'];
    qty = json['qty'];
    subtotal = json['subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['cat_id'] = this.catId;
    data['subcat_id'] = this.subcatId;
    data['child_category'] = this.childCategory;
    data['product_name'] = this.productName;
    data['product_description'] = this.productDescription;
    data['product_price'] = this.productPrice;
    data['product_image'] = this.productImage;
    data['pro_ratings'] = this.proRatings;
    data['role_id'] = this.roleId;
    data['selling_price'] = this.sellingPrice;
    data['product_create_date'] = this.productCreateDate;
    data['vendor_id'] = this.vendorId;
    data['other_image'] = this.otherImage;
    data['product_status'] = this.productStatus;
    data['variant_name'] = this.variantName;
    data['product_type'] = this.productType;
    data['tax'] = this.tax;
    data['unit'] = this.unit;
    data['unit_type'] = this.unitType;
    data['qty'] = this.qty;
    data['subtotal'] = this.subtotal;
    return data;
  }
}
