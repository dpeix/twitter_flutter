import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<String?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('user');
  if (userId == null) {
    print("Aucun ID utilisateur trouvé dans SharedPreferences.");
  }
  return userId;
}


  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', userId);
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Supprime toutes les données sauvegardées
  }
}
