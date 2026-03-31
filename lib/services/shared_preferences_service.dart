import 'package:mabruk_2026/utils/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserConfig(String userEmail, String serverDatabase) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userEmail', userEmail);
  await prefs.setString('serverDatabase', serverDatabase);
}

Future<void> loadConfiguration() async {
  final prefs = await SharedPreferences.getInstance();
  userName = prefs.getString('userEmail') ?? '';
  urlBase = prefs.getString('serverDatabase') ?? '190.149.69.214:4432';
  print("El nombre de usuario es: ${userName}");
  print("La url base es ${urlBase}");
}
