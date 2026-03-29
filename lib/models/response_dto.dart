class ResponseDto {
  final int statusCode;
  final dynamic content;
  final String message;

  ResponseDto({
    required this.statusCode,
    required this.content,
    required this.message
  });

  factory ResponseDto.fromJson(Map<String, dynamic> json) => ResponseDto(
    statusCode: int.parse(json["statusCode"].toString()),
    content: json["content"],
    message: json["message"] ?? ''
  );

}