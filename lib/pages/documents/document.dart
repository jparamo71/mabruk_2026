import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mabruk_2026/models/product_model.dart';
import 'package:mabruk_2026/pages/product_catalog.dart';
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
  TextEditingController noteController = new TextEditingController();

  @override
  void initState() {
    Provider.of<MabrukProvider>(context, listen: false).getDocument(widget.id);
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
              return Column(
                children: [
                  customerHeader(context.watch<MabrukProvider>().document!),
                  toolbar(context, context.watch<MabrukProvider>().document!),
                  Expanded(
                    child: documentDetails(
                      context.watch<MabrukProvider>().document!,
                    ),
                  ),
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
              fontSize: 25,
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
                  BigText(doc.dateStr, color: Colors.black87),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total', style: TextStyle(fontSize: 12)),
                  BigText(doc.total.toString(), color: Colors.black87),
                ],
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(15),
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
            enabled: true,
            onClick: () async {
              _navigateAndSelectProduct(context);
            },
          ),
          IconRounded(
            icon: Icons.check,
            enabled: true,
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
            enabled: true,
            onClick: () async {
              _showNotes(doc.notes == null ? "" : doc.notes.toString());
            },
          ),
          IconRounded(icon: Icons.email, enabled: true, onClick: () async {
            _sendingDocument(doc.documentId, userName);
          }),
          IconRounded(icon: Icons.delete, enabled: false, onClick: () async {
            _showDeleteDocument(context).then((_) {
              Navigator.pop(
                  context, (widget.refreshParentReturn ? 'OK' : ''));
            });
          }),
          /*DocumentButton(
            width: ElementsSize.width64,
            height: ElementsSize.height40,
            text: widthScreen > 400 ? 'Agregar' : '',
            icon: Icons.add,
            enabled: (doc.statusDocumentId == 1 ? true : false),
            iconColor: Color.fromARGB(255, 13, 90, 10),
            onClick: () {
              //_navigateAndSelectProduct(context);
            },
          ),
          DocumentButton(
            width: ElementsSize.width64,
            height: ElementsSize.height40,
            text: widthScreen > 400 ? 'Confirmar' : '',
            icon: Icons.check,
            iconColor: Color.fromARGB(255, 13, 90, 10),
            enabled: (doc.statusDocumentId == 1 ? true : false),
            onClick: () {
              /*_confirmDocument().then((_) {
                  Navigator.pop(
                      context, (widget.refreshParentReturn ? 'OK' : ''));
                });*/
            },
          ),
          DocumentButton(
            width: ElementsSize.width64,
            height: ElementsSize.height40,
            text: widthScreen > 400 ? 'Notas' : '',
            icon: Icons.note,
            iconColor: Color.fromARGB(255, 13, 90, 10),
            enabled: (doc.statusDocumentId == 1 ? true : false),
            onClick: () {
              //_showNotes();
            },
          ),
          DocumentButton(
            width: ElementsSize.width64,
            height: ElementsSize.height40,
            text: widthScreen > 400 ? 'Enviar' : '',
            icon: Icons.email,
            iconColor: Color.fromARGB(255, 13, 90, 10),
            enabled: (doc.statusDocumentId == 2 ? true : false),
            onClick: () {
              //_sendingDocument();
            },
          ),
          DocumentButton(
            width: ElementsSize.width64,
            height: ElementsSize.height40,
            text: widthScreen > 400 ? 'Eliminar' : '',
            icon: Icons.delete,
            iconColor: Color.fromARGB(255, 13, 90, 10),
            enabled: (doc.statusDocumentId == 1 ? true : false),
            onClick: () {
              /*_showDeleteDocument(context).then((_) {
                  Navigator.pop(
                      context, (widget.refreshParentReturn ? 'OK' : ''));
                });*/
            },
          )*/
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
          enable: doc.statusDocumentId == 2 ? false : true,
          imagePath: currentDetail.product.rutaFisicaImage(),
          onDelete: () {
            /*deleteDocumentDetail(currentDetail.detailId)
                  .then((resultExecution) {
                if (resultExecution.isSuccessful) {
                  getDocument(doc.documentId).then((value) {
                    setState(() {
                      doc = value;
                    });
                  });
                }
              });*/
          },
          onChangeQuantity: () {
            /*getProduct(currentDetail.product.productId).then((value) {
                _showChangeQuantity(
                    context, currentDetail.quantity, value.quantityAvailable);
              });*/
          },
        );
      },
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
                  /*updateNotes(widget.document.documentId, noteController.text)
                      .then((value) {
                    if (value.isSuccessful) {
                      widget.document.notes = noteController.text;
                      Navigator.pop(context, 'OK');
                    }
                  });*/
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

  Future<void> _showDeleteDocument(BuildContext context) async {
    MabrukService ms = MabrukService();
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('Confirmación'),
            content: SingleChildScrollView(
              child: BigText(
                  '¿Está seguro que desea eliminar el documento?'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancelar'),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  ms.deleteDocument(document.documentId, userName)
                      .then((response) {
                    if (response) {
                      Navigator.pop(context, 'OK');
                    }
                  });
                },
                child: const Text('Sí'),
              ),
            ],
          ),
        );
      },
    );
  }








}

