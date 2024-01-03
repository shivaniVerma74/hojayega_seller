/// response_code : "1"
/// msg : "Categories Found"
/// data : [{"id":"72","c_name":"SUB CATEGORY","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"uploads/category_images/1630575365woman-drying-hair-hairsalon_1157-27192_381_286.jpg","other_img":"","type":"vip","p_id":"84","service_type":"0"},{"id":"76","c_name":"tesafds","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"uploads/category_images/1630575365woman-drying-hair-hairsalon_1157-27192_381_286.jpg","other_img":"","type":"vip","p_id":null,"service_type":"1"},{"id":"83","c_name":"test sub","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"uploads/category_images/1630575365woman-drying-hair-hairsalon_1157-27192_381_286.jpg","other_img":"","type":"vip","p_id":"84","service_type":"0"},{"id":"91","c_name":"testasdf","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"/uploads/category_images/658d25f7e2c95.png","other_img":"","type":"vip","p_id":"72","service_type":"26"},{"id":"97","c_name":"Rice","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"uploads/category_images/658d6f5512613.png","other_img":"","type":"vip","p_id":"0","service_type":"7"},{"id":"98","c_name":"Aata","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"uploads/category_images/658d6fbe69415.png","other_img":"","type":"vip","p_id":"0","service_type":"7"},{"id":"99","c_name":"Beauty Parlour","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"uploads/category_images/658d704ea7af8.png","other_img":"","type":"vip","p_id":"0","service_type":"4"}]

class CreateonlineImageModel {
  CreateonlineImageModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  CreateonlineImageModel.fromJson(dynamic json) {
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
CreateonlineImageModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => CreateonlineImageModel(  responseCode: responseCode ?? _responseCode,
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

/// id : "72"
/// c_name : "SUB CATEGORY"
/// c_name_a : ""
/// icon : ""
/// sub_title : null
/// description : null
/// img : "uploads/category_images/1630575365woman-drying-hair-hairsalon_1157-27192_381_286.jpg"
/// other_img : ""
/// type : "vip"
/// p_id : "84"
/// service_type : "0"

class Data {
  Data({
      String? id, 
      String? cName, 
      String? cNameA, 
      String? icon, 
      dynamic subTitle, 
      dynamic description, 
      String? img, 
      String? otherImg, 
      String? type, 
      String? pId, 
      String? serviceType,}){
    _id = id;
    _cName = cName;
    _cNameA = cNameA;
    _icon = icon;
    _subTitle = subTitle;
    _description = description;
    _img = img;
    _otherImg = otherImg;
    _type = type;
    _pId = pId;
    _serviceType = serviceType;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _cName = json['c_name'];
    _cNameA = json['c_name_a'];
    _icon = json['icon'];
    _subTitle = json['sub_title'];
    _description = json['description'];
    _img = json['img'];
    _otherImg = json['other_img'];
    _type = json['type'];
    _pId = json['p_id'];
    _serviceType = json['service_type'];
  }
  String? _id;
  String? _cName;
  String? _cNameA;
  String? _icon;
  dynamic _subTitle;
  dynamic _description;
  String? _img;
  String? _otherImg;
  String? _type;
  String? _pId;
  String? _serviceType;
Data copyWith({  String? id,
  String? cName,
  String? cNameA,
  String? icon,
  dynamic subTitle,
  dynamic description,
  String? img,
  String? otherImg,
  String? type,
  String? pId,
  String? serviceType,
}) => Data(  id: id ?? _id,
  cName: cName ?? _cName,
  cNameA: cNameA ?? _cNameA,
  icon: icon ?? _icon,
  subTitle: subTitle ?? _subTitle,
  description: description ?? _description,
  img: img ?? _img,
  otherImg: otherImg ?? _otherImg,
  type: type ?? _type,
  pId: pId ?? _pId,
  serviceType: serviceType ?? _serviceType,
);
  String? get id => _id;
  String? get cName => _cName;
  String? get cNameA => _cNameA;
  String? get icon => _icon;
  dynamic get subTitle => _subTitle;
  dynamic get description => _description;
  String? get img => _img;
  String? get otherImg => _otherImg;
  String? get type => _type;
  String? get pId => _pId;
  String? get serviceType => _serviceType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['c_name'] = _cName;
    map['c_name_a'] = _cNameA;
    map['icon'] = _icon;
    map['sub_title'] = _subTitle;
    map['description'] = _description;
    map['img'] = _img;
    map['other_img'] = _otherImg;
    map['type'] = _type;
    map['p_id'] = _pId;
    map['service_type'] = _serviceType;
    return map;
  }

}