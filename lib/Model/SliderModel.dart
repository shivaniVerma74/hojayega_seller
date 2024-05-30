/// error : false
/// message : "Banners Found"
/// data : [{"id":"1","image":"https://developmentalphawizz.com/hojayega/uploads/documents/65b124e6289d4.png","create_at":"2024-02-12 19:56:00","banner_type":"Shop"},{"id":"2","image":"https://developmentalphawizz.com/hojayega/uploads/documents/65b12590313aa.png","create_at":"2024-02-12 20:05:17","banner_type":"Shop"},{"id":"3","image":"https://developmentalphawizz.com/hojayega/uploads/documents/65c47c6aca28b.jpeg","create_at":"2024-02-12 19:56:04","banner_type":"Service"}]

class SliderModel {
  SliderModel({
      bool? error, 
      String? message, 
      List<BannerListModel>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  SliderModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BannerListModel.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<BannerListModel>? _data;
SliderModel copyWith({  bool? error,
  String? message,
  List<BannerListModel>? data,
}) => SliderModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<BannerListModel>? get data => _data;

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
/// image : "https://developmentalphawizz.com/hojayega/uploads/documents/65b124e6289d4.png"
/// create_at : "2024-02-12 19:56:00"
/// banner_type : "Shop"

class BannerListModel {
  BannerListModel({
      String? id, 
      String? image, 
      String? createAt, 
      String? bannerType,}){
    _id = id;
    _image = image;
    _createAt = createAt;
    _bannerType = bannerType;
}

  BannerListModel.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _createAt = json['create_at'];
    _bannerType = json['banner_type'];
  }
  String? _id;
  String? _image;
  String? _createAt;
  String? _bannerType;
  BannerListModel copyWith({  String? id,
  String? image,
  String? createAt,
  String? bannerType,
}) => BannerListModel(  id: id ?? _id,
  image: image ?? _image,
  createAt: createAt ?? _createAt,
  bannerType: bannerType ?? _bannerType,
);
  String? get id => _id;
  String? get image => _image;
  String? get createAt => _createAt;
  String? get bannerType => _bannerType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['create_at'] = _createAt;
    map['banner_type'] = _bannerType;
    return map;
  }

}