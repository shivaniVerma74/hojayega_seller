class FestivalModel {
  bool? error;
  String? message;
  FestivalData? data;

  FestivalModel({this.error, this.message, this.data});

  FestivalModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new FestivalData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class FestivalData {
  String? id;
  String? stateDate;
  String? endDate;
  String? price;
  String? createAt;
  String? updateAt;
  String? status;

  FestivalData(
      {this.id,
        this.stateDate,
        this.endDate,
        this.price,
        this.createAt,
        this.updateAt,
        this.status});

  FestivalData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateDate = json['state_date'];
    endDate = json['end_date'];
    price = json['price'];
    createAt = json['create_at'];
    updateAt = json['update_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_date'] = this.stateDate;
    data['end_date'] = this.endDate;
    data['price'] = this.price;
    data['create_at'] = this.createAt;
    data['update_at'] = this.updateAt;
    data['status'] = this.status;
    return data;
  }
}
