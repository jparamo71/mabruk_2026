import 'package:flutter/material.dart';
import 'package:mabruk_2026/providers/mabruk_provider.dart';
import 'package:mabruk_2026/utils/palette_theme.dart';
import 'package:mabruk_2026/widgets/list_documents.dart';
import 'package:provider/provider.dart';

class QuoteList extends StatefulWidget {
  const QuoteList({super.key});

  @override
  State<QuoteList> createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  @override
  void initState() {
    Provider.of<MabrukProvider>(
      context,
      listen: false,
    ).getDocuments('jiparamoflores@gmail.com', 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('COTIZACIONES'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Consumer<MabrukProvider>(
          builder: (context, value, child) {
            if (value.documentsModel.isNotEmpty) {
              return ListDocument(
                documents: context.watch<MabrukProvider>().documentsModel,
              );
            }
            return const Center(child: Text("xxxx"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /*DocumentModel document = DocumentModel(
              customer: CustomerModel(
                  adddress: '',
                  customerId: 0,
                  customerName: '',
                  email: '',
                  nit: '',
                  phoneNumber: '',
                  mainContact: '',
                  phoneContact: ''),
              dateStr: '',
              documentId: 0,
              isQuote: true,
              seller: UserModel(
                  email: '', fullName: '', userId: 0, allowUploadImage: false),
              notes: '',
              deliveryAddress: '',
              total: 0.0,
              statusDocument: '',
              statusDocumentId: 0);
          _showDocumentAndWaitAnswer(document);*/
        },
        backgroundColor: AppColors.mainColor,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedIconTheme: IconThemeData(color: AppColors.mainColor),
        selectedItemColor: AppColors.mainColor,
        backgroundColor: AppColors.mainBackGround,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Pedidos'),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Productos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Cotizaciones',
          ),
        ],
        onTap: (int index) {
          /*if (index == 0) {
              Navigator.of(context).pushReplacementNamed("/documents");
            } else if (index == 1) {
              getBrands().then((response) {
                Navigator.of(context).pushReplacementNamed(
                  "/products",
                  arguments: MainButtonParameter(
                    onlyAvailable: true,
                    customerId: 0,
                    returnValue: false,
                    brands: response,
                  ),
                );
              });
            }*/
        },
      ),
    );
  }
}
