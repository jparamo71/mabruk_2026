import 'package:flutter/material.dart';
import 'package:mabruk_2026/models/customer_model.dart';
import 'package:mabruk_2026/pages/customer/item_customer.dart';

class ListCustomer extends StatelessWidget {
  final List<CustomerModel> customers;
  const ListCustomer({super.key, required this.customers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: customers.length,
      itemBuilder: (context, index) {
        CustomerModel item = customers[index];
        return ItemCustomer(
          customerName: item.customerName,
          nit: item.nit,
          address: item.address,
          phoneNumber: item.phoneNumber,
          email: item.email,
          onSelect: () {
            Navigator.pop(context, item);
          },
        );
      },
    );
  }
}