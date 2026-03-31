import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mabruk_2026/models/product_model.dart';
import 'package:mabruk_2026/pages/products/product_list.dart';
import 'package:mabruk_2026/providers/mabruk_provider.dart';
import 'package:mabruk_2026/services/mabruk_service.dart';
import 'package:mabruk_2026/utils/globals.dart';
import 'package:mabruk_2026/utils/palette_theme.dart';
import 'package:mabruk_2026/utils/styles/big_text.dart';
import 'package:mabruk_2026/utils/styles/normal_text.dart';
import 'package:mabruk_2026/utils/styles/title_text.dart';
import 'package:mabruk_2026/widgets/rounded_button.dart';
import 'package:mabruk_2026/widgets/text_label_pair.dart';
import 'package:provider/provider.dart';
import 'package:mabruk_2026/models/document_detail.dart';
import 'package:mabruk_2026/models/document_model.dart';
import 'package:mabruk_2026/widgets/item_document.dart';

class Document extends StatefulWidget {
  final int id; // id of document to be showed
  final bool refreshParentReturn;
  const Document({
    super.key,
    required this.id,
    required this.refreshParentReturn,
  });

  @override
  State<Document> createState() => _DocumentState();
}

class _DocumentState extends State<Document> {
  late DocumentModel document;
  late MabrukProvider provider;
  bool enableEdition = false;
  bool isValid = true;
  final controllerQuantity = TextEditingController(text: "1");
  TextEditingController noteController = new TextEditingController();

