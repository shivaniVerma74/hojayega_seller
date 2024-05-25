/// error : false
/// message : "Banners Found"
/// data : [{"id":"32","image":"/uploads/documents/1716613054scaled_Screenshot_2024-05-22-10-28-32-086_com_ramnam_user.jpg","start_date":null,"end_date":null,"total_day":"0","total_amount":"0","type":"service","vendor_id":"68","time":"10:27:34","date":"2024-05-25 10:27:34","status":"0","duration":"15"}]

class Sec15ModelList {
  Sec15ModelList({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  Sec15ModelList.fromJson(dynamic json) {
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
Sec15ModelList copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => Sec15ModelList(  error: error ?? _error,
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

/// id : "32"
/// image : "/uploads/documents/1716613054scaled_Screenshot_2024-05-22-10-28-32-086_com_ramnam_user.jpg"
/// start_date : null
/// end_date : null
/// total_day : "0"
/// total_amount : "0"
/// type : "service"
/// vendor_id : "68"
/// time : "10:27:34"
/// date : "2024-05-25 10:27:34"
/// status : "0"
/// duration : "15"

class Data {
  Data({
      String? id, 
      String? image, 
      dynamic startDate, 
      dynamic endDate, 
      String? totalDay, 
      String? totalAmount, 
      String? type, 
      String? vendorId, 
      String? time, 
      String? date, 
      String? status, 
      String? duration,}){
    _id = id;
    _image = image;
    _startDate = startDate;
    _endDate = endDate;
    _totalDay = totalDay;
    _totalAmount = totalAmount;
    _type = type;
    _vendorId = vendorId;
    _time = time;
    _date = date;
    _status = status;
    _duration = duration;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _totalDay = json['total_day'];
    _totalAmount = json['total_amount'];
    _type = json['type'];
    _vendorId = json['vendor_id'];
    _time = json['time'];
    _date = json['date'];
    _status = json['status'];
    _duration = json['duration'];
  }
  String? _id;
  String? _image;
  dynamic _startDate;
  dynamic _endDate;
  String? _totalDay;
  String? _totalAmount;
  String? _type;
  String? _vendorId;
  String? _time;
  String? _date;
  String? _status;
  String? _duration;
Data copyWith({  String? id,
  String? image,
  dynamic startDate,
  dynamic endDate,
  String? totalDay,
  String? totalAmount,
  String? type,
  String? vendorId,
  String? time,
  String? date,
  String? status,
  String? duration,
}) => Data(  id: id ?? _id,
  image: image ?? _image,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  totalDay: totalDay ?? _totalDay,
  totalAmount: totalAmount ?? _totalAmount,
  type: type ?? _type,
  vendorId: vendorId ?? _vendorId,
  time: time ?? _time,
  date: date ?? _date,
  status: status ?? _status,
  duration: duration ?? _duration,
);
  String? get id => _id;
  String? get image => _image;
  dynamic get startDate => _startDate;
  dynamic get endDate => _endDate;
  String? get totalDay => _totalDay;
  String? get totalAmount => _totalAmount;
  String? get type => _type;
  String? get vendorId => _vendorId;
  String? get time => _time;
  String? get date => _date;
  String? get status => _status;
  String? get duration => _duration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['total_day'] = _totalDay;
    map['total_amount'] = _totalAmount;
    map['type'] = _type;
    map['vendor_id'] = _vendorId;
    map['time'] = _time;
    map['date'] = _date;
    map['status'] = _status;
    map['duration'] = _duration;
    return map;
  }

}