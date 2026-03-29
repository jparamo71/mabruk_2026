import 'package:flutter/material.dart';
import 'package:mabruk_2026/pages/customer/customer_list.dart';
import 'package:mabruk_2026/pages/documents/document.dart';
import 'package:mabruk_2026/pages/documents/document_list.dart';
import 'package:mabruk_2026/pages/import_list.dart';
import 'package:mabruk_2026/pages/physical_tracking_list.dart';
import 'package:mabruk_2026/pages/products/product_list.dart';
import 'package:mabruk_2026/pages/quotes/quote_list.dart';
import 'package:mabruk_2026/pages/update_codes.dart';
import 'package:mabruk_2026/pages/update_upc.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/products':
        return MaterialPageRoute(builder: (_) => const ProductList(returnValue:  false));
      case '/documents':
        return MaterialPageRoute(builder: (_) => const DocumentList());
      case '/customers':
        return MaterialPageRoute(builder: (_) => const CustomerList());
      case '/document':
        if (args is int) {
          return MaterialPageRoute(builder: (_) => Document(id: args, refreshParentReturn: true));
        }
        return _errorRoute();
      case '/quotes':
        return MaterialPageRoute(builder: (_) => const QuoteList());
      case '/tracking-inventories':
        return MaterialPageRoute(builder: (_) => const PhysicalTrackingList());
      case '/imports':
        return MaterialPageRoute(builder: (_) => const ImportList());
      case '/update-code':
        return MaterialPageRoute(builder: (_) => const UpdateCodes());
      case '/update-upc':
        return MaterialPageRoute(builder: (_) => const UpdateUPC());
      /*case '/import-view':
        if (args is int) {
          return MaterialPageRoute(builder: (_) => ImportView(id: args));
        }
        return _errorRoute();*/
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text('Error'), centerTitle: true),
          body: Center(child: Text('ERROR')),
        );
      },
    );
  }
}