void _navigateAndSelectProduct(BuildContext context) async {
  /*getBrands().then((response) async {
    print(response);*/
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductList(
        returnValue: true /*MainButtonParameter(
          onlyAvailable: !widget.document.isQuote,
          customerId: widget.document.customer.customerId,
          brands: response,
        ),*/,
      ),
    ),
  );

  if (result != null) {
    ProductModel productReturned = result as ProductModel;
    //_showChangeQuantity(context, productReturned);
  }
  /* });*/
}



// Change product quantity
Future<void> _showChangeQuantity(
    BuildContext context,
    ProductModel product,
    ) async {
  final _formKey = GlobalKey<FormState>();
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
                    NormalText(product.justName.trim(), bold: true),
                    SizedBox(height: 10.0),
                    TextLabelPair(
                        caption: "Código", text: product.productCode),
                    SizedBox(height: 10.0),
                    TextLabelPair(caption: "Marca", text: product.brandName),
                    SizedBox(height: 10.0),
                    TextLabelPair(
                        caption: "Precio unitario",
                        text: product.prize.toString()),
                    SizedBox(height: 10.0),
                    TextLabelPair(
                        caption: "Disponibilidad",
                        text: product.quantityAvailable.toString()),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NormalText(
                          "Cantidad",
                          bold: true,
                        ),
                        Container(
                          width: 120.0,
                          padding: EdgeInsets.symmetric(
                              vertical: 0.5, horizontal: 0.5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: (isValid
                                      ? Colors.green
                                      : Colors.redAccent),
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: TextFormField(
                            autofocus: true,
                            controller: controllerQuantity,
                            keyboardType: TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                              TextInputFormatter.withFunction(
                                    (oldValue, newValue) => newValue.copyWith(
                                  text: newValue.text.replaceAll(',', '.'),
                                ),
                              ),
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
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
                                double doubleValue =
                                double.parse(value.toString());
                                if (!widget.document.isQuote &&
                                    doubleValue > product.quantityAvailable) {
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
                  addNewDetail(
                      widget.document.documentId,
                      0,
                      product.productId,
                      newQuantity,
                      product.prize,
                      product.prize * newQuantity)
                      .then((value) {
                    getDocument(widget.document.documentId).then((value) {
                      this.setState(() {
                        widget.refreshParentReturn = true;
                        widget.document = value;
                        Navigator.pop(context, 'OK');
                      });
                    });
                  });
                }
              },
              child: const Text('Agregar'),
            )
          ],
        ),
      );
    },
  );
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
