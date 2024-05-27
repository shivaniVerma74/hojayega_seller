/// response_code : "1"
/// msg : "Vehicle Type List"
/// data : [{"id":"1","type":"cycle","image":"uploads/vehicle_image/cycle.png"},{"id":"2","type":"bike","image":"uploads/vehicle_image/bike.png"},{"id":"3","type":"scooter","image":"uploads/vehicle_image/scooter.png"},{"id":"4","type":"car","image":"uploads/vehicle_image/car.png"},{"id":"5","type":"tempo","image":"uploads/vehicle_image/tempo..png"},{"id":"6","type":"auto","image":"uploads/vehicle_image/auto.png"}]

class VehicleModel {
  VehicleModel({
    String? responseCode,
    String? msg,
    List<VehicleData>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
  }

  VehicleModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(VehicleData.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<VehicleData>? _data;
  VehicleModel copyWith({  String? responseCode,
    String? msg,
    List<VehicleData>? data,
  }) => VehicleModel(  responseCode: responseCode ?? _responseCode,
    msg: msg ?? _msg,
    data: data ?? _data,
  );
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<VehicleData>? get data => _data;

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

/// id : "1"
/// type : "cycle"
/// image : "uploads/vehicle_image/cycle.png"

class VehicleData {
  VehicleData({
    String? id,
    String? type,
    String? image,}){
    _id = id;
    _type = type;
    _image = image;
  }

  VehicleData.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _image = json['image'];
  }
  String? _id;
  String? _type;
  String? _image;
  VehicleData copyWith({  String? id,
    String? type,
    String? image,
  }) => VehicleData(  id: id ?? _id,
    type: type ?? _type,
    image: image ?? _image,
  );
  String? get id => _id;
  String? get type => _type;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['image'] = _image;
    return map;
  }
}