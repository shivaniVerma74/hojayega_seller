/// status : 1
/// msg : "Setting Found"
/// setting : {"id":"1","n_server_key":"AAAA0I6gvao:APA91bENmsxDZy6OLKvZ-lC66o2lXgNBJugEwgRs8h7YG1D-7Y0IsB5dLrhE5Q8jsbFyILKsp0v4IPKZ6D2ybIqTxesVkiVfsXgXQ8F0bh3nCvFgb1rzzMblqUddvOP78bIfc-68JJ2X","s_secret_key":"sk_test_Vcv04sLCi00ljN3C8GqrpDmw00SJk0bP62","s_public_key":"pk_test_asd3w4refds4werfweasfdfwwrwdfs4343","r_secret_key":"fnwpQ69iqzV5Aq0GUiG5sC71","r_public_key":"rzp_test_dv9hJ9iSfC2Far","twitter_url":"https://twitter.com/","likend_in_url":"https://www.linkedin.com/","instaram_url":"https://www.instagram.com/","facebook_url":"https://www.facebook.com/","address":"Vijay Nagar Indore","email":"hello@invitationdesign.com","contact_no":"9876543210","per_km_charge":"","gst_charge":"","ride_gst_charge":"","parcel_gst_charge":"","radius":"10000","advanced_amount":"","youtube_url":"https://youtube.com/@serviceondemandd","app_store_url":"https://www.apple.com/in/app-store/","play_store_url":"https://play.google.com/store/games?hl=en&gl=US","handy_man_status":"0","event_status":"0","event":"","handy":"","parcel_delivery_status":"0","mehndi_gst_charge":"","two_wheeler":"","three_wheeler":"","four_wheeler":"","food_driver_gst":"50","map":"<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1839.6675563376182!2d75.89260900821614!3d22.75294161975618!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x396302af403406fb%3A0x5b50834b117f8bab!2sVijay%20Nagar%2C%20Indore%2C%20Madhya%20Pradesh%20452010!5e0!3m2!1sen!2sin!4v1678786988200!5m2!1sen!2sin\" width=\"100%\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>","handy_fixed_amount":"","footer_data":"© 2023 All Rights Reserved","registration_fee":"20","bag_amount":"10","jacket":"50","mobile_holder":"50","total_banner":"7","banner_per_day_charge":"1","15_ad_amount":"5","cart_limit":"500"}

class GetSettingModel {
  GetSettingModel({
      num? status, 
      String? msg,
    SettingData? setting,}){
    _status = status;
    _msg = msg;
    _setting = setting;
}

  GetSettingModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    _setting = json['setting'] != null ? SettingData.fromJson(json['setting']) : null;
  }
  num? _status;
  String? _msg;
  SettingData? _setting;
GetSettingModel copyWith({num? status,
  String? msg,
  SettingData? setting,
}) => GetSettingModel(status: status ?? _status,
  msg: msg ?? _msg,
  setting: setting ?? _setting,
);
  num? get status => _status;
  String? get msg => _msg;
  SettingData? get setting => _setting;

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

