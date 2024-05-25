/// error : false
/// message : "Banners Found"
/// data : [{"id":"78","banners_name":"","image":"/uploads/documents/1716557166scaled_Screenshot_2024-05-22-10-21-58-098_com_ramnam_user.jpg","role_type":"","banner_type":"service","start_date":"2024-05-28","end_date":"2024-07-17","vendor_id":"68","total_day":"50","amount":"50","status":"0","created_date":"2024-05-24 18:56:06","cancel_time":"0"}]

class PromotionAdsList {
  PromotionAdsList({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  PromotionAdsList.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
PromotionAdsList copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => PromotionAdsList(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "78"
/// banners_name : ""
/// image : "/uploads/documents/1716557166scaled_Screenshot_2024-05-22-10-21-58-098_com_ramnam_user.jpg"
/// role_type : ""
/// banner_type : "service"
/// start_date : "2024-05-28"
/// end_date : "2024-07-17"
/// vendor_id : "68"
/// total_day : "50"
/// amount : "50"
/// status : "0"
/// created_date : "2024-05-24 18:56:06"
/// cancel_time : "0"

class Data {
  Data({
      String? id, 
      String? bannersName, 
      String? image, 
      String? roleType, 
      String? bannerType, 
      String? startDate, 
      String? endDate, 
      String? vendorId, 
      String? totalDay, 
      String? amount, 
      String? status, 
      String? createdDate, 
      String? cancelTime,}){
    _id = id;
    _bannersName = bannersName;
    _image = image;
    _roleType = roleType;
    _bannerType = bannerType;
    _startDate = startDate;
    _endDate = endDate;
    _vendorId = vendorId;
    _totalDay = totalDay;
    _amount = amount;
    _status = status;
    _createdDate = createdDate;
    _cancelTime = cancelTime;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _bannersName = json['banners_name'];
    _image = json['image'];
    _roleType = json['role_type'];
    _bannerType = json['banner_type'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _vendorId = json['vendor_id'];
    _totalDay = json['total_day'];
    _amount = json['amount'];
    _status = json['status'];
    _createdDate = json['created_date'];
    _cancelTime = json['cancel_time'];
  }
  String? _id;
  String? _bannersName;
  String? _image;
  String? _roleType;
  String? _bannerType;
  String? _startDate;
  String? _endDate;
  String? _vendorId;
  String? _totalDay;
  String? _amount;
  String? _status;
  String? _createdDate;
  String? _cancelTime;
Data copyWith({  String? id,
  String? bannersName,
  String? image,
  String? roleType,
  String? bannerType,
  String? startDate,
  String? endDate,
  String? vendorId,
  String? totalDay,
  String? amount,
  String? status,
  String? createdDate,
  String? cancelTime,
}) => Data(  id: id ?? _id,
  bannersName: bannersName ?? _bannersName,
  image: image ?? _image,
  roleType: roleType ?? _roleType,
  bannerType: bannerType ?? _bannerType,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  vendorId: vendorId ?? _vendorId,
  totalDay: totalDay ?? _totalDay,
  amount: amount ?? _amount,
  status: status ?? _status,
  createdDate: createdDate ?? _createdDate,
  cancelTime: cancelTime ?? _cancelTime,
);
  String? get id => _id;
  String? get bannersName => _bannersName;
  String? get image => _image;
  String? get roleType => _roleType;
  String? get bannerType => _bannerType;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get vendorId => _vendorId;
  String? get totalDay => _totalDay;
  String? get amount => _amount;
  String? get status => _status;
  String? get createdDate => _createdDate;
  String? get cancelTime => _cancelTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['banners_name'] = _bannersName;
    map['image'] = _image;
    map['role_type'] = _roleType;
    map['banner_type'] = _bannerType;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['vendor_id'] = _vendorId;
    map['total_day'] = _totalDay;
    map['amount'] = _amount;
    map['status'] = _status;
    map['created_date'] = _createdDate;
    map['cancel_time'] = _cancelTime;
    return map;
  }

}