class PickDropModel {
  PickDropModel({
    required this.responseCode,
    required this.message,
    required this.orders,
    required this.status,
  });

  final String? responseCode;
  final String? message;
  final List<PickDropOrder> orders;
  final String? status;

  factory PickDropModel.fromJson(Map<String, dynamic> json){
    return PickDropModel(
      responseCode: json["response_code"],
      message: json["message"],
      orders: json["orders"] == null ? [] : List<PickDropOrder>.from(json["orders"]!.map((x) => PickDropOrder.fromJson(x))),
      status: json["status"],
    );
  }

}

class PickDropOrder {
  PickDropOrder({
    required this.pickRegion,
    required this.orderId,
    required this.productImage,
    required this.username,
    required this.mobile,
    required this.total,
    required this.date,
    required this.productType,
    required this.vehicleType,
    required this.productDescription,
    required this.ordersType,
    required this.time,
    required this.locationData,
    required this.note,
    required this.paymentMode,
    required this.invoice,
    required this.ordertype,
    required this.pickupLocations,
    required this.dropLocations,
  });

  final String? pickRegion;
  final String? orderId;
  final String? productImage;
  final String? username;
  final String? mobile;
  final String? total;
  final DateTime? date;
  final String? productType;
  final String? vehicleType;
  final String? productDescription;
  final String? ordersType;
  final String? time;
  final String? locationData;
  final String? note;
  final String? ordertype;
  final String? paymentMode;
  final String? invoice;
  final List<PickupLocation> pickupLocations;
  final List<DropLocation> dropLocations;

  factory PickDropOrder.fromJson(Map<String, dynamic> json){
    return PickDropOrder(
      pickRegion: json["pick_region"],
      orderId: json["order_id"],
      productImage: json["product_image"],
      username: json["username"],
      mobile: json["mobile"],
      total: json["total"],
      date: DateTime.tryParse(json["date"] ?? ""),
      productType: json["product_type"],
      vehicleType: json["vehicle_type"],
      productDescription: json["product_description"],
      ordersType: json["orders_type"],
      time: json["time"],
      locationData: json["location_data"],
      paymentMode: json["payment_mode"],
      invoice: json["invoice"],
      note: json["note"],
      ordertype: json["ordertype"],
      pickupLocations: json["pickup_locations"] == null ? [] : List<PickupLocation>.from(json["pickup_locations"]!.map((x) => PickupLocation.fromJson(x))),
      dropLocations: json["drop_locations"] == null ? [] : List<DropLocation>.from(json["drop_locations"]!.map((x) => DropLocation.fromJson(x))),
    );
  }

}

class DropLocation {
  DropLocation({
    required this.id,
    required this.orderId,
    required this.itemStatus,
    required this.reciverLat,
    required this.reciverLang,
    required this.dropLocation,
    required this.dropName,
    required this.dropNumber,
    required this.dropAddressType,
    required this.dropRegion,
  });

  final String? id;
  final String? orderId;
  final dynamic itemStatus;
  final String? reciverLat;
  final String? reciverLang;
  final String? dropLocation;
  final String? dropName;
  final String? dropNumber;
  final String? dropAddressType;
  final String? dropRegion;

  factory DropLocation.fromJson(Map<String, dynamic> json){
    return DropLocation(
      id: json["id"],
      orderId: json["order_id"],
      itemStatus: json["item_status"],
      reciverLat: json["reciver_lat"],
      reciverLang: json["reciver_lang"],
      dropLocation: json["drop_location"],
      dropName: json["drop_name"],
      dropNumber: json["drop_number"],
      dropAddressType: json["drop_address_type"],
      dropRegion: json["drop_region"],
    );
  }

}

class PickupLocation {
  PickupLocation({
    required this.id,
    required this.itemStatus,
    required this.orderId,
    required this.senderLat,
    required this.pickupLocation,
    required this.pickupName,
    required this.pickupMobile,
    required this.pickupRegion,
  });

  final String? id;
  final dynamic itemStatus;
  final String? orderId;
  final String? senderLat;
  final String? pickupLocation;
  final String? pickupName;
  final String? pickupMobile;
  final String? pickupRegion;

  factory PickupLocation.fromJson(Map<String, dynamic> json){
    return PickupLocation(
      id: json["id"],
      itemStatus: json["item_status"],
      orderId: json["order_id"],
      senderLat: json["sender_lat"],
      pickupLocation: json["pickup_location"],
      pickupName: json["pickup_name"],
      pickupMobile: json["pickup_mobile"],
      pickupRegion: json["pickup_region"],
    );
  }

}
