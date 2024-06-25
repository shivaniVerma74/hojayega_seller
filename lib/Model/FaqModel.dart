/// status : "1"
/// msg : "Service providers"
/// setting : [{"id":"4","title":"Happy day ","type":"user","description":"<p>Happy day today is a specila&nbsp;</p>\r\n"}]

class FaqModel {
  FaqModel({
      String? status, 
      String? msg, 
      List<Setting>? setting,}){
    _status = status;
    _msg = msg;
    _setting = setting;
}

  FaqModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['setting'] != null) {
      _setting = [];
      json['setting'].forEach((v) {
        _setting?.add(Setting.fromJson(v));
      });
    }
  }
  String? _status;
  String? _msg;
  List<Setting>? _setting;
FaqModel copyWith({  String? status,
  String? msg,
  List<Setting>? setting,
}) => FaqModel(  status: status ?? _status,
  msg: msg ?? _msg,
  setting: setting ?? _setting,
);
  String? get status => _status;
  String? get msg => _msg;
  List<Setting>? get setting => _setting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_setting != null) {
      map['setting'] = _setting?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "4"
/// title : "Happy day "
/// type : "user"
/// description : "<p>Happy day today is a specila&nbsp;</p>\r\n"

class Setting {
  Setting({
      String? id, 
      String? title, 
      String? type, 
      String? description,}){
    _id = id;
    _title = title;
    _type = type;
    _description = description;
}

  Setting.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _type = json['type'];
    _description = json['description'];
  }
  String? _id;
  String? _title;
  String? _type;
  String? _description;
Setting copyWith({  String? id,
  String? title,
  String? type,
  String? description,
}) => Setting(  id: id ?? _id,
  title: title ?? _title,
  type: type ?? _type,
  description: description ?? _description,
);
  String? get id => _id;
  String? get title => _title;
  String? get type => _type;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['type'] = _type;
    map['description'] = _description;
    return map;
  }

}