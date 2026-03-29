class PhysicalTrackingDetailModel {
  int id = 0;
  int inventoryTrackingId = 0;
  int productId = 0;
  String barcharCode = "";
  String productName = "";
  double systemAvailable = 0;
  double physicalQuantity = 0;
  double difference = 0;
  bool justified = false;
  String? notes;

  PhysicalTrackingDetailModel();

  PhysicalTrackingDetailModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id']?.toString() ?? "0"),
        inventoryTrackingId =
            int.parse(json['inventoryTakingId']?.toString() ?? "0"),
        productId = int.parse(json["productId"]?.toString() ?? "0"),
        barcharCode = json["barcharCode"] ?? "",
        productName = json["productName"],
        systemAvailable =
            double.parse(json["systemAvailable"]?.toString() ?? "0"),
        physicalQuantity =
            double.parse(json["physicalQuantity"]?.toString() ?? "0"),
        difference = double.parse(json["difference"]?.toString() ?? "0"),
        justified = false,
        notes = json["notes"];

  Map<String, dynamic> toJson() {
    var result = {
      'id': id,
      'inventoryTakingId': inventoryTrackingId,
      'productId': productId,
      'barCharCode': barcharCode,
      'productName': productName,
      'systemAvailable': systemAvailable,
      'physicalQuantity': physicalQuantity,
      'difference': difference,
      'justified': justified,
      'notes': notes ?? ""
    };

    return result;
  }
}