import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String apiUrl = "https://std30.beaupeyrat.com/auth";
  final storage = const FlutterSecureStorage();

  Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['token'];

      // Sauvegarder le token de manière sécurisée
      await storage.write(key: "authToken", value: token);
    } else {
      throw Exception("Échec de la connexion");
    }
  }
}
