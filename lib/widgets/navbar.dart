import 'package:flutter/material.dart';
import '../pages/profile_page.dart'; // Page de profil
import '../pages/home_page.dart'; // Page d'accueil
import '../pages/login_page.dart'; // Page de login

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.blue),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, color: Colors.grey),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications, color: Colors.grey),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mail_outline, color: Colors.grey),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.perm_identity, color: Colors.grey),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.login, color: Colors.grey), // Icône de login
          label: 'Login',
        ),
      ],
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: (index) {
        Widget? targetPage;

        switch (index) {
          case 0:
            targetPage = const TwitterHomePage();
            break;
          case 4:
            targetPage = const TwitterProfilePage();
            break;
          case 5:
            targetPage = const LoginPage(); // Naviguer vers la page de login
            break;
        }

        if (targetPage != null) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  targetPage!,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0); // De droite à gauche
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            ),
          );
        }
      },
    );
  }
}
