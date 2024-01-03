/// response_code : "1"
/// msg : "Wallet transactions"
/// data : [{"id":"387","user_id":"147","user_type":"1","amount":"100.00","transaction_id":"7897asdf89","created_at":"2024-01-02 11:54:32","updated_at":"2024-01-02 11:54:32","refferal_status":"0","level":"","refferal_id":"","status":""},{"id":"388","user_id":"147","user_type":"1","amount":"100.00","transaction_id":"7897asdf89","created_at":"2024-01-02 11:55:33","updated_at":"2024-01-02 11:55:33","refferal_status":"0","level":"","refferal_id":"","status":""},{"id":"389","user_id":"147","user_type":"1","amount":"100.00","transaction_id":"7897asdf89","created_at":"2024-01-02 11:58:42","updated_at":"2024-01-02 11:58:42","refferal_status":"0","level":"","refferal_id":"","status":""},{"id":"390","user_id":"147","user_type":"1","amount":"100.00","transaction_id":"7897asdf89","created_at":"2024-01-02 11:58:57","updated_at":"2024-01-02 11:58:57","refferal_status":"0","level":"","refferal_id":"","status":""},{"id":"391","user_id":"147","user_type":"1","amount":"100.00","transaction_id":"7897asdf89","created_at":"2024-01-02 11:59:09","updated_at":"2024-01-02 11:59:09","refferal_status":"0","level":"","refferal_id":"","status":""},{"id":"392","user_id":"147","user_type":"1","amount":"100.00","transaction_id":"7897asdf89","created_at":"2024-01-02 11:59:18","updated_at":"2024-01-02 11:59:18","refferal_status":"0","level":"","refferal_id":"","status":""},{"id":"393","user_id":"147","user_type":"1","amount":"100.00","transaction_id":"7897asdf89","created_at":"2024-01-02 12:00:10","updated_at":"2024-01-02 12:00:10","refferal_status":"0","level":"","refferal_id":"","status":""},{"id":"394","user_id":"147","user_type":"1","amount":"100.00","transaction_id":"7897asdf89","created_at":"2024-01-02 12:13:43","updated_at":"2024-01-02 12:13:43","refferal_status":"0","level":"","refferal_id":"","status":""},{"id":"395","user_id":"147","user_type":"1","amount":"100.00","transaction_id":"7897asdf89","created_at":"2024-01-02 12:14:04","updated_at":"2024-01-02 12:14:04","refferal_status":"0","level":"","refferal_id":"","status":""},{"id":"396","user_id":"147","user_type":"1","amount":"100.00","transaction_id":"7897asdf89","created_at":"2024-01-02 12:14:11","updated_at":"2024-01-02 12:14:11","refferal_status":"0","level":"","refferal_id":"","status":""},{"id":"397","user_id":"147","user_type":"2","amount":"100.00","transaction_id":"7897asdf89","created_at":"2024-01-02 12:14:25","updated_at":"2024-01-02 12:14:25","refferal_status":"0","level":"","refferal_id":"","status":""},{"id":"398","user_id":"147","user_type":"2","amount":"100.00","transaction_id":"7897asdf89","created_at":"2024-01-02 12:14:50","updated_at":"2024-01-02 12:14:50","refferal_status":"0","level":"","refferal_id":"","status":""},{"id":"399","user_id":"147","user_type":"2","amount":"100.00","transaction_id":"7897asdf89","created_at":"2024-01-02 12:16:20","updated_at":"2024-01-02 12:16:20","refferal_status":"0","level":"","refferal_id":"","status":"Debited"},{"id":"400","user_id":"147","user_type":"2","amount":"100.00","transaction_id":"7897asdf89","created_at":"2024-01-02 12:16:30","updated_at":"2024-01-02 12:16:30","refferal_status":"0","level":"","refferal_id":"","status":"Debited"}]

class TransactionModel {
  TransactionModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  TransactionModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<Data>? _data;
TransactionModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => TransactionModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "387"
/// user_id : "147"
/// user_type : "1"
/// amount : "100.00"
/// transaction_id : "7897asdf89"
/// created_at : "2024-01-02 11:54:32"
/// updated_at : "2024-01-02 11:54:32"
/// refferal_status : "0"
/// level : ""
/// refferal_id : ""
/// status : ""

class Data {
  Data({
      String? id, 
      String? userId, 
      String? userType, 
      String? amount, 
      String? transactionId, 
      String? createdAt, 
      String? updatedAt, 
      String? refferalStatus, 
      String? level, 
      String? refferalId, 
      String? status,}){
    _id = id;
    _userId = userId;
    _userType = userType;
    _amount = amount;
    _transactionId = transactionId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _refferalStatus = refferalStatus;
    _level = level;
    _refferalId = refferalId;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _userType = json['user_type'];
    _amount = json['amount'];
    _transactionId = json['transaction_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _refferalStatus = json['refferal_status'];
    _level = json['level'];
    _refferalId = json['refferal_id'];
    _status = json['status'];
  }
  String? _id;
  String? _userId;
  String? _userType;
  String? _amount;
  String? _transactionId;
  String? _createdAt;
  String? _updatedAt;
  String? _refferalStatus;
  String? _level;
  String? _refferalId;
  String? _status;
Data copyWith({  String? id,
  String? userId,
  String? userType,
  String? amount,
  String? transactionId,
  String? createdAt,
  String? updatedAt,
  String? refferalStatus,
  String? level,
  String? refferalId,
  String? status,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  userType: userType ?? _userType,
  amount: amount ?? _amount,
  transactionId: transactionId ?? _transactionId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  refferalStatus: refferalStatus ?? _refferalStatus,
  level: level ?? _level,
  refferalId: refferalId ?? _refferalId,
  status: status ?? _status,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get userType => _userType;
  String? get amount => _amount;
  String? get transactionId => _transactionId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get refferalStatus => _refferalStatus;
  String? get level => _level;
  String? get refferalId => _refferalId;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['user_type'] = _userType;
    map['amount'] = _amount;
    map['transaction_id'] = _transactionId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['refferal_status'] = _refferalStatus;
    map['level'] = _level;
    map['refferal_id'] = _refferalId;
    map['status'] = _status;
    return map;
  }

}