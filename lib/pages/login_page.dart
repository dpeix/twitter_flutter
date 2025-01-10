import 'package:flutter/material.dart';
import 'package:twitter_flutter/pages/home_page.dart';
import '../services/api_service.dart';
import '../services/token_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final bool _isLoading = false;
  String? _token; // Variable to store and display the token

  Future<void> _login() async {
    final token = await ApiService.fetchToken(
      _usernameController.text,
      _passwordController.text,
    );

    if (token != null) {
      await TokenService.saveToken(token);
      setState(() {
        _token = token;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DataScreen()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Connexion réussie !')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur de connexion.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo
            const Center(
              child: Icon(
                FontAwesomeIcons.twitter,
                color: Colors.blue,
                size: 80,
              ),
            ),
            const SizedBox(height: 50),

            const Text(
              "Connectez-vous à votre compte",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Nom d'utilisateur",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Mot de passe",
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),

            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Se connecter",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
            const SizedBox(height: 20),

            TextButton(
              onPressed: () {},
              child: const Text(
                "Mot de passe oublié ?",
                style: TextStyle(color: Colors.blue),
              ),
            ),

            // Display token conditionally
            if (_token != null)
              Text(
                "Token: $_token",
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}