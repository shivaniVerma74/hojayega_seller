/// response_code : "1"
/// msg : "State List"
/// data : [{"id":"7","name":"Rajasthan","country_id":"0","created_at":"2023-04-23 12:37:33","updated_at":"2023-04-23 12:37:33"},{"id":"14","name":"Gujrat","country_id":"0","created_at":"2023-05-29 21:48:26","updated_at":"2023-05-29 21:48:26"},{"id":"15","name":"Madhya Pradesh","country_id":"5","created_at":"2023-11-18 18:20:55","updated_at":"2023-12-25 17:12:49"},{"id":"16","name":"maharashtra ","country_id":"0","created_at":"2023-11-29 12:19:30","updated_at":"2023-11-29 12:19:30"}]

class StateModel {
  StateModel({
      String? responseCode, 
      String? msg, 
      List<StataData>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  StateModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(StataData.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<StataData>? _data;
StateModel copyWith({  String? responseCode,
  String? msg,
  List<StataData>? data,
}) => StateModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<StataData>? get data => _data;

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

/// id : "7"
/// name : "Rajasthan"
/// country_id : "0"
/// created_at : "2023-04-23 12:37:33"
/// updated_at : "2023-04-23 12:37:33"

class StataData {
  StataData({
      String? id, 
      String? name, 
      String? countryId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _countryId = countryId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  StataData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _countryId = json['country_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _name;
  String? _countryId;
  String? _createdAt;
  String? _updatedAt;
  StataData copyWith({  String? id,
  String? name,
  String? countryId,
  String? createdAt,
  String? updatedAt,
}) => StataData(  id: id ?? _id,
  name: name ?? _name,
  countryId: countryId ?? _countryId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get name => _name;
  String? get countryId => _countryId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['country_id'] = _countryId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}