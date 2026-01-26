import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mabruk_2026/models/docment_model.dart';
import 'package:mabruk_2026/utils/palette_theme.dart';
import 'package:mabruk_2026/widgets/normal_text.dart';

class ItemDocumentList extends StatelessWidget {
  final DocumentModel document;
  const ItemDocumentList({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat("#,##0.0#", "en_US");
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
              "PD ${document.documentId.toString().padLeft(8, '0')}${document.statusDocumentId == 2 ? " (Confirmado)" : ""}",
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
          //_showDocumentDetail(context, document.documentId);
        },
      ),
    );
  }
}
