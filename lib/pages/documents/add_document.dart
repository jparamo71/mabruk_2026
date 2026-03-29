import 'package:flutter/material.dart';
import 'package:mabruk_2026/models/customer_model.dart';
import 'package:mabruk_2026/pages/customer/customer_list.dart';
import 'package:mabruk_2026/providers/mabruk_provider.dart';
import 'package:mabruk_2026/services/mabruk_service.dart';
import 'package:mabruk_2026/utils/globals.dart';
import 'package:mabruk_2026/utils/palette_theme.dart';
import 'package:mabruk_2026/utils/styles/title_text.dart';
import 'package:provider/provider.dart';

class AddDocument extends StatefulWidget {
  const AddDocument({super.key});

  @override
  State<AddDocument> createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: TitleText("MABRUK"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            //String returnValue = (widget.refreshParentReturn ? 'OK' : '');
            //Navigator.pop(context, returnValue);
          },
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _navigateAndSelectCustomer(context);
          },
          child: Text('Escoja un cliente'),
        ),
      ),
    );
  }

  void _navigateAndSelectCustomer(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CustomerList()),
    );

    if (result != null) {
      CustomerModel _customerSelected = result as CustomerModel;
      final mabrukService = MabrukService();
      var document = await mabrukService.createDocument(_customerSelected.customerId, userName, false);
      if (document != null)
      {
        Navigator.pop(context, document.documentId);
      }
      /*createNewDocument(
          _customerSelected.customerId, userName, widget.document.isQuote)
          .then((result) {
        widget.refreshParentReturn = true;
        int _documentId = int.parse(result.tag.toString());
        getDocument(_documentId).then((value) {
          setState(() {
            widget.document = value;
          });
        });
      });*/
    }
  }
}