  @override
  void initState() {
    provider = Provider.of<MabrukProvider>(context, listen: false);
    provider.getDocument(widget.id);
    super.initState();
  }

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
            String returnValue = (widget.refreshParentReturn ? 'OK' : '');
            Navigator.pop(context, returnValue);
          },
        ),
      ),
      body: SafeArea(
        child: Consumer<MabrukProvider>(
          builder: (context, value, child) {
            if (value.document != null) {
              document = value.document!;
              enableEdition = document.statusDocumentId != 2;
              return Column(
                children: [
                  customerHeader(provider.document!),
                  toolbar(context, provider.document!),
                  Expanded(child: documentDetails(provider.document!)),
                  documentNotes(),
                ],
              );
            }
            return Center(child: const CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  // Document's header
  Widget customerHeader(DocumentModel doc) {
    var f = NumberFormat("#,##0.0#", "en_US");
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          decoration: BoxDecoration(
            color: Color(0xfff0f5ef),
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 8, top: 16),
                child: Text(
                  (doc.isQuote ? "CT " : "PD ") +
                      doc.documentId.toString().padLeft(8, '0') +
                      (doc.statusDocumentId == 2 ? " (Confirmado)" : ""),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.green[900],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fecha', style: TextStyle(fontSize: 12)),
                        BigText(doc.dateStr, color: Colors.black87, size: 14.0),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total', style: TextStyle(fontSize: 12)),
                        BigText(
                          doc.total.toString(),
                          color: Colors.black87,
                          size: 14.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xff1c2c1b),
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Customer photo
              IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: const Icon(Icons.account_box),
                color: AppColors.grayFontColor,
                iconSize: 50,
                onPressed: doc.documentId > 0
                    ? () {
                        //_updateCustomerAndRefresh(context);
                      }
                    : () {
                        if ((doc.statusDocumentId ?? 0) <= 1) {
                          //_navigateAndSelectCustomer(context);
                        }
                      },
              ),
              SizedBox(width: 10.0),
              // Customer data
              Expanded(
                child: Container(
                  //height: 128,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.0),
                      NormalText(
                        doc.customer.customerName,
                        color: Colors.white,
                      ),
                      SizedBox(height: 5.0),
                      NormalText(doc.customer.nit, color: Colors.white),
                      SizedBox(height: 5.0),
                      NormalText(doc.customer.address, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Toolbar in the middle of the page
  Widget toolbar(BuildContext context, DocumentModel doc) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Container(
      height: 70,
      width: double.infinity,
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconRounded(
            icon: Icons.add,
            enabled: enableEdition,
            onClick: () async {
              _navigateAndSelectProduct(context);
            },
          ),
          IconRounded(
            icon: Icons.check,
            enabled: enableEdition,
            onClick: () async {
              MabrukService mabrukService = MabrukService();
              mabrukService.confirmQuote(doc.documentId, doc.seller.email).then(
                (_) {
                  Navigator.pop(
                    context,
                    (widget.refreshParentReturn ? 'OK' : ''),
                  );
                },
              );
            },
          ),
          IconRounded(
            icon: Icons.note,
            enabled: enableEdition,
            onClick: () async {
              _showNotes(doc.note == null ? "" : doc.note.toString());
            },
          ),
          IconRounded(
            icon: Icons.email,
            enabled: enableEdition,
            onClick: () async {
              _sendingDocument(doc.documentId, userName);
            },
          ),
          IconRounded(
            icon: Icons.delete,
            enabled: enableEdition,
            onClick: () => _showDeleteDocument(doc.documentId),
          ),
        ],
      ),
    );
  }

  // Document's details
  Widget documentDetails(DocumentModel doc) {
    return ListView.builder(
      itemCount: doc.details.length,
      itemBuilder: (context, index) {
        DocumentDetailModel currentDetail = doc.details[index];
        return ItemDocument(
          productId: currentDetail.product.productId,
          productCode: currentDetail.product.productCode,
          productName: currentDetail.product.productName,
          quantity: currentDetail.quantity,
          unitPrize: currentDetail.unitPrize,
          total: currentDetail.total,
          enable: doc.statusDocumentId != 2,
          imagePath: currentDetail.product.rutaFisicaImage(),
          onDelete: () =>
              _deleteProduct(currentDetail.detailId, doc.documentId),
          onChangeQuantity: () => _showChangeQuantity(context, currentDetail),
        );
      },
    );
  }

  Widget documentNotes() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE4FDA8),
            Color(0xFFFCFFA8)],
        ),
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(document.note ?? "xxx"),
    );
  }

  // Show notes
  Future<void> _showNotes(String currentNote) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            content: notes(currentNote),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'No'),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  provider.updateNote(document.documentId, currentNote);
                },
                child: const Text('Aplicar cambios'),
              ),
            ],
          ),
        );
      },
    );
  }

  // Notes document's association
  Widget notes(String currentNote) {
    noteController.text = currentNote;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: noteController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Observaciones',
        ),
      ),
    );
  }

  void _sendingDocument(int id, String email) {
    MabrukService ms = MabrukService();
    ms.sendEmail(id, email).then((response) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Enviado')));
    });
  }

  Future<void> _showDeleteDocument(int id) async {
    final bool? result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext deleteDocumentContext) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('¿Está seguro que desea eliminar el documento?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(deleteDocumentContext, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(deleteDocumentContext, true),
              child: const Text('Eliminar documento'),
            ),
          ],
        );
      },
    );

    if (result != null && result) {
      provider.deleteDocument(id, userName);
      Navigator.pop(context, 'OK');
    }
  }

  Future<void> _navigateAndSelectProduct(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProductList(returnValue: true, onlyAvailable: true),
      ),
    );

    if (result != null) {
      ProductModel productReturned = result as ProductModel;
      Provider.of<MabrukProvider>(context, listen: false).addDocumentDetail(
        0,
        document.documentId,
        productReturned.productId,
        productReturned.price,
        1,
      );
    }
  }

  Future<void> _deleteProduct(int id, int documentId) async {
    final bool? result = await showDialog<bool>(
      // Specify the return type
      context: context,
      builder: (BuildContext deleteContext) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text(
            '¿Está seguro que desea eliminar el registro seleccionado?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(deleteContext, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(deleteContext, true),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (result != null && result) {
      provider.deleteDocumentDetail(id, documentId);
    }
  }

  // Change product quantity
  Future<void> _showChangeQuantity(
    BuildContext context,
    DocumentDetailModel detail,
  ) async {
    final _formKey = GlobalKey<FormState>();
    controllerQuantity.text = detail.quantity.toString();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            content: Form(
              key: _formKey,
              child: Container(
                width: 400,
                child: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      NormalText(detail.product.justName.trim(), bold: true),
                      SizedBox(height: 8.0),
                      TextLabelPair(
                        caption: "Código",
                        text: detail.product.productCode,
                      ),
                      SizedBox(height: 8.0),
                      TextLabelPair(
                        caption: "Marca",
                        text: detail.product.brandName,
                      ),
                      SizedBox(height: 8.0),
                      TextLabelPair(
                        caption: "Precio unitario",
                        text: detail.product.price.toString(),
                      ),
                      SizedBox(height: 8.0),
                      TextLabelPair(
                        caption: "Disponibilidad",
                        text: detail.product.quantityAvailable.toString(),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NormalText("Cantidad", bold: true),
                          Container(
                            width: 120.0,
                            padding: EdgeInsets.symmetric(
                              vertical: 0.5,
                              horizontal: 0.5,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: (isValid
                                    ? Colors.black38
                                    : Colors.redAccent),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: TextFormField(
                              autofocus: true,
                              controller: controllerQuantity,
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]+[,.]{0,1}[0-9]*'),
                                ),
                                TextInputFormatter.withFunction(
                                  (oldValue, newValue) => newValue.copyWith(
                                    text: newValue.text.replaceAll(',', '.'),
                                  ),
                                ),
                              ],
                              decoration: InputDecoration(
                                //border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.all(4.0),
                                border: OutlineInputBorder(),
                                focusedBorder: InputBorder.none,
                                errorStyle: TextStyle(height: 0),
                              ),
                              validator: (value) {
                                setState(() {
                                  isValid = true;
                                });
                                if (value == null || value.isEmpty) {
                                  setState(() {
                                    isValid = false;
                                  });
                                  return '';
                                }
                                if (double.tryParse(value.toString()) == null) {
                                  setState(() {
                                    isValid = false;
                                  });
                                } else {
                                  double doubleValue = double.parse(
                                    value.toString(),
                                  );
                                  if (!document.isQuote &&
                                      doubleValue >
                                          detail.product.quantityAvailable) {
                                    setState(() {
                                      isValid = false;
                                    });
                                    return "";
                                  }
                                }
                                return null;
                              },
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'No'),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    double newQuantity = double.parse(controllerQuantity.text);
                    provider.addDocumentDetail(
                      detail.detailId,
                      document.documentId,
                      detail.product.productId,
                      detail.product.price,
                      newQuantity,
                    );
                    Navigator.pop(context, 'OK');
                  }
                },
                child: const Text('Agregar'),
              ),
            ],
          ),
        );
      },
    );
  }

  // fin de archivo
}

