import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mabruk_2026/pages/customer/list_customers.dart';
import 'package:mabruk_2026/providers/mabruk_provider.dart';
import 'package:mabruk_2026/utils/palette_theme.dart';
import 'package:mabruk_2026/utils/styles/title_text.dart';
import 'package:provider/provider.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  late MabrukProvider provider;

  @override
  void initState() {
    provider = Provider.of<MabrukProvider>(context, listen: false);
    provider.getCustomers('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const TitleText('CLIENTES'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                autofocus: true,
                placeholder: "Buscar...",
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Color(0xFFC9C9C9), spreadRadius: 1),
                  ],
                ),
                onChanged: (value) {
                  provider.getCustomers(value);
                },
              ),
            ),
            SizedBox(height: 10.0),
            Consumer<MabrukProvider>(
              builder: (context, value, child) {
                if (value.documentsModel.isNotEmpty) {
                  return Expanded(
                    child: ListCustomer(
                      customers: context.watch<MabrukProvider>().customersModel,
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
