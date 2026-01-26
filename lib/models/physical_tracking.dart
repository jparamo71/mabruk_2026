class PhysicalTrackingModel {
  int id = 0;
  DateTime dateStart = DateTime.now();
  String status = "";
  int userId = 0;
  int markId = 0;
  String markName = "";
  //List<PtDetail>? details;

  PhysicalTrackingModel();

  PhysicalTrackingModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      dateStart = DateTime.parse(json['dateStart'] as String),
      status = json["status"].toString(),
      userId = json["userId"],
      markId = json["markId"],
      markName = json["markName"].toString();

  Map<String, dynamic> toJson() {
    var result = {
      'id': id,
      'status': status,
      'userId': userId,
      'markId': markId,
      'markName': markName,
    };

    return result;
  }
}
