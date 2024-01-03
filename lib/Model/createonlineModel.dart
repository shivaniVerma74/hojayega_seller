/// error : false
/// message : "Banners Found"
/// data : [{"id":"1","name":"Book Store","image":"https://developmentalphawizz.com/hojayega//uploads/category_images/1703767021Rs__200_Off.jpg","type":"services","title":""},{"id":"4","name":"saloon","image":"https://developmentalphawizz.com/hojayega//uploads/category_images/1703767375saloon.png","type":"services","title":""},{"id":"5","name":"medical","image":"https://developmentalphawizz.com/hojayega//uploads/category_images/1703767435medicle.png","type":"services","title":""},{"id":"6","name":"Toys","image":"https://developmentalphawizz.com/hojayega//uploads/category_images/1703767636toys.png","type":"services","title":""}]

class CreateonlineModel {
  CreateonlineModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  CreateonlineModel.fromJson(dynamic json) {
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
CreateonlineModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => CreateonlineModel(  error: error ?? _error,
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

/// id : "1"
/// name : "Book Store"
/// image : "https://developmentalphawizz.com/hojayega//uploads/category_images/1703767021Rs__200_Off.jpg"
/// type : "services"
/// title : ""

class Data {
  Data({
      String? id, 
      String? name, 
      String? image, 
      String? type, 
      String? title,}){
    _id = id;
    _name = name;
    _image = image;
    _type = type;
    _title = title;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _type = json['type'];
    _title = json['title'];
  }
  String? _id;
  String? _name;
  String? _image;
  String? _type;
  String? _title;
Data copyWith({  String? id,
  String? name,
  String? image,
  String? type,
  String? title,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  image: image ?? _image,
  type: type ?? _type,
  title: title ?? _title,
);
  String? get id => _id;
  String? get name => _name;
  String? get image => _image;
  String? get type => _type;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['type'] = _type;
    map['title'] = _title;
    return map;
  }

}