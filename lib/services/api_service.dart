import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<String?> fetchToken(String username, String password) async {
    final url = Uri.parse('https://std30.beaupeyrat.com/auth');

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'username': username,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 10));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['token'] != null) {
          print('Token reçu: ${data['token']}');
          return data['token'];
        } else {
          print('Erreur: Champ "token" absent ou réponse mal formée.');
          return null;
        }
      } else {
        print(
          'Erreur: Code de statut inattendu (${response.statusCode}).',
        );
        return null;
      }
    } on http.ClientException catch (e) {
      print('Erreur réseau (ClientException): $e');
      return null;
    } on TimeoutException {
      print('Erreur: Temps de requête dépassé.');
      return null;
    } on FormatException {
      print('Erreur: Réponse JSON mal formée.');
      return null;
    } catch (e) {
      print('Erreur inattendue: $e');
      return null;
    }
  }

  static Future<List<dynamic>> fetchData(String token) async {
    final url = Uri.parse(
        'https://std30.beaupeyrat.com/api/tweets'); // Vérifiez l'URL complète
    List<dynamic> allTweets = [];
    int page = 1;
    int limit = 30; // Nombre de résultats par page
    bool hasMore = true;

    while (hasMore) {
      final response = await http.get(
        url.replace(queryParameters: {
          'page': page.toString(),
          'limit': limit.toString(),
        }),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print(
          'Réponse brute: ${response.body}'); // Affiche la réponse JSON brute pour vérifier

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print(
            'Réponse JSON décodée: $jsonResponse'); // Affiche la réponse JSON décodée

        // Vérifiez si la clé "member" existe et contient les tweets
        if (jsonResponse is Map && jsonResponse.containsKey('member')) {
          final tweets = jsonResponse['member'] as List<dynamic>;
          allTweets.addAll(tweets);
          hasMore = tweets.length == limit; // Continue si la page est pleine
          page++;
        } else {
          throw Exception(
              'Format de réponse inattendu : clé "member" manquante');
        }
      } else {
        throw Exception(
            'Erreur de récupération des tweets: ${response.statusCode}');
      }
    }
    print('Tous les tweets récupérés: $allTweets'); // Affiche tous les tweets récupérés
      return allTweets;
  }
}
