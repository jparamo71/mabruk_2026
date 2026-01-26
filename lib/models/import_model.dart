class ImportModel {
  final int id;
  final String documentTypeId;
  final String documentTypeName;
  final String documentNumber;
  final int providerId;
  final String providerName;
  final String documentDateStr;
  final double totalValue;
  final String status;
  //List<ImportDetail> detail = [];

  ImportModel({
    required this.id,
    required this.documentTypeId,
    required this.documentTypeName,
    required this.documentNumber,
    required this.providerId,
    required this.providerName,
    required this.documentDateStr,
    required this.totalValue,
    required this.status,
  });

  factory ImportModel.fromJson(Map<String, dynamic> json) => ImportModel(
    id: json['id']?.toInt() ?? 0, // int.parse(json["id"]?.toString() ?? "0"),
    documentTypeId: json["documentTypeId"] ?? "",
    documentNumber: json["documentNumber"] ?? "",
    documentTypeName: json["documentTypeName"] ?? "",
    providerId: int.parse(json["providerId"]?.toString() ?? "0"),
    providerName: json["providerName"] ?? "",
    documentDateStr:
        json["documentDate"]?.toString() ?? DateTime.now().toString(),
    totalValue: double.parse(json["totalValue"]?.toString() ?? "0"),
    status: json["status"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'documentTypeId': documentTypeId,
    'documentTypeName': documentTypeName,
    'documentNumber' : documentNumber,
    'providerId': providerId,
    'providerName': providerName,
    'documentDateStr': documentDateStr,
    'totalValue': totalValue,
    'status': status,
  };
}
