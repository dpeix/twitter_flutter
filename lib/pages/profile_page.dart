import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late Future<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    _userData = fetchUserData();
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    const String apiUrl = 'https://std30.beaupeyrat.com/api/users';
    const String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE3MzY1MDM1OTcsImV4cCI6MTczNjUwNzE5Nywicm9sZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6ImFkbWluIn0.VjsNUoG4iNm8xCO7sm_kVW-Bz1D75efNO-1hFot9aPl8_OtuWmnFiFqZFitWCdb5wUhetspQ-wr2ejhhk34GR2cHVc62CMKXPYvOskC6r2wfIDnMsjg--yUbiWCawzK-bDudWFkmfPGWG6msplIHeRceEGY_n0Y05mMGfLZJvqjEpeWfz8qQQRGd4LbE4zecjUaGADfQ2XwNL5gvUNhI1y2MmlAnQ_Imtt_yTUtrtaqdAukHKJtAQHgxcIVrijescMZJvH46EzrrAe2gLd8dbxHYqntTtrntHLqJ-YJXH5qCL5G0yDgvXN9Q_gc_HsMN9iDhYaQxiqXu6ZBJ17kRkA'; // Remplacez par votre méthode d'obtention du token

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erreur lors du chargement des données utilisateur');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil utilisateur'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else {
            final user = snapshot.data!;
            final tweets = user['tweets'] as List<dynamic>;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Informations utilisateur
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage(user['avatar_url'] ?? 'https://via.placeholder.com/150'),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user['name'] ?? 'Nom d\'utilisateur',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '@${user['username'] ?? ''}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Tweets',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    // Liste des tweets
                    ...tweets.map((tweet) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(tweet['content']),
                          subtitle: Text(
                            'Créé le : ${tweet['createdAt']} - ${tweet['likes']} Likes - ${tweet['retweets']} Retweets',
                          ),
                          trailing: tweet['state'] == 'active'
                              ? const Icon(Icons.check_circle, color: Colors.green)
                              : const Icon(Icons.cancel, color: Colors.red),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