/// id : "1"
/// n_server_key : "AAAA0I6gvao:APA91bENmsxDZy6OLKvZ-lC66o2lXgNBJugEwgRs8h7YG1D-7Y0IsB5dLrhE5Q8jsbFyILKsp0v4IPKZ6D2ybIqTxesVkiVfsXgXQ8F0bh3nCvFgb1rzzMblqUddvOP78bIfc-68JJ2X"
/// s_secret_key : "sk_test_Vcv04sLCi00ljN3C8GqrpDmw00SJk0bP62"
/// s_public_key : "pk_test_asd3w4refds4werfweasfdfwwrwdfs4343"
/// r_secret_key : "fnwpQ69iqzV5Aq0GUiG5sC71"
/// r_public_key : "rzp_test_dv9hJ9iSfC2Far"
/// twitter_url : "https://twitter.com/"
/// likend_in_url : "https://www.linkedin.com/"
/// instaram_url : "https://www.instagram.com/"
/// facebook_url : "https://www.facebook.com/"
/// address : "Vijay Nagar Indore"
/// email : "hello@invitationdesign.com"
/// contact_no : "9876543210"
/// per_km_charge : ""
/// gst_charge : ""
/// ride_gst_charge : ""
/// parcel_gst_charge : ""
/// radius : "10000"
/// advanced_amount : ""
/// youtube_url : "https://youtube.com/@serviceondemandd"
/// app_store_url : "https://www.apple.com/in/app-store/"
/// play_store_url : "https://play.google.com/store/games?hl=en&gl=US"
/// handy_man_status : "0"
/// event_status : "0"
/// event : ""
/// handy : ""
/// parcel_delivery_status : "0"
/// mehndi_gst_charge : ""
/// two_wheeler : ""
/// three_wheeler : ""
/// four_wheeler : ""
/// food_driver_gst : "50"
/// map : "<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1839.6675563376182!2d75.89260900821614!3d22.75294161975618!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x396302af403406fb%3A0x5b50834b117f8bab!2sVijay%20Nagar%2C%20Indore%2C%20Madhya%20Pradesh%20452010!5e0!3m2!1sen!2sin!4v1678786988200!5m2!1sen!2sin\" width=\"100%\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>"
/// handy_fixed_amount : ""
/// footer_data : "© 2023 All Rights Reserved"
/// registration_fee : "20"
/// bag_amount : "10"
/// jacket : "50"
/// mobile_holder : "50"
/// total_banner : "7"
/// banner_per_day_charge : "1"
/// 15_ad_amount : "5"
/// cart_limit : "500"

class SettingData {
  SettingData({
      String? id, 
      String? nServerKey, 
      String? sSecretKey, 
      String? sPublicKey, 
      String? rSecretKey, 
      String? rPublicKey, 
      String? twitterUrl, 
      String? likendInUrl, 
      String? instaramUrl, 
      String? facebookUrl, 
      String? address, 
      String? email, 
      String? contactNo, 
      String? perKmCharge, 
      String? gstCharge, 
      String? rideGstCharge, 
      String? parcelGstCharge, 
      String? radius, 
      String? advancedAmount, 
      String? youtubeUrl, 
      String? appStoreUrl, 
      String? playStoreUrl, 
      String? handyManStatus, 
      String? eventStatus, 
      String? event, 
      String? handy, 
      String? parcelDeliveryStatus, 
      String? mehndiGstCharge, 
      String? twoWheeler, 
      String? threeWheeler, 
      String? fourWheeler, 
      String? foodDriverGst, 
      String? map, 
      String? handyFixedAmount, 
      String? footerData, 
      String? registrationFee, 
      String? bagAmount, 
      String? jacket, 
      String? mobileHolder, 
      String? totalBanner, 
      String? bannerPerDayCharge, 
      String? AdAmount, 
      String? cartLimit,}){
    _id = id;
    _nServerKey = nServerKey;
    _sSecretKey = sSecretKey;
    _sPublicKey = sPublicKey;
    _rSecretKey = rSecretKey;
    _rPublicKey = rPublicKey;
    _twitterUrl = twitterUrl;
    _likendInUrl = likendInUrl;
    _instaramUrl = instaramUrl;
    _facebookUrl = facebookUrl;
    _address = address;
    _email = email;
    _contactNo = contactNo;
    _perKmCharge = perKmCharge;
    _gstCharge = gstCharge;
    _rideGstCharge = rideGstCharge;
    _parcelGstCharge = parcelGstCharge;
    _radius = radius;
    _advancedAmount = advancedAmount;
    _youtubeUrl = youtubeUrl;
    _appStoreUrl = appStoreUrl;
    _playStoreUrl = playStoreUrl;
    _handyManStatus = handyManStatus;
    _eventStatus = eventStatus;
    _event = event;
    _handy = handy;
    _parcelDeliveryStatus = parcelDeliveryStatus;
    _mehndiGstCharge = mehndiGstCharge;
    _twoWheeler = twoWheeler;
    _threeWheeler = threeWheeler;
    _fourWheeler = fourWheeler;
    _foodDriverGst = foodDriverGst;
    _map = map;
    _handyFixedAmount = handyFixedAmount;
    _footerData = footerData;
    _registrationFee = registrationFee;
    _bagAmount = bagAmount;
    _jacket = jacket;
    _mobileHolder = mobileHolder;
    _totalBanner = totalBanner;
    _bannerPerDayCharge = bannerPerDayCharge;
    _AdAmount = AdAmount;
    _cartLimit = cartLimit;
}

