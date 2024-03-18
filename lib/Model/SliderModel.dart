
class SliderMOdel {
  bool error;
  String message;
  List<BannerListModel> data;
  String image;

  SliderMOdel({
    required this.error,
    required this.message,
    required this.data,
    required this.image,
  });

  factory SliderMOdel.fromJson(Map<String, dynamic> json) => SliderMOdel(
    error: json["error"],
    message: json["message"],
    data: List<BannerListModel>.from(json["data"].map((x) => BannerListModel.fromJson(x))),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "image": image,
  };
}

class BannerListModel {
  String id;
  String bannersName;
  String image;
  String roleType;
  String bannerType;
  DateTime startDate;
  DateTime endDate;
  String vendorId;
  String totalDay;

  BannerListModel({
    required this.id,
    required this.bannersName,
    required this.image,
    required this.roleType,
    required this.bannerType,
    required this.startDate,
    required this.endDate,
    required this.vendorId,
    required this.totalDay,
  });

  factory BannerListModel.fromJson(Map<String, dynamic> json) => BannerListModel(
    id: json["id"],
    bannersName: json["banners_name"],
    image: json["image"],
    roleType: json["role_type"],
    bannerType: json["banner_type"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    vendorId: json["vendor_id"],
    totalDay: json["total_day"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "banners_name": bannersName,
    "image": image,
    "role_type": roleType,
    "banner_type": bannerType,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "vendor_id": vendorId,
    "total_day": totalDay,
  };
}
