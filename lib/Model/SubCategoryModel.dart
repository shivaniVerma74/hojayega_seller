/// response_code : "1"
/// msg : "Categories Found"
/// data : [{"id":"2","c_name":"Rice","image":"uploads/category_images/658d6c37a79ab.jpg","cat_id":"1","service_type":"2"}]

class SubCategoryModel {
  SubCategoryModel({
      String? responseCode, 
      String? msg, 
      List<SubCategoryData>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  SubCategoryModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SubCategoryData.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<SubCategoryData>? _data;
SubCategoryModel copyWith({  String? responseCode,
  String? msg,
  List<SubCategoryData>? data,
}) => SubCategoryModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<SubCategoryData>? get data => _data;

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

/// id : "2"
/// c_name : "Rice"
/// image : "uploads/category_images/658d6c37a79ab.jpg"
/// cat_id : "1"
/// service_type : "2"

class SubCategoryData {
  SubCategoryData({
      String? id, 
      String? cName, 
      String? image, 
      String? catId, 
      String? serviceType,}){
    _id = id;
    _cName = cName;
    _image = image;
    _catId = catId;
    _serviceType = serviceType;
}

  SubCategoryData.fromJson(dynamic json) {
    _id = json['id'];
    _cName = json['c_name'];
    _image = json['image'];
    _catId = json['cat_id'];
    _serviceType = json['service_type'];
  }
  String? _id;
  String? _cName;
  String? _image;
  String? _catId;
  String? _serviceType;
  SubCategoryData copyWith({  String? id,
  String? cName,
  String? image,
  String? catId,
  String? serviceType,
}) => SubCategoryData(  id: id ?? _id,
  cName: cName ?? _cName,
  image: image ?? _image,
  catId: catId ?? _catId,
  serviceType: serviceType ?? _serviceType,
);
  String? get id => _id;
  String? get cName => _cName;
  String? get image => _image;
  String? get catId => _catId;
  String? get serviceType => _serviceType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['c_name'] = _cName;
    map['image'] = _image;
    map['cat_id'] = _catId;
    map['service_type'] = _serviceType;
    return map;
  }

}