  SettingData.fromJson(dynamic json) {
    _id = json['id'];
    _nServerKey = json['n_server_key'];
    _sSecretKey = json['s_secret_key'];
    _sPublicKey = json['s_public_key'];
    _rSecretKey = json['r_secret_key'];
    _rPublicKey = json['r_public_key'];
    _twitterUrl = json['twitter_url'];
    _likendInUrl = json['likend_in_url'];
    _instaramUrl = json['instaram_url'];
    _facebookUrl = json['facebook_url'];
    _address = json['address'];
    _email = json['email'];
    _contactNo = json['contact_no'];
    _perKmCharge = json['per_km_charge'];
    _gstCharge = json['gst_charge'];
    _rideGstCharge = json['ride_gst_charge'];
    _parcelGstCharge = json['parcel_gst_charge'];
    _radius = json['radius'];
    _advancedAmount = json['advanced_amount'];
    _youtubeUrl = json['youtube_url'];
    _appStoreUrl = json['app_store_url'];
    _playStoreUrl = json['play_store_url'];
    _handyManStatus = json['handy_man_status'];
    _eventStatus = json['event_status'];
    _event = json['event'];
    _handy = json['handy'];
    _parcelDeliveryStatus = json['parcel_delivery_status'];
    _mehndiGstCharge = json['mehndi_gst_charge'];
    _twoWheeler = json['two_wheeler'];
    _threeWheeler = json['three_wheeler'];
    _fourWheeler = json['four_wheeler'];
    _foodDriverGst = json['food_driver_gst'];
    _map = json['map'];
    _handyFixedAmount = json['handy_fixed_amount'];
    _footerData = json['footer_data'];
    _registrationFee = json['registration_fee'];
    _bagAmount = json['bag_amount'];
    _jacket = json['jacket'];
    _mobileHolder = json['mobile_holder'];
    _totalBanner = json['total_banner'];
    _bannerPerDayCharge = json['banner_per_day_charge'];
    _AdAmount = json['15_ad_amount'];
    _cartLimit = json['cart_limit'];
  }
  String? _id;
  String? _nServerKey;
  String? _sSecretKey;
  String? _sPublicKey;
  String? _rSecretKey;
  String? _rPublicKey;
  String? _twitterUrl;
  String? _likendInUrl;
  String? _instaramUrl;
  String? _facebookUrl;
  String? _address;
  String? _email;
  String? _contactNo;
  String? _perKmCharge;
  String? _gstCharge;
  String? _rideGstCharge;
  String? _parcelGstCharge;
  String? _radius;
  String? _advancedAmount;
  String? _youtubeUrl;
  String? _appStoreUrl;
  String? _playStoreUrl;
  String? _handyManStatus;
  String? _eventStatus;
  String? _event;
  String? _handy;
  String? _parcelDeliveryStatus;
  String? _mehndiGstCharge;
  String? _twoWheeler;
  String? _threeWheeler;
  String? _fourWheeler;
  String? _foodDriverGst;
  String? _map;
  String? _handyFixedAmount;
  String? _footerData;
  String? _registrationFee;
  String? _bagAmount;
  String? _jacket;
  String? _mobileHolder;
  String? _totalBanner;
  String? _bannerPerDayCharge;
  String? _AdAmount;
  String? _cartLimit;
  SettingData copyWith({  String? id,
  String? nServerKey,
  String? sSecretKey,
  String? sPublicKey,
  String? rSecretKey,
  String? rPublicKey,
  String? twitterUrl,
  String? likendInUrl,
  String? instaramUrl,
  String? facebookUrl,
  String? address,
  String? email,
  String? contactNo,
  String? perKmCharge,
  String? gstCharge,
  String? rideGstCharge,
  String? parcelGstCharge,
  String? radius,
  String? advancedAmount,
  String? youtubeUrl,
  String? appStoreUrl,
  String? playStoreUrl,
  String? handyManStatus,
  String? eventStatus,
  String? event,
  String? handy,
  String? parcelDeliveryStatus,
  String? mehndiGstCharge,
  String? twoWheeler,
  String? threeWheeler,
  String? fourWheeler,
  String? foodDriverGst,
  String? map,
  String? handyFixedAmount,
  String? footerData,
  String? registrationFee,
  String? bagAmount,
  String? jacket,
  String? mobileHolder,
  String? totalBanner,
  String? bannerPerDayCharge,
  String? AdAmount,
  String? cartLimit,
}) => SettingData(  id: id ?? _id,
  nServerKey: nServerKey ?? _nServerKey,
  sSecretKey: sSecretKey ?? _sSecretKey,
  sPublicKey: sPublicKey ?? _sPublicKey,
  rSecretKey: rSecretKey ?? _rSecretKey,
  rPublicKey: rPublicKey ?? _rPublicKey,
  twitterUrl: twitterUrl ?? _twitterUrl,
  likendInUrl: likendInUrl ?? _likendInUrl,
  instaramUrl: instaramUrl ?? _instaramUrl,
  facebookUrl: facebookUrl ?? _facebookUrl,
  address: address ?? _address,
  email: email ?? _email,
  contactNo: contactNo ?? _contactNo,
  perKmCharge: perKmCharge ?? _perKmCharge,
  gstCharge: gstCharge ?? _gstCharge,
  rideGstCharge: rideGstCharge ?? _rideGstCharge,
  parcelGstCharge: parcelGstCharge ?? _parcelGstCharge,
  radius: radius ?? _radius,
  advancedAmount: advancedAmount ?? _advancedAmount,
  youtubeUrl: youtubeUrl ?? _youtubeUrl,
  appStoreUrl: appStoreUrl ?? _appStoreUrl,
  playStoreUrl: playStoreUrl ?? _playStoreUrl,
  handyManStatus: handyManStatus ?? _handyManStatus,
  eventStatus: eventStatus ?? _eventStatus,
  event: event ?? _event,
  handy: handy ?? _handy,
  parcelDeliveryStatus: parcelDeliveryStatus ?? _parcelDeliveryStatus,
  mehndiGstCharge: mehndiGstCharge ?? _mehndiGstCharge,
  twoWheeler: twoWheeler ?? _twoWheeler,
  threeWheeler: threeWheeler ?? _threeWheeler,
  fourWheeler: fourWheeler ?? _fourWheeler,
  foodDriverGst: foodDriverGst ?? _foodDriverGst,
  map: map ?? _map,
  handyFixedAmount: handyFixedAmount ?? _handyFixedAmount,
  footerData: footerData ?? _footerData,
  registrationFee: registrationFee ?? _registrationFee,
  bagAmount: bagAmount ?? _bagAmount,
  jacket: jacket ?? _jacket,
  mobileHolder: mobileHolder ?? _mobileHolder,
  totalBanner: totalBanner ?? _totalBanner,
  bannerPerDayCharge: bannerPerDayCharge ?? _bannerPerDayCharge,
  AdAmount: AdAmount ?? _AdAmount,
  cartLimit: cartLimit ?? _cartLimit,
);
  String? get id => _id;
  String? get nServerKey => _nServerKey;
  String? get sSecretKey => _sSecretKey;
  String? get sPublicKey => _sPublicKey;
  String? get rSecretKey => _rSecretKey;
  String? get rPublicKey => _rPublicKey;
  String? get twitterUrl => _twitterUrl;
  String? get likendInUrl => _likendInUrl;
  String? get instaramUrl => _instaramUrl;
  String? get facebookUrl => _facebookUrl;
  String? get address => _address;
  String? get email => _email;
  String? get contactNo => _contactNo;
  String? get perKmCharge => _perKmCharge;
  String? get gstCharge => _gstCharge;
  String? get rideGstCharge => _rideGstCharge;
  String? get parcelGstCharge => _parcelGstCharge;
  String? get radius => _radius;
  String? get advancedAmount => _advancedAmount;
  String? get youtubeUrl => _youtubeUrl;
  String? get appStoreUrl => _appStoreUrl;
  String? get playStoreUrl => _playStoreUrl;
  String? get handyManStatus => _handyManStatus;
  String? get eventStatus => _eventStatus;
  String? get event => _event;
  String? get handy => _handy;
  String? get parcelDeliveryStatus => _parcelDeliveryStatus;
  String? get mehndiGstCharge => _mehndiGstCharge;
  String? get twoWheeler => _twoWheeler;
  String? get threeWheeler => _threeWheeler;
  String? get fourWheeler => _fourWheeler;
  String? get foodDriverGst => _foodDriverGst;
  String? get map => _map;
  String? get handyFixedAmount => _handyFixedAmount;
  String? get footerData => _footerData;
  String? get registrationFee => _registrationFee;
  String? get bagAmount => _bagAmount;
  String? get jacket => _jacket;
  String? get mobileHolder => _mobileHolder;
  String? get totalBanner => _totalBanner;
  String? get bannerPerDayCharge => _bannerPerDayCharge;
  String? get AdAmount => _AdAmount;
  String? get cartLimit => _cartLimit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['n_server_key'] = _nServerKey;
    map['s_secret_key'] = _sSecretKey;
    map['s_public_key'] = _sPublicKey;
    map['r_secret_key'] = _rSecretKey;
    map['r_public_key'] = _rPublicKey;
    map['twitter_url'] = _twitterUrl;
    map['likend_in_url'] = _likendInUrl;
    map['instaram_url'] = _instaramUrl;
    map['facebook_url'] = _facebookUrl;
    map['address'] = _address;
    map['email'] = _email;
    map['contact_no'] = _contactNo;
    map['per_km_charge'] = _perKmCharge;
    map['gst_charge'] = _gstCharge;
    map['ride_gst_charge'] = _rideGstCharge;
    map['parcel_gst_charge'] = _parcelGstCharge;
    map['radius'] = _radius;
    map['advanced_amount'] = _advancedAmount;
    map['youtube_url'] = _youtubeUrl;
    map['app_store_url'] = _appStoreUrl;
    map['play_store_url'] = _playStoreUrl;
    map['handy_man_status'] = _handyManStatus;
    map['event_status'] = _eventStatus;
    map['event'] = _event;
    map['handy'] = _handy;
    map['parcel_delivery_status'] = _parcelDeliveryStatus;
    map['mehndi_gst_charge'] = _mehndiGstCharge;
    map['two_wheeler'] = _twoWheeler;
    map['three_wheeler'] = _threeWheeler;
    map['four_wheeler'] = _fourWheeler;
    map['food_driver_gst'] = _foodDriverGst;
    map['map'] = _map;
    map['handy_fixed_amount'] = _handyFixedAmount;
    map['footer_data'] = _footerData;
    map['registration_fee'] = _registrationFee;
    map['bag_amount'] = _bagAmount;
    map['jacket'] = _jacket;
    map['mobile_holder'] = _mobileHolder;
    map['total_banner'] = _totalBanner;
    map['banner_per_day_charge'] = _bannerPerDayCharge;
    map['15_ad_amount'] = _AdAmount;
    map['cart_limit'] = _cartLimit;
    return map;
  }

}