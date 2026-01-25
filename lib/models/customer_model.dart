class CustomerModel {
  final int customerId;
  final String customerName;
  final String nit;
  final String adddress;
  final String phoneNumber;
  final String email;
  final String mainContact;
  final String phoneContact;

  CustomerModel({
    required this.customerId,
    required this.customerName,
    required this.nit,
    required this.adddress,
    required this.phoneNumber,
    required this.email,
    required this.mainContact,
    required this.phoneContact,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      customerId: int.parse(json["ClienteID"].toString()),
      customerName: json["Nombre_Cliente"] ?? '',
      nit: json["NIT"] ?? '',
      adddress: json["Direccion"] ?? '',
      phoneNumber: json["Telefono"] ?? '',
      email: json["Correo_Electronico"] ?? '',
      mainContact: json["Contacto_Principal"] ?? '',
      phoneContact: json["Telefono_Contacto"] ?? '',
    );
  }
}