/*
class Document extends StatefulWidget {
  final int id;
  late bool refreshParentReturn;
  Document(this.id,
      {Key? key, this.refreshParentReturn = false})
      : super(key: key);

  @override
  State<Document> createState() => _DocumentState();
}

class _DocumentState extends State<Document> {
  //late DocumentModel document;
  bool isValid = true;
  bool isDeleted = false;
  bool isConfirmed = false;
  final controllerQuantity = TextEditingController(text: "1");
  double widthScreen = 0;
  TextEditingController noteController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    //document = widget.document;
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('MABRUK'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () =>
              Navigator.pop(context, widget.refreshParentReturn ? 'OK' : ''),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
          child: Column(
            children: [
              customerHeader(),
              toolbar(context),
              Expanded(
                child: documentDetails(),
              ),
            ],
          ),
        ),
      ),
    );
  }







  // Show notes
  Future<void> _showNotes() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            content: notes(),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'No'),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  updateNotes(widget.document.documentId, noteController.text)
                      .then((value) {
                    if (value.isSuccessful) {
                      widget.document.notes = noteController.text;
                      Navigator.pop(context, 'OK');
                    }
                  });
                },
                child: const Text('Aplicar cambios'),
              )
            ],
          ),
        );
      },
    );
  }





  Future<void> _confirmDocument() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: const Text('Confirmación'),
              content: SingleChildScrollView(
                child: NormalText(
                    '¿Está seguro que desea confirmar el documento?'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancelar'),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    confirmDocument(widget.document.documentId, userName)
                        .then((response) {
                      getDocument(widget.document.documentId).then((value) {
                        this.setState(() {
                          widget.refreshParentReturn = true;
                          widget.document = value;
                          Navigator.pop(context, 'OK');
                        });
                      });
                    });
                  },
                  child: const Text('Sí'),
                ),
              ],
            ),
          );
        });
  }



  void _updateCustomerAndRefresh(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Customer_Detail(customer: widget.document.customer),
      ),
    );
    if (result == "OK") {
      getDocument(widget.document.documentId).then((value) {
        setState(() {
          widget.document = value;
        });
      });
    }

  }

}
*/
