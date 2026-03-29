import 'package:flutter/material.dart';
import 'package:mabruk_2026/models/document_model.dart';
import 'package:mabruk_2026/pages/documents/item_document_list.dart';

class ListDocument extends StatelessWidget {
  final List<DocumentModel> documents;
  const ListDocument({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (context, index) {
        DocumentModel item = documents[index];
        return ItemDocumentList(document: item);
      },
    );
  }
}