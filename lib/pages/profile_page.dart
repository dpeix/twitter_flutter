import 'package:flutter/material.dart';
import '../widgets/tweet_card.dart'; 
import '../widgets/header.dart'; 
import '../widgets/navbar.dart'; 

class TwitterProfilePage extends StatelessWidget {
  const TwitterProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          // Bannière + photo de profil
          Stack(
            children: [
              Container(
                height: 150,
                color: Colors.blue,
              ),
              const Positioned(
                bottom: -25,
                left: 20,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 37,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'), // Image de profil
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          // Informations utilisateur
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Username",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 5),
                const Text(
                  "@username",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                const SizedBox(height: 10),
                const Text(
                  "This is a bio section. Add some details about yourself here.",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 15),
                const Row(
                  children: [
                    Text(
                      "123 ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text("Following"),
                    SizedBox(width: 20),
                    Text(
                      "456 ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text("Followers"),
                  ],
                ),
                const SizedBox(height: 15),
                // Boutons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.blue),
                        ),
                        child: const Text(
                          "Follow",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Icon(Icons.more_horiz, color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          // Liste de tweets
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const TweetCard(); // Utilisez le TweetCard pour afficher les tweets
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          const CustomBottomNavigationBar(), // Ajoutez votre barre de navigation en bas
    );
  }
}
