class CustomerModel {
  final int customerId;
  final String customerName;
  final String nit;
  final String address;
  final String phoneNumber;
  final String email;
  final String mainContact;
  final String phoneContact;

  CustomerModel({
    required this.customerId,
    required this.customerName,
    required this.nit,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.mainContact,
    required this.phoneContact,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    customerId: int.parse(json["clienteId"].toString()),
    customerName: json["nombreComercial"] ?? '',
    nit: json["nit"] ?? '',
    address: json["direccionComercial"] ?? '',
    phoneNumber: json["telefonos"] ?? '',
    email: json["correoElectronico"] ?? '',
    mainContact: json["contactoPrincipal"] ?? '',
    phoneContact: json["telContacto"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'customerId': customerId,
    'customerName': customerName,
    'nit': nit,
    'address': address,
    'phoneNumber': phoneNumber,
    'email': email,
    'mainContact': mainContact,
    'phoneContact': phoneContact,
  };
}
