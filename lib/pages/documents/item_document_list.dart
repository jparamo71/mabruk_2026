import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mabruk_2026/models/document_model.dart';
import 'package:mabruk_2026/utils/palette_theme.dart';
import 'package:mabruk_2026/utils/styles/normal_text.dart';

class ItemDocumentList extends StatelessWidget {
  final DocumentModel document;
  const ItemDocumentList({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat("#,##0.0#", "en_US");
    String documentNumber = document.isQuote
      ? "CT ${document.documentId.toString().padLeft(8, '0')}${document.statusDocumentId == 2 ? " (Confirmado)" : ""}"
      : "PD ${document.documentId.toString().padLeft(8, '0')}${document.statusDocumentId == 2 ? " (Confirmado)" : ""}";
    return Card(
      child: ListTile(
        leading: Icon(
          document.statusDocumentId == 2
              ? Icons.brightness_1_rounded
              : Icons.brightness_1_outlined,
          color: AppColors.mainColor,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NormalText(
              documentNumber,
              color: AppColors.grayFontColor,
              size: 16,
              bold: true,
            ),
            const SizedBox(height: 5.0),
            NormalText(
              document.customer.customerName,
              color: const Color(0xFF333333),
            ),
            const SizedBox(height: 5.0),
          ],
        ),
        subtitle: Text("${document.dateStr} Q. ${f.format(document.total)}"),
        trailing: const Icon(Icons.more_vert),
        isThreeLine: true,
        onTap: () {
          Navigator.pushNamed(context, "/document", arguments: document.documentId);
          //_showDocumentDetail(context, document.documentId);
        },
      ),
    );
  }
}

/*
void _showDocumentDetail(BuildContext context, int documentId) async {
  getDocument(documentId)
      .then((doc) async => _showDocumentAndWaitAnswer(context, doc))
      .catchError((error) => print(error.toString()));
}
*/
/*
void _showDocumentAndWaitAnswer(
    BuildContext context,
    DocumentModel document,
    ) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NewDocument(
        document,
        refreshParentReturn: true,
      ), //Document(document: document, refreshParentReturn: true),
    ),
  );
  if (result == "OK") {
    refreshList();
  }
}*/