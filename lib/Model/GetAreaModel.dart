/// response_code : "1"
/// msg : "City List"
/// data : [{"id":"6","name":"abc","city_id":"73","state_id":"7"}]

class GetAreaModel {
  GetAreaModel({
      String? responseCode, 
      String? msg, 
      List<CountryData>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  GetAreaModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CountryData.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<CountryData>? _data;
GetAreaModel copyWith({  String? responseCode,
  String? msg,
  List<CountryData>? data,
}) => GetAreaModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<CountryData>? get data => _data;

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

/// id : "6"
/// name : "abc"
/// city_id : "73"
/// state_id : "7"

class CountryData {
  CountryData({
      String? id, 
      String? name, 
      String? cityId, 
      String? stateId,}){
    _id = id;
    _name = name;
    _cityId = cityId;
    _stateId = stateId;
}

  CountryData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _cityId = json['city_id'];
    _stateId = json['state_id'];
  }
  String? _id;
  String? _name;
  String? _cityId;
  String? _stateId;
  CountryData copyWith({  String? id,
  String? name,
  String? cityId,
  String? stateId,
}) => CountryData(  id: id ?? _id,
  name: name ?? _name,
  cityId: cityId ?? _cityId,
  stateId: stateId ?? _stateId,
);
  String? get id => _id;
  String? get name => _name;
  String? get cityId => _cityId;
  String? get stateId => _stateId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['city_id'] = _cityId;
    map['state_id'] = _stateId;
    return map;
  }

}