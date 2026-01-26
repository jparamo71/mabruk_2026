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
    customerId: int.parse(json["ClienteID"].toString()),
    customerName: json["Nombre_Cliente"] ?? '',
    nit: json["NIT"] ?? '',
    address: json["Direccion"] ?? '',
    phoneNumber: json["Telefono"] ?? '',
    email: json["Correo_Electronico"] ?? '',
    mainContact: json["Contacto_Principal"] ?? '',
    phoneContact: json["Telefono_Contacto"] ?? '',
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
