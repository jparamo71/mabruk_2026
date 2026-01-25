class UserModel {
  final int userId;
  final String email;
  final String fullName;
  final bool allowUploadImage;
  String token = "";

  UserModel({
    required this.userId,
    required this.email,
    required this.fullName,
    required this.allowUploadImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: int.parse(json["userId"].toString()),
    email: json["email"] ?? '',
    fullName: json["fullName"] ?? '',
    allowUploadImage: json["allowUploadImage"],
  );

  Map<String, dynamic> toJson() => {
    'userIdd': userId,
    'email': email,
    'fullName': fullName,
    'allowUploadImage': allowUploadImage,
  };

}
