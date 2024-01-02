/// response_code : "1"
/// message : "Orders Found"
/// orders : [{"driver_data":{"name":"testing","mobile":"7852365890","email":"testing@gmail.com"},"order_id":"330","total":"100","date":"2023-12-29","username":"Abhay singh","mobile":"8878505050","payment_mode":"COD","address":"","orders_type":"","vehicle_type":"1","time":"1","order_status":"0","order_items":[{"product_id":"1","cat_id":"1","subcat_id":"2","child_category":"2","product_name":"Dawat Biryani","product_description":"Dawat Biryani","product_price":"500","product_image":"https://developmentalphawizz.com/hojayega/","pro_ratings":"0.0","role_id":"","selling_price":"100","product_create_date":"2023-12-28 19:06:53","vendor_id":"139","other_image":"","product_status":"1","variant_name":"","product_type":"","tax":"0","unit":"1kg","qty":"5"},{"product_id":"1","cat_id":"1","subcat_id":"2","child_category":"2","product_name":"Dawat Biryani","product_description":"Dawat Biryani","product_price":"500","product_image":"https://developmentalphawizz.com/hojayega/","pro_ratings":"0.0","role_id":"","selling_price":"100","product_create_date":"2023-12-28 19:06:53","vendor_id":"139","other_image":"","product_status":"1","variant_name":"","product_type":"","tax":"0","unit":"1kg","qty":"5"}],"count":10},{"driver_data":"","order_id":"329","total":"200","date":"2023-12-29","username":"Abhay singh","mobile":"8878505050","payment_mode":"","address":"","orders_type":"","vehicle_type":"1","time":"1","order_status":"0","order_items":[{"qty":"5"},{"qty":"5"}],"count":10}]
/// status : "success"

class GetVendorOrderModel {
  GetVendorOrderModel({
      String? responseCode, 
      String? message, 
      List<VendorOrders>? orders,
      String? status,}){
    _responseCode = responseCode;
    _message = message;
    _orders = orders;
    _status = status;
}

  GetVendorOrderModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    if (json['orders'] != null) {
      _orders = [];
      json['orders'].forEach((v) {
        _orders?.add(VendorOrders.fromJson(v));
      });
    }
    _status = json['status'];
  }
  String? _responseCode;
  String? _message;
  List<VendorOrders>? _orders;
  String? _status;
GetVendorOrderModel copyWith({  String? responseCode,
  String? message,
  List<VendorOrders>? orders,
  String? status,
}) => GetVendorOrderModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  orders: orders ?? _orders,
  status: status ?? _status,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  List<VendorOrders>? get orders => _orders;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    if (_orders != null) {
      map['orders'] = _orders?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    return map;
  }

}

/// driver_data : {"name":"testing","mobile":"7852365890","email":"testing@gmail.com"}
/// order_id : "330"
/// total : "100"
/// date : "2023-12-29"
/// username : "Abhay singh"
/// mobile : "8878505050"
/// payment_mode : "COD"
/// address : ""
/// orders_type : ""
/// vehicle_type : "1"
/// time : "1"
/// order_status : "0"
/// order_items : [{"product_id":"1","cat_id":"1","subcat_id":"2","child_category":"2","product_name":"Dawat Biryani","product_description":"Dawat Biryani","product_price":"500","product_image":"https://developmentalphawizz.com/hojayega/","pro_ratings":"0.0","role_id":"","selling_price":"100","product_create_date":"2023-12-28 19:06:53","vendor_id":"139","other_image":"","product_status":"1","variant_name":"","product_type":"","tax":"0","unit":"1kg","qty":"5"},{"product_id":"1","cat_id":"1","subcat_id":"2","child_category":"2","product_name":"Dawat Biryani","product_description":"Dawat Biryani","product_price":"500","product_image":"https://developmentalphawizz.com/hojayega/","pro_ratings":"0.0","role_id":"","selling_price":"100","product_create_date":"2023-12-28 19:06:53","vendor_id":"139","other_image":"","product_status":"1","variant_name":"","product_type":"","tax":"0","unit":"1kg","qty":"5"}]
/// count : 10

class VendorOrders {
  VendorOrders({
      DriverData? driverData, 
      String? orderId, 
      String? total, 
      String? date, 
      String? username, 
      String? mobile, 
      String? paymentMode, 
      String? address, 
      String? ordersType, 
      String? vehicleType, 
      String? time, 
      String? orderStatus, 
      List<OrderItems>? orderItems, 
      num? count,}){
    _driverData = driverData;
    _orderId = orderId;
    _total = total;
    _date = date;
    _username = username;
    _mobile = mobile;
    _paymentMode = paymentMode;
    _address = address;
    _ordersType = ordersType;
    _vehicleType = vehicleType;
    _time = time;
    _orderStatus = orderStatus;
    _orderItems = orderItems;
    _count = count;
}

