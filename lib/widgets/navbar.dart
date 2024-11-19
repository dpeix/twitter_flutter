import 'package:flutter/material.dart';
import '../pages/profile_page.dart'; // Importez la page de profil
import '../pages/home_page.dart'; // Importez la page d'accueil (ajoutez cette ligne si elle n'est pas déjà importée)

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
          icon: Icon(Icons.more_horiz, color: Colors.grey),
          label: 'More',
        ),
      ],
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: (index) {
        if (index == 0) {
          // Si l'élément "Home" est sélectionné (index 0)
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const TwitterHomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(
                    1.0, 0.0); // Transition horizontale (de droite à gauche)
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            ),
          );
        } else if (index == 4) {
          // Si l'élément "Profile" est sélectionné (index 4)
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const TwitterProfilePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(
                    1.0, 0.0); // Transition horizontale (de droite à gauche)
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
