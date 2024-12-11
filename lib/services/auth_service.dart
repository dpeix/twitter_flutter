import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

Future<void> fetchData() async {
  String? token = await storage.read(key: "authToken");

  final response = await http.get(
    Uri.parse("https://std30.beaupeyrat.com/auth"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    },
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
  } else {
    print("Erreur de récupération des données");
  }
}

