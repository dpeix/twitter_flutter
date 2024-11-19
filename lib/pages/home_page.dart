import 'package:flutter/material.dart';
import '../widgets/navbar.dart'; 
import '../widgets/tweet_card.dart';
import '../widgets/header.dart';

class TwitterHomePage extends StatelessWidget {
  const TwitterHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return const TweetCard();
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
