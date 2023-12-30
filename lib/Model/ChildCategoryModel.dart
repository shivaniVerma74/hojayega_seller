/// response_code : "1"
/// msg : "Categories Found"
/// data : [{"id":"2","c_name":"Biryani","image":"uploads/category_images/658d6e247c99c.jpg","cat_id":"1","sub_cat_id":"2","service_type":"2","status":"0"},{"id":"3","c_name":"asdfasdf","image":"uploads/category_images/658d797ed9100.png","cat_id":"1","sub_cat_id":"2","service_type":"2","status":"0"}]

class ChildCategoryModel {
  ChildCategoryModel({
      String? responseCode, 
      String? msg, 
      List<ChildCategoryData>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  ChildCategoryModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ChildCategoryData.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<ChildCategoryData>? _data;
ChildCategoryModel copyWith({  String? responseCode,
  String? msg,
  List<ChildCategoryData>? data,
}) => ChildCategoryModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<ChildCategoryData>? get data => _data;

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
/// c_name : "Biryani"
/// image : "uploads/category_images/658d6e247c99c.jpg"
/// cat_id : "1"
/// sub_cat_id : "2"
/// service_type : "2"
/// status : "0"

class ChildCategoryData {
  ChildCategoryData({
      String? id, 
      String? cName, 
      String? image, 
      String? catId, 
      String? subCatId, 
      String? serviceType, 
      String? status,}){
    _id = id;
    _cName = cName;
    _image = image;
    _catId = catId;
    _subCatId = subCatId;
    _serviceType = serviceType;
    _status = status;
}

  ChildCategoryData.fromJson(dynamic json) {
    _id = json['id'];
    _cName = json['c_name'];
    _image = json['image'];
    _catId = json['cat_id'];
    _subCatId = json['sub_cat_id'];
    _serviceType = json['service_type'];
    _status = json['status'];
  }
  String? _id;
  String? _cName;
  String? _image;
  String? _catId;
  String? _subCatId;
  String? _serviceType;
  String? _status;
  ChildCategoryData copyWith({  String? id,
  String? cName,
  String? image,
  String? catId,
  String? subCatId,
  String? serviceType,
  String? status,
}) => ChildCategoryData(  id: id ?? _id,
  cName: cName ?? _cName,
  image: image ?? _image,
  catId: catId ?? _catId,
  subCatId: subCatId ?? _subCatId,
  serviceType: serviceType ?? _serviceType,
  status: status ?? _status,
);
  String? get id => _id;
  String? get cName => _cName;
  String? get image => _image;
  String? get catId => _catId;
  String? get subCatId => _subCatId;
  String? get serviceType => _serviceType;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['c_name'] = _cName;
    map['image'] = _image;
    map['cat_id'] = _catId;
    map['sub_cat_id'] = _subCatId;
    map['service_type'] = _serviceType;
    map['status'] = _status;
    return map;
  }

}