  VendorOrders.fromJson(dynamic json) {
    _driverData = json['driver_data'] != null&&json['driver_data']!="" ? DriverData.fromJson(json['driver_data']) : null;
    _orderId = json['order_id'];
    _total = json['total'];
    _date = json['date'];
    _username = json['username'];
    _mobile = json['mobile'];
    _paymentMode = json['payment_mode'];
    _address = json['address'];
    _ordersType = json['orders_type'];
    _vehicleType = json['vehicle_type'];
    _time = json['time'];
    _orderStatus = json['order_status'];
    if (json['order_items'] != null) {
      _orderItems = [];
      json['order_items'].forEach((v) {
        _orderItems?.add(OrderItems.fromJson(v));
      });
    }
    _count = json['count'];
  }
  dynamic _driverData;
  String? _orderId;
  String? _total;
  String? _date;
  String? _username;
  String? _mobile;
  String? _paymentMode;
  String? _address;
  String? _ordersType;
  String? _vehicleType;
  String? _time;
  String? _orderStatus;
  List<OrderItems>? _orderItems;
  num? _count;
  VendorOrders copyWith({  DriverData? driverData,
  String? orderId,
  String? total,
  String? date,
  String? username,
  String? mobile,
  String? paymentMode,
  String? address,
  String? ordersType,
  String? vehicleType,
  String? time,
  String? orderStatus,
  List<OrderItems>? orderItems,
  num? count,
}) => VendorOrders(  driverData: driverData ?? _driverData,
  orderId: orderId ?? _orderId,
  total: total ?? _total,
  date: date ?? _date,
  username: username ?? _username,
  mobile: mobile ?? _mobile,
  paymentMode: paymentMode ?? _paymentMode,
  address: address ?? _address,
  ordersType: ordersType ?? _ordersType,
  vehicleType: vehicleType ?? _vehicleType,
  time: time ?? _time,
  orderStatus: orderStatus ?? _orderStatus,
  orderItems: orderItems ?? _orderItems,
  count: count ?? _count,
);
  DriverData? get driverData => _driverData;
  String? get orderId => _orderId;
  String? get total => _total;
  String? get date => _date;
  String? get username => _username;
  String? get mobile => _mobile;
  String? get paymentMode => _paymentMode;
  String? get address => _address;
  String? get ordersType => _ordersType;
  String? get vehicleType => _vehicleType;
  String? get time => _time;
  String? get orderStatus => _orderStatus;
  List<OrderItems>? get orderItems => _orderItems;
  num? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_driverData != null) {
      map['driver_data'] = _driverData?.toJson();
    }
    map['order_id'] = _orderId;
    map['total'] = _total;
    map['date'] = _date;
    map['username'] = _username;
    map['mobile'] = _mobile;
    map['payment_mode'] = _paymentMode;
    map['address'] = _address;
    map['orders_type'] = _ordersType;
    map['vehicle_type'] = _vehicleType;
    map['time'] = _time;
    map['order_status'] = _orderStatus;
    if (_orderItems != null) {
      map['order_items'] = _orderItems?.map((v) => v.toJson()).toList();
    }
    map['count'] = _count;
    return map;
  }

}

/// product_id : "1"
/// cat_id : "1"
/// subcat_id : "2"
/// child_category : "2"
/// product_name : "Dawat Biryani"
/// product_description : "Dawat Biryani"
/// product_price : "500"
/// product_image : "https://developmentalphawizz.com/hojayega/"
/// pro_ratings : "0.0"
/// role_id : ""
/// selling_price : "100"
/// product_create_date : "2023-12-28 19:06:53"
/// vendor_id : "139"
/// other_image : ""
/// product_status : "1"
/// variant_name : ""
/// product_type : ""
/// tax : "0"
/// unit : "1kg"
/// qty : "5"

class OrderItems {
  OrderItems({
      String? productId, 
      String? catId, 
      String? subcatId, 
      String? childCategory, 
      String? productName, 
      String? productDescription, 
      String? productPrice, 
      String? productImage, 
      String? proRatings, 
      String? roleId, 
      String? sellingPrice, 
      String? productCreateDate, 
      String? vendorId, 
      String? otherImage, 
      String? productStatus, 
      String? variantName, 
      String? productType, 
      String? tax, 
      String? unit, 
      String? qty,}){
    _productId = productId;
    _catId = catId;
    _subcatId = subcatId;
    _childCategory = childCategory;
    _productName = productName;
    _productDescription = productDescription;
    _productPrice = productPrice;
    _productImage = productImage;
    _proRatings = proRatings;
    _roleId = roleId;
    _sellingPrice = sellingPrice;
    _productCreateDate = productCreateDate;
    _vendorId = vendorId;
    _otherImage = otherImage;
    _productStatus = productStatus;
    _variantName = variantName;
    _productType = productType;
    _tax = tax;
    _unit = unit;
    _qty = qty;
}

