// To parse this JSON data, do
//
//     final getTimeSlotModel = getTimeSlotModelFromJson(jsonString);

import 'dart:convert';

GetTimeSlotModel getTimeSlotModelFromJson(String str) => GetTimeSlotModel.fromJson(json.decode(str));

String getTimeSlotModelToJson(GetTimeSlotModel data) => json.encode(data.toJson());

class GetTimeSlotModel {
  int status;
  String msg;
  List<TimeSlotListBooking> booking;

  GetTimeSlotModel({
    required this.status,
    required this.msg,
    required this.booking,
  });

  factory GetTimeSlotModel.fromJson(Map<String, dynamic> json) => GetTimeSlotModel(
    status: json["status"],
    msg: json["msg"],
    booking: List<TimeSlotListBooking>.from(json["booking"].map((x) => TimeSlotListBooking.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "booking": List<dynamic>.from(booking.map((x) => x.toJson())),
  };
}

class TimeSlotListBooking {
  String id;
  String stateTime;
  String endTime;
  String price;
  DateTime createAt;
  DateTime updateAt;
  String status;
  String type;

  TimeSlotListBooking({
    required this.id,
    required this.stateTime,
    required this.endTime,
    required this.price,
    required this.createAt,
    required this.updateAt,
    required this.status,
    required this.type,
  });

  factory TimeSlotListBooking.fromJson(Map<String, dynamic> json) => TimeSlotListBooking(
    id: json["id"],
    stateTime: json["state_time"],
    endTime: json["end_time"],
    price: json["price"],
    createAt: DateTime.parse(json["create_at"]),
    updateAt: DateTime.parse(json["update_at"]),
    status: json["status"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "state_time": stateTime,
    "end_time": endTime,
    "price": price,
    "create_at": createAt.toIso8601String(),
    "update_at": updateAt.toIso8601String(),
    "status": status,
    "type": type,
  };
}
