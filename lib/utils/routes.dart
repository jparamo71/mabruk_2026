import 'package:flutter/material.dart';
import 'package:mabruk_2026/pages/document_list.dart';
import 'package:mabruk_2026/pages/main_menu.dart';
import 'package:mabruk_2026/pages/product_list.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MainMenu());
      case '/products':
        return MaterialPageRoute(builder: (_) => const ProductList());
      case '/documents':
        return MaterialPageRoute(builder: (_) => const DocumentList());
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
