/// status : "1"
/// message : "Data Found"
/// total_earning : "0.0000000000"
/// onine_earning : "0"
/// cod : "238.40"
/// products : [{"transaction_id":"Order Delivered Successfully 3","order_id":"3","amount":"119.20","created_at":"2024-06-01 11:59:08","payment_mode":"COD","status":"credit","product_image":"/uploads/profile_pics/1717144337scaled_Screenshot_2024-05-06-16-26-45-415_com_havenreal_estate.jpg"},{"transaction_id":"Order Delivered Successfully 3","order_id":"3","amount":"119.20","created_at":"2024-06-01 11:58:24","payment_mode":"COD","status":"credit","product_image":"/uploads/profile_pics/1717144337scaled_Screenshot_2024-05-06-16-26-45-415_com_havenreal_estate.jpg"}]

class EarningsModel {
  EarningsModel({
      String? status, 
      String? message, 
      String? totalEarning, 
      String? onineEarning, 
      String? cod, 
      List<Products>? products,}){
    _status = status;
    _message = message;
    _totalEarning = totalEarning;
    _onineEarning = onineEarning;
    _cod = cod;
    _products = products;
}

  EarningsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _totalEarning = json['total_earning'];
    _onineEarning = json['onine_earning'];
    _cod = json['cod'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  String? _totalEarning;
  String? _onineEarning;
  String? _cod;
  List<Products>? _products;
EarningsModel copyWith({  String? status,
  String? message,
  String? totalEarning,
  String? onineEarning,
  String? cod,
  List<Products>? products,
}) => EarningsModel(  status: status ?? _status,
  message: message ?? _message,
  totalEarning: totalEarning ?? _totalEarning,
  onineEarning: onineEarning ?? _onineEarning,
  cod: cod ?? _cod,
  products: products ?? _products,
);
  String? get status => _status;
  String? get message => _message;
  String? get totalEarning => _totalEarning;
  String? get onineEarning => _onineEarning;
  String? get cod => _cod;
  List<Products>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['total_earning'] = _totalEarning;
    map['onine_earning'] = _onineEarning;
    map['cod'] = _cod;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// transaction_id : "Order Delivered Successfully 3"
/// order_id : "3"
/// amount : "119.20"
/// created_at : "2024-06-01 11:59:08"
/// payment_mode : "COD"
/// status : "credit"
/// product_image : "/uploads/profile_pics/1717144337scaled_Screenshot_2024-05-06-16-26-45-415_com_havenreal_estate.jpg"

class Products {
  Products({
      String? transactionId, 
      String? orderId, 
      String? amount, 
      String? createdAt, 
      String? paymentMode, 
      String? status, 
      String? productImage,}){
    _transactionId = transactionId;
    _orderId = orderId;
    _amount = amount;
    _createdAt = createdAt;
    _paymentMode = paymentMode;
    _status = status;
    _productImage = productImage;
}

  Products.fromJson(dynamic json) {
    _transactionId = json['transaction_id'];
    _orderId = json['order_id'];
    _amount = json['amount'];
    _createdAt = json['created_at'];
    _paymentMode = json['payment_mode'];
    _status = json['status'];
    _productImage = json['product_image'];
  }
  String? _transactionId;
  String? _orderId;
  String? _amount;
  String? _createdAt;
  String? _paymentMode;
  String? _status;
  String? _productImage;
Products copyWith({  String? transactionId,
  String? orderId,
  String? amount,
  String? createdAt,
  String? paymentMode,
  String? status,
  String? productImage,
}) => Products(  transactionId: transactionId ?? _transactionId,
  orderId: orderId ?? _orderId,
  amount: amount ?? _amount,
  createdAt: createdAt ?? _createdAt,
  paymentMode: paymentMode ?? _paymentMode,
  status: status ?? _status,
  productImage: productImage ?? _productImage,
);
  String? get transactionId => _transactionId;
  String? get orderId => _orderId;
  String? get amount => _amount;
  String? get createdAt => _createdAt;
  String? get paymentMode => _paymentMode;
  String? get status => _status;
  String? get productImage => _productImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['transaction_id'] = _transactionId;
    map['order_id'] = _orderId;
    map['amount'] = _amount;
    map['created_at'] = _createdAt;
    map['payment_mode'] = _paymentMode;
    map['status'] = _status;
    map['product_image'] = _productImage;
    return map;
  }

}