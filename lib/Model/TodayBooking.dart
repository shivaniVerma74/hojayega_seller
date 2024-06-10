/// response_code : "1"
/// msg : "My Bookings"
/// data : [{"email":"sid@gmail.com","mobile":"9087878978","username":"sid","id":"250","date":"2024-06-10","slot":"From 16:00 To 19:00","user_id":"20","res_id":"79","size":null,"status":"Pending","a_status":"1","reason":null,"is_paid":"0","otp":"1158","amount":"0","txn_id":"","address":"","address_id":null,"payment_type":"","created_at":"2024-06-10 15:50:39","subtotal":"0.00","discount":"0.00","addons":"0.00","total":"3000.00","pickup_location":"","drop_location":"","assign_for":"0","booking_status":"Pending","paid_amount":"","km":"","latitude":"","longitude":"","drop_latitude":"","drop_longitude":"","booking_type":"","service_id":"0","no_of_person":"0","type_of_booking":"","gst_amount":"","items":"","gst_charge":"","delivery_charge":"","vendor_delivery_charge":"","hours":"","user_name":"","user_mobile":"","fixed_amount":"","p_date":"2024-06-10 15:50:39","services_id":"[{\"service_id\":\"76\",\"price\":\"2000\"}, {\"service_id\":\"77\",\"price\":\"1000\"}]","time":"","note":"testingdddd","admin_commission":"600","payment_status":"0","booking_id":"250"},{"email":"sid@gmail.com","mobile":"9087878978","username":"sid","id":"249","date":"2024-06-10","slot":"From 07:00 To 08:00","user_id":"20","res_id":"79","size":null,"status":"Pending","a_status":"1","reason":null,"is_paid":"0","otp":"2709","amount":"0","txn_id":"","address":"","address_id":null,"payment_type":"","created_at":"2024-06-10 17:14:31","subtotal":"0.00","discount":"0.00","addons":"0.00","total":"999.00","pickup_location":"","drop_location":"","assign_for":"0","booking_status":"Pending","paid_amount":"","km":"","latitude":"","longitude":"","drop_latitude":"","drop_longitude":"","booking_type":"","service_id":"0","no_of_person":"0","type_of_booking":"","gst_amount":"","items":"","gst_charge":"","delivery_charge":"","vendor_delivery_charge":"","hours":"","user_name":"","user_mobile":"","fixed_amount":"","p_date":"2024-06-10 15:41:53","services_id":"[{\"service_id\":\"80\",\"price\":\"999\"}]","time":"","note":"gjjgjg","admin_commission":"199.8","payment_status":"0","booking_id":"249"}]

class TodayBooking {
  TodayBooking({
      String? responseCode, 
      String? msg, 
      List<TodayBookingData>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  TodayBooking.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TodayBookingData.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<TodayBookingData>? _data;
TodayBooking copyWith({  String? responseCode,
  String? msg,
  List<TodayBookingData>? data,
}) => TodayBooking(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<TodayBookingData>? get data => _data;

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

/// email : "sid@gmail.com"
/// mobile : "9087878978"
/// username : "sid"
/// id : "250"
/// date : "2024-06-10"
/// slot : "From 16:00 To 19:00"
/// user_id : "20"
/// res_id : "79"
/// size : null
/// status : "Pending"
/// a_status : "1"
/// reason : null
/// is_paid : "0"
/// otp : "1158"
/// amount : "0"
/// txn_id : ""
/// address : ""
/// address_id : null
/// payment_type : ""
/// created_at : "2024-06-10 15:50:39"
/// subtotal : "0.00"
/// discount : "0.00"
/// addons : "0.00"
/// total : "3000.00"
/// pickup_location : ""
/// drop_location : ""
/// assign_for : "0"
/// booking_status : "Pending"
/// paid_amount : ""
/// km : ""
/// latitude : ""
/// longitude : ""
/// drop_latitude : ""
/// drop_longitude : ""
/// booking_type : ""
/// service_id : "0"
/// no_of_person : "0"
/// type_of_booking : ""
/// gst_amount : ""
/// items : ""
/// gst_charge : ""
/// delivery_charge : ""
/// vendor_delivery_charge : ""
/// hours : ""
/// user_name : ""
/// user_mobile : ""
/// fixed_amount : ""
/// p_date : "2024-06-10 15:50:39"
/// services_id : "[{\"service_id\":\"76\",\"price\":\"2000\"}, {\"service_id\":\"77\",\"price\":\"1000\"}]"
/// time : ""
/// note : "testingdddd"
/// admin_commission : "600"
/// payment_status : "0"
/// booking_id : "250"

class TodayBookingData {
  TodayBookingData({
      String? email, 
      String? mobile, 
      String? username, 
      String? id, 
      String? date, 
      String? slot, 
      String? userId, 
      String? resId, 
      dynamic size, 
      String? status, 
      String? aStatus, 
      dynamic reason, 
      String? isPaid, 
      String? otp, 
      String? amount, 
      String? txnId, 
      String? address, 
      dynamic addressId, 
      String? paymentType, 
      String? createdAt, 
      String? subtotal, 
      String? discount, 
      String? addons, 
      String? total, 
      String? pickupLocation, 
      String? dropLocation, 
      String? assignFor, 
      String? bookingStatus, 
      String? paidAmount, 
      String? km, 
      String? latitude, 
      String? longitude, 
      String? dropLatitude, 
      String? dropLongitude, 
      String? bookingType, 
      String? serviceId, 
      String? noOfPerson, 
      String? typeOfBooking, 
      String? gstAmount, 
      String? items, 
      String? gstCharge, 
      String? deliveryCharge, 
      String? vendorDeliveryCharge, 
      String? hours, 
      String? userName, 
      String? userMobile, 
      String? fixedAmount, 
      String? pDate, 
      String? servicesId, 
      String? time, 
      String? note, 
      String? adminCommission, 
      String? paymentStatus, 
      String? bookingId,}){
    _email = email;
    _mobile = mobile;
    _username = username;
    _id = id;
    _date = date;
    _slot = slot;
    _userId = userId;
    _resId = resId;
    _size = size;
    _status = status;
    _aStatus = aStatus;
    _reason = reason;
    _isPaid = isPaid;
    _otp = otp;
    _amount = amount;
    _txnId = txnId;
    _address = address;
    _addressId = addressId;
    _paymentType = paymentType;
    _createdAt = createdAt;
    _subtotal = subtotal;
    _discount = discount;
    _addons = addons;
    _total = total;
    _pickupLocation = pickupLocation;
    _dropLocation = dropLocation;
    _assignFor = assignFor;
    _bookingStatus = bookingStatus;
    _paidAmount = paidAmount;
    _km = km;
    _latitude = latitude;
    _longitude = longitude;
    _dropLatitude = dropLatitude;
    _dropLongitude = dropLongitude;
    _bookingType = bookingType;
    _serviceId = serviceId;
    _noOfPerson = noOfPerson;
    _typeOfBooking = typeOfBooking;
    _gstAmount = gstAmount;
    _items = items;
    _gstCharge = gstCharge;
    _deliveryCharge = deliveryCharge;
    _vendorDeliveryCharge = vendorDeliveryCharge;
    _hours = hours;
    _userName = userName;
    _userMobile = userMobile;
    _fixedAmount = fixedAmount;
    _pDate = pDate;
    _servicesId = servicesId;
    _time = time;
    _note = note;
    _adminCommission = adminCommission;
    _paymentStatus = paymentStatus;
    _bookingId = bookingId;
}

  TodayBookingData.fromJson(dynamic json) {
    _email = json['email'];
    _mobile = json['mobile'];
    _username = json['username'];
    _id = json['id'];
    _date = json['date'];
    _slot = json['slot'];
    _userId = json['user_id'];
    _resId = json['res_id'];
    _size = json['size'];
    _status = json['status'];
    _aStatus = json['a_status'];
    _reason = json['reason'];
    _isPaid = json['is_paid'];
    _otp = json['otp'];
    _amount = json['amount'];
    _txnId = json['txn_id'];
    _address = json['address'];
    _addressId = json['address_id'];
    _paymentType = json['payment_type'];
    _createdAt = json['created_at'];
    _subtotal = json['subtotal'];
    _discount = json['discount'];
    _addons = json['addons'];
    _total = json['total'];
    _pickupLocation = json['pickup_location'];
    _dropLocation = json['drop_location'];
    _assignFor = json['assign_for'];
    _bookingStatus = json['booking_status'];
    _paidAmount = json['paid_amount'];
    _km = json['km'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _dropLatitude = json['drop_latitude'];
    _dropLongitude = json['drop_longitude'];
    _bookingType = json['booking_type'];
    _serviceId = json['service_id'];
    _noOfPerson = json['no_of_person'];
    _typeOfBooking = json['type_of_booking'];
    _gstAmount = json['gst_amount'];
    _items = json['items'];
    _gstCharge = json['gst_charge'];
    _deliveryCharge = json['delivery_charge'];
    _vendorDeliveryCharge = json['vendor_delivery_charge'];
    _hours = json['hours'];
    _userName = json['user_name'];
    _userMobile = json['user_mobile'];
    _fixedAmount = json['fixed_amount'];
    _pDate = json['p_date'];
    _servicesId = json['services_id'];
    _time = json['time'];
    _note = json['note'];
    _adminCommission = json['admin_commission'];
    _paymentStatus = json['payment_status'];
    _bookingId = json['booking_id'];
  }
  String? _email;
  String? _mobile;
  String? _username;
  String? _id;
  String? _date;
  String? _slot;
  String? _userId;
  String? _resId;
  dynamic _size;
  String? _status;
  String? _aStatus;
  dynamic _reason;
  String? _isPaid;
  String? _otp;
  String? _amount;
  String? _txnId;
  String? _address;
  dynamic _addressId;
  String? _paymentType;
  String? _createdAt;
  String? _subtotal;
  String? _discount;
  String? _addons;
  String? _total;
  String? _pickupLocation;
  String? _dropLocation;
  String? _assignFor;
  String? _bookingStatus;
  String? _paidAmount;
  String? _km;
  String? _latitude;
  String? _longitude;
  String? _dropLatitude;
  String? _dropLongitude;
  String? _bookingType;
  String? _serviceId;
  String? _noOfPerson;
  String? _typeOfBooking;
  String? _gstAmount;
  String? _items;
  String? _gstCharge;
  String? _deliveryCharge;
  String? _vendorDeliveryCharge;
  String? _hours;
  String? _userName;
  String? _userMobile;
  String? _fixedAmount;
  String? _pDate;
  String? _servicesId;
  String? _time;
  String? _note;
  String? _adminCommission;
  String? _paymentStatus;
  String? _bookingId;
  TodayBookingData copyWith({  String? email,
  String? mobile,
  String? username,
  String? id,
  String? date,
  String? slot,
  String? userId,
  String? resId,
  dynamic size,
  String? status,
  String? aStatus,
  dynamic reason,
  String? isPaid,
  String? otp,
  String? amount,
  String? txnId,
  String? address,
  dynamic addressId,
  String? paymentType,
  String? createdAt,
  String? subtotal,
  String? discount,
  String? addons,
  String? total,
  String? pickupLocation,
  String? dropLocation,
  String? assignFor,
  String? bookingStatus,
  String? paidAmount,
  String? km,
  String? latitude,
  String? longitude,
  String? dropLatitude,
  String? dropLongitude,
  String? bookingType,
  String? serviceId,
  String? noOfPerson,
  String? typeOfBooking,
  String? gstAmount,
  String? items,
  String? gstCharge,
  String? deliveryCharge,
  String? vendorDeliveryCharge,
  String? hours,
  String? userName,
  String? userMobile,
  String? fixedAmount,
  String? pDate,
  String? servicesId,
  String? time,
  String? note,
  String? adminCommission,
  String? paymentStatus,
  String? bookingId,
}) => TodayBookingData(  email: email ?? _email,
  mobile: mobile ?? _mobile,
  username: username ?? _username,
  id: id ?? _id,
  date: date ?? _date,
  slot: slot ?? _slot,
  userId: userId ?? _userId,
  resId: resId ?? _resId,
  size: size ?? _size,
  status: status ?? _status,
  aStatus: aStatus ?? _aStatus,
  reason: reason ?? _reason,
  isPaid: isPaid ?? _isPaid,
  otp: otp ?? _otp,
  amount: amount ?? _amount,
  txnId: txnId ?? _txnId,
  address: address ?? _address,
  addressId: addressId ?? _addressId,
  paymentType: paymentType ?? _paymentType,
  createdAt: createdAt ?? _createdAt,
  subtotal: subtotal ?? _subtotal,
  discount: discount ?? _discount,
  addons: addons ?? _addons,
  total: total ?? _total,
  pickupLocation: pickupLocation ?? _pickupLocation,
  dropLocation: dropLocation ?? _dropLocation,
  assignFor: assignFor ?? _assignFor,
  bookingStatus: bookingStatus ?? _bookingStatus,
  paidAmount: paidAmount ?? _paidAmount,
  km: km ?? _km,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  dropLatitude: dropLatitude ?? _dropLatitude,
  dropLongitude: dropLongitude ?? _dropLongitude,
  bookingType: bookingType ?? _bookingType,
  serviceId: serviceId ?? _serviceId,
  noOfPerson: noOfPerson ?? _noOfPerson,
  typeOfBooking: typeOfBooking ?? _typeOfBooking,
  gstAmount: gstAmount ?? _gstAmount,
  items: items ?? _items,
  gstCharge: gstCharge ?? _gstCharge,
  deliveryCharge: deliveryCharge ?? _deliveryCharge,
  vendorDeliveryCharge: vendorDeliveryCharge ?? _vendorDeliveryCharge,
  hours: hours ?? _hours,
  userName: userName ?? _userName,
  userMobile: userMobile ?? _userMobile,
  fixedAmount: fixedAmount ?? _fixedAmount,
  pDate: pDate ?? _pDate,
  servicesId: servicesId ?? _servicesId,
  time: time ?? _time,
  note: note ?? _note,
  adminCommission: adminCommission ?? _adminCommission,
  paymentStatus: paymentStatus ?? _paymentStatus,
  bookingId: bookingId ?? _bookingId,
);
  String? get email => _email;
  String? get mobile => _mobile;
  String? get username => _username;
  String? get id => _id;
  String? get date => _date;
  String? get slot => _slot;
  String? get userId => _userId;
  String? get resId => _resId;
  dynamic get size => _size;
  String? get status => _status;
  String? get aStatus => _aStatus;
  dynamic get reason => _reason;
  String? get isPaid => _isPaid;
  String? get otp => _otp;
  String? get amount => _amount;
  String? get txnId => _txnId;
  String? get address => _address;
  dynamic get addressId => _addressId;
  String? get paymentType => _paymentType;
  String? get createdAt => _createdAt;
  String? get subtotal => _subtotal;
  String? get discount => _discount;
  String? get addons => _addons;
  String? get total => _total;
  String? get pickupLocation => _pickupLocation;
  String? get dropLocation => _dropLocation;
  String? get assignFor => _assignFor;
  String? get bookingStatus => _bookingStatus;
  String? get paidAmount => _paidAmount;
  String? get km => _km;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get dropLatitude => _dropLatitude;
  String? get dropLongitude => _dropLongitude;
  String? get bookingType => _bookingType;
  String? get serviceId => _serviceId;
  String? get noOfPerson => _noOfPerson;
  String? get typeOfBooking => _typeOfBooking;
  String? get gstAmount => _gstAmount;
  String? get items => _items;
  String? get gstCharge => _gstCharge;
  String? get deliveryCharge => _deliveryCharge;
  String? get vendorDeliveryCharge => _vendorDeliveryCharge;
  String? get hours => _hours;
  String? get userName => _userName;
  String? get userMobile => _userMobile;
  String? get fixedAmount => _fixedAmount;
  String? get pDate => _pDate;
  String? get servicesId => _servicesId;
  String? get time => _time;
  String? get note => _note;
  String? get adminCommission => _adminCommission;
  String? get paymentStatus => _paymentStatus;
  String? get bookingId => _bookingId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['username'] = _username;
    map['id'] = _id;
    map['date'] = _date;
    map['slot'] = _slot;
    map['user_id'] = _userId;
    map['res_id'] = _resId;
    map['size'] = _size;
    map['status'] = _status;
    map['a_status'] = _aStatus;
    map['reason'] = _reason;
    map['is_paid'] = _isPaid;
    map['otp'] = _otp;
    map['amount'] = _amount;
    map['txn_id'] = _txnId;
    map['address'] = _address;
    map['address_id'] = _addressId;
    map['payment_type'] = _paymentType;
    map['created_at'] = _createdAt;
    map['subtotal'] = _subtotal;
    map['discount'] = _discount;
    map['addons'] = _addons;
    map['total'] = _total;
    map['pickup_location'] = _pickupLocation;
    map['drop_location'] = _dropLocation;
    map['assign_for'] = _assignFor;
    map['booking_status'] = _bookingStatus;
    map['paid_amount'] = _paidAmount;
    map['km'] = _km;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['drop_latitude'] = _dropLatitude;
    map['drop_longitude'] = _dropLongitude;
    map['booking_type'] = _bookingType;
    map['service_id'] = _serviceId;
    map['no_of_person'] = _noOfPerson;
    map['type_of_booking'] = _typeOfBooking;
    map['gst_amount'] = _gstAmount;
    map['items'] = _items;
    map['gst_charge'] = _gstCharge;
    map['delivery_charge'] = _deliveryCharge;
    map['vendor_delivery_charge'] = _vendorDeliveryCharge;
    map['hours'] = _hours;
    map['user_name'] = _userName;
    map['user_mobile'] = _userMobile;
    map['fixed_amount'] = _fixedAmount;
    map['p_date'] = _pDate;
    map['services_id'] = _servicesId;
    map['time'] = _time;
    map['note'] = _note;
    map['admin_commission'] = _adminCommission;
    map['payment_status'] = _paymentStatus;
    map['booking_id'] = _bookingId;
    return map;
  }

}