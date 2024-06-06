/// error : false
/// message : "Banners Found"
/// data : [{"id":"1","banners_name":"","image":"/uploads/documents/1716615754scaled_Screenshot_2024-05-06-16-30-16-408_com_havenreal_estate.jpg","role_type":"","banner_type":"service","start_date":"2024-06-04","end_date":"2024-06-15","vendor_id":"68","total_day":"19","amount":"19","status":"1","created_date":"2024-05-25 11:12:34","cancel_time":"0"},{"id":"2","banners_name":"","image":"/uploads/documents/1716615863scaled_Screenshot_2024-05-06-16-26-45-415_com_havenreal_estate.jpg","role_type":"","banner_type":"service","start_date":"2024-05-24","end_date":"2024-06-28","vendor_id":"68","total_day":"28","amount":"28","status":"1","created_date":"2024-05-25 11:14:23","cancel_time":"0"}]

class BannerHistory {
  BannerHistory({
      bool? error, 
      String? message, 
      List<HistoryData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  BannerHistory.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(HistoryData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<HistoryData>? _data;
BannerHistory copyWith({  bool? error,
  String? message,
  List<HistoryData>? data,
}) => BannerHistory(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<HistoryData>? get data => _data;

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

/// id : "1"
/// banners_name : ""
/// image : "/uploads/documents/1716615754scaled_Screenshot_2024-05-06-16-30-16-408_com_havenreal_estate.jpg"
/// role_type : ""
/// banner_type : "service"
/// start_date : "2024-06-04"
/// end_date : "2024-06-15"
/// vendor_id : "68"
/// total_day : "19"
/// amount : "19"
/// status : "1"
/// created_date : "2024-05-25 11:12:34"
/// cancel_time : "0"

class HistoryData {
  HistoryData({
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

  HistoryData.fromJson(dynamic json) {
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
  HistoryData copyWith({  String? id,
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
}) => HistoryData(  id: id ?? _id,
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