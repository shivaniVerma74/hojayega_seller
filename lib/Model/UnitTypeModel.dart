/// response_code : "1"
/// msg : "Unit List"
/// data : [{"id":"7","name":"KG","status":"1"}]

class UnitTypeModel {
  UnitTypeModel({
      String? responseCode, 
      String? msg, 
      List<Unitdata>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  UnitTypeModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Unitdata.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<Unitdata>? _data;
UnitTypeModel copyWith({  String? responseCode,
  String? msg,
  List<Unitdata>? data,
}) => UnitTypeModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<Unitdata>? get data => _data;

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
/// name : "KG"
/// status : "1"

class Unitdata {
  Unitdata({
      String? id, 
      String? name, 
      String? status,}){
    _id = id;
    _name = name;
    _status = status;
}

  Unitdata.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'];
  }
  String? _id;
  String? _name;
  String? _status;
Unitdata copyWith({  String? id,
  String? name,
  String? status,
}) => Unitdata(  id: id ?? _id,
  name: name ?? _name,
  status: status ?? _status,
);
  String? get id => _id;
  String? get name => _name;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['status'] = _status;
    return map;
  }

}