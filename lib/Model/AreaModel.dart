
class GetAreaModel {
  String responseCode;
  String msg;
  List<AreaModelList> data;

  GetAreaModel({
    required this.responseCode,
    required this.msg,
    required this.data,
  });

  factory GetAreaModel.fromJson(Map<String, dynamic> json) => GetAreaModel(
    responseCode: json["response_code"],
    msg: json["msg"],
    data: List<AreaModelList>.from(json["data"].map((x) => AreaModelList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response_code": responseCode,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AreaModelList {
  String id;
  String name;
  String cityId;
  String stateId;

  AreaModelList({
    required this.id,
    required this.name,
    required this.cityId,
    required this.stateId,
  });

  factory AreaModelList.fromJson(Map<String, dynamic> json) => AreaModelList(
    id: json["id"],
    name: json["name"],
    cityId: json["city_id"],
    stateId: json["state_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "city_id": cityId,
    "state_id": stateId,
  };
}