  OrderItems.fromJson(dynamic json) {
    _productId = json['product_id'];
    _catId = json['cat_id'];
    _subcatId = json['subcat_id'];
    _childCategory = json['child_category'];
    _productName = json['product_name'];
    _productDescription = json['product_description'];
    _productPrice = json['product_price'];
    _productImage = json['product_image'];
    _proRatings = json['pro_ratings'];
    _roleId = json['role_id'];
    _sellingPrice = json['selling_price'];
    _productCreateDate = json['product_create_date'];
    _vendorId = json['vendor_id'];
    _otherImage = json['other_image'];
    _productStatus = json['product_status'];
    _variantName = json['variant_name'];
    _productType = json['product_type'];
    _tax = json['tax'];
    _unit = json['unit'];
    _qty = json['qty'];
  }
  String? _productId;
  String? _catId;
  String? _subcatId;
  String? _childCategory;
  String? _productName;
  String? _productDescription;
  String? _productPrice;
  String? _productImage;
  String? _proRatings;
  String? _roleId;
  String? _sellingPrice;
  String? _productCreateDate;
  String? _vendorId;
  String? _otherImage;
  String? _productStatus;
  String? _variantName;
  String? _productType;
  String? _tax;
  String? _unit;
  String? _qty;
OrderItems copyWith({  String? productId,
  String? catId,
  String? subcatId,
  String? childCategory,
  String? productName,
  String? productDescription,
  String? productPrice,
  String? productImage,
  String? proRatings,
  String? roleId,
  String? sellingPrice,
  String? productCreateDate,
  String? vendorId,
  String? otherImage,
  String? productStatus,
  String? variantName,
  String? productType,
  String? tax,
  String? unit,
  String? qty,
}) => OrderItems(  productId: productId ?? _productId,
  catId: catId ?? _catId,
  subcatId: subcatId ?? _subcatId,
  childCategory: childCategory ?? _childCategory,
  productName: productName ?? _productName,
  productDescription: productDescription ?? _productDescription,
  productPrice: productPrice ?? _productPrice,
  productImage: productImage ?? _productImage,
  proRatings: proRatings ?? _proRatings,
  roleId: roleId ?? _roleId,
  sellingPrice: sellingPrice ?? _sellingPrice,
  productCreateDate: productCreateDate ?? _productCreateDate,
  vendorId: vendorId ?? _vendorId,
  otherImage: otherImage ?? _otherImage,
  productStatus: productStatus ?? _productStatus,
  variantName: variantName ?? _variantName,
  productType: productType ?? _productType,
  tax: tax ?? _tax,
  unit: unit ?? _unit,
  qty: qty ?? _qty,
);
  String? get productId => _productId;
  String? get catId => _catId;
  String? get subcatId => _subcatId;
  String? get childCategory => _childCategory;
  String? get productName => _productName;
  String? get productDescription => _productDescription;
  String? get productPrice => _productPrice;
  String? get productImage => _productImage;
  String? get proRatings => _proRatings;
  String? get roleId => _roleId;
  String? get sellingPrice => _sellingPrice;
  String? get productCreateDate => _productCreateDate;
  String? get vendorId => _vendorId;
  String? get otherImage => _otherImage;
  String? get productStatus => _productStatus;
  String? get variantName => _variantName;
  String? get productType => _productType;
  String? get tax => _tax;
  String? get unit => _unit;
  String? get qty => _qty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = _productId;
    map['cat_id'] = _catId;
    map['subcat_id'] = _subcatId;
    map['child_category'] = _childCategory;
    map['product_name'] = _productName;
    map['product_description'] = _productDescription;
    map['product_price'] = _productPrice;
    map['product_image'] = _productImage;
    map['pro_ratings'] = _proRatings;
    map['role_id'] = _roleId;
    map['selling_price'] = _sellingPrice;
    map['product_create_date'] = _productCreateDate;
    map['vendor_id'] = _vendorId;
    map['other_image'] = _otherImage;
    map['product_status'] = _productStatus;
    map['variant_name'] = _variantName;
    map['product_type'] = _productType;
    map['tax'] = _tax;
    map['unit'] = _unit;
    map['qty'] = _qty;
    return map;
  }

}

/// name : "testing"
/// mobile : "7852365890"
/// email : "testing@gmail.com"

class DriverData {
  DriverData({
      dynamic name,
      dynamic mobile,
      dynamic email,}){
    _name = name;
    _mobile = mobile;
    _email = email;
}

  DriverData.fromJson(dynamic json) {
    _name = json['name']??"";
    _mobile = json['mobile']??"";
    _email = json['email']??"";
  }
  dynamic _name;
  dynamic _mobile;
  dynamic _email;
DriverData copyWith({  String? name,
  String? mobile,
  String? email,
}) => DriverData(  name: name ?? _name,
  mobile: mobile ?? _mobile,
  email: email ?? _email,
);
  dynamic get name => _name;
  dynamic get mobile => _mobile;
  dynamic get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['email'] = _email;
    return map;
  }

}