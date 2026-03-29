class ImportDetailModel {
  int id = 0;
  int documentId = 0;
  int productId = 0;
  String barcharCode = "";
  String productName = "";
  double quantity = 0;
  double verifiedQuantity = 0;
  double difference = 0;
  double totalValue = 0;

  ImportDetailModel(
      {required this.id,
      required this.documentId,
      required this.productId,
      required this.barcharCode,
      required this.productName,
      required this.quantity,
      required this.verifiedQuantity,
      required this.difference,
      required this.totalValue});

  factory ImportDetailModel.fromJson(Map<String, dynamic> json) => ImportDetailModel(
      id: int.parse(json["id"]?.toString() ?? "0"),
      documentId: int.parse(json["documentId"]?.toString() ?? "0"),
      productId: int.parse(json["productId"]?.toString() ?? "0"),
      barcharCode: json["barcharCode"] ?? "",
      productName: json["productName"] ?? "",
      quantity: double.parse(json["quantity"]?.toString() ?? "0"),
      verifiedQuantity:
          double.parse(json["verifiedQuantity"]?.toString() ?? "0"),
      difference: double.parse(json["quantity"]?.toString() ?? "0") -
          double.parse(json["verifiedQuantity"]?.toString() ?? "0"),
      totalValue: double.parse(json["totalValue"]?.toString() ?? "0"));

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'documentId': documentId,
      'productId': productId,
      'barcharCode': barcharCode,
      'productName': productName,
      'quantity': quantity,
      'verifiedQuantity': verifiedQuantity,
      'difference': difference,
      'totalValue': totalValue
    };

  Map<String, dynamic> toJsonPhysical() =>
    {
      'id': documentId,
      'inventoryTakingId': id,
      'productId': productId,
      'barCharCode': barcharCode,
      'productName': productName,
      'systemAvailable': quantity,
      'physicalQuantity': verifiedQuantity,
      'difference': difference,
      'justified': false,
      'notes': ""
    };
/*
  Future<bool> updatePhysicalProduct() async {
    var jsonToSend = this.toJsonPhysical();
    HttpCustom hc = HttpCustom();
    print(jsonToSend);
    var url = Uri.https(urlBase, "/api/imports");
    Map<String, String> header = {
      'content-type': 'application/json',
      'Authorization': 'Bearer ${userToken}',
    };
    var response =
        await hc.put(url, headers: header, body: jsonEncode(jsonToSend));
    if (response == "") {
      return true;
    }
    return false;
  }*/

}
