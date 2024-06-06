/// status : "1"
/// msg : "Pages Data"
/// setting : {"id":"3","title":"Terms and Conditions","slug":"terms_conditions","html":"<p>1. Don&#39;t give any other amount to the driver.&nbsp;</p>\r\n\r\n<p>2. If the driver consumes any intoxicant while driving then immediately call the helpline number.</p>\r\n\r\n<p>3. If unnecessary motorist bothers you on the way due to no fault of yours, Then you should inform the company about it and do not argue in any way.</p>\r\n\r\n<p>4.there is no provision of refund by the company for the tickets booked by you online in your absence.</p>\r\n\r\n<p>5. Please, it will be necessary for you to reach the pickup location on time, then you yourself will be responsible for it.</p>\r\n\r\n<p>6. Your essential material like ( Purse, Mobile, Gold,Silver etc.) will have to be safe kept by yourself, otherwise the company will not be responsible for missing.</p>\r\n\r\n<p>T&amp;C Vendore&nbsp;</p>\r\n","created_at":"2022-11-08 15:51:09","updated_at":"2024-02-08 16:02:20","heading":"","img_1":"","img_2":"","img_3":"","img_4":"","url":""}

class TermsAndCondition {
  TermsAndCondition({
      String? status, 
      String? msg, 
      Setting? setting,}){
    _status = status;
    _msg = msg;
    _setting = setting;
}

  TermsAndCondition.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    _setting = json['setting'] != null ? Setting.fromJson(json['setting']) : null;
  }
  String? _status;
  String? _msg;
  Setting? _setting;
TermsAndCondition copyWith({  String? status,
  String? msg,
  Setting? setting,
}) => TermsAndCondition(  status: status ?? _status,
  msg: msg ?? _msg,
  setting: setting ?? _setting,
);
  String? get status => _status;
  String? get msg => _msg;
  Setting? get setting => _setting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_setting != null) {
      map['setting'] = _setting?.toJson();
    }
    return map;
  }

}

/// id : "3"
/// title : "Terms and Conditions"
/// slug : "terms_conditions"
/// html : "<p>1. Don&#39;t give any other amount to the driver.&nbsp;</p>\r\n\r\n<p>2. If the driver consumes any intoxicant while driving then immediately call the helpline number.</p>\r\n\r\n<p>3. If unnecessary motorist bothers you on the way due to no fault of yours, Then you should inform the company about it and do not argue in any way.</p>\r\n\r\n<p>4.there is no provision of refund by the company for the tickets booked by you online in your absence.</p>\r\n\r\n<p>5. Please, it will be necessary for you to reach the pickup location on time, then you yourself will be responsible for it.</p>\r\n\r\n<p>6. Your essential material like ( Purse, Mobile, Gold,Silver etc.) will have to be safe kept by yourself, otherwise the company will not be responsible for missing.</p>\r\n\r\n<p>T&amp;C Vendore&nbsp;</p>\r\n"
/// created_at : "2022-11-08 15:51:09"
/// updated_at : "2024-02-08 16:02:20"
/// heading : ""
/// img_1 : ""
/// img_2 : ""
/// img_3 : ""
/// img_4 : ""
/// url : ""

class Setting {
  Setting({
      String? id, 
      String? title, 
      String? slug, 
      String? html, 
      String? createdAt, 
      String? updatedAt, 
      String? heading, 
      String? img1, 
      String? img2, 
      String? img3, 
      String? img4, 
      String? url,}){
    _id = id;
    _title = title;
    _slug = slug;
    _html = html;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _heading = heading;
    _img1 = img1;
    _img2 = img2;
    _img3 = img3;
    _img4 = img4;
    _url = url;
}

  Setting.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _slug = json['slug'];
    _html = json['html'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _heading = json['heading'];
    _img1 = json['img_1'];
    _img2 = json['img_2'];
    _img3 = json['img_3'];
    _img4 = json['img_4'];
    _url = json['url'];
  }
  String? _id;
  String? _title;
  String? _slug;
  String? _html;
  String? _createdAt;
  String? _updatedAt;
  String? _heading;
  String? _img1;
  String? _img2;
  String? _img3;
  String? _img4;
  String? _url;
Setting copyWith({  String? id,
  String? title,
  String? slug,
  String? html,
  String? createdAt,
  String? updatedAt,
  String? heading,
  String? img1,
  String? img2,
  String? img3,
  String? img4,
  String? url,
}) => Setting(  id: id ?? _id,
  title: title ?? _title,
  slug: slug ?? _slug,
  html: html ?? _html,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  heading: heading ?? _heading,
  img1: img1 ?? _img1,
  img2: img2 ?? _img2,
  img3: img3 ?? _img3,
  img4: img4 ?? _img4,
  url: url ?? _url,
);
  String? get id => _id;
  String? get title => _title;
  String? get slug => _slug;
  String? get html => _html;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get heading => _heading;
  String? get img1 => _img1;
  String? get img2 => _img2;
  String? get img3 => _img3;
  String? get img4 => _img4;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['slug'] = _slug;
    map['html'] = _html;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['heading'] = _heading;
    map['img_1'] = _img1;
    map['img_2'] = _img2;
    map['img_3'] = _img3;
    map['img_4'] = _img4;
    map['url'] = _url;
    return map;
  }

}