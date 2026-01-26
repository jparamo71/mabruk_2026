import 'package:flutter/material.dart';
import 'package:mabruk_2026/pages/document_list.dart';
import 'package:mabruk_2026/pages/import_list.dart';
import 'package:mabruk_2026/pages/main_menu.dart';
import 'package:mabruk_2026/pages/physical_tracking_list.dart';
import 'package:mabruk_2026/pages/product_list.dart';
import 'package:mabruk_2026/pages/quote_list.dart';
import 'package:mabruk_2026/pages/update_codes.dart';
import 'package:mabruk_2026/pages/update_upc.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MainMenu());
      case '/products':
        return MaterialPageRoute(builder: (_) => const ProductList());
      case '/documents':
        return MaterialPageRoute(builder: (_) => const DocumentList());
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
