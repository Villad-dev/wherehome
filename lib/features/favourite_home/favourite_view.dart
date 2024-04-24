import 'package:flutter/material.dart';

import '../../data/models/home.dart';


class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  static List<Home> favoriteHomes = [
    Home('ul. Piotrokowska', '2', 'Warsaw', 4000.0, 45.0, 2,
        "assets/images/img2.jpg"),
    Home(
        'ul. Bohaterska', '5', 'Warsaw', 2450, 45, 2, "assets/images/img2.jpg"),
    Home('ul. Kaminskiego', '40', 'Poznan', 4650, 45, 2,
        "assets/images/img1.jpg"),
    // Add more favorite homes as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoriteHomes.length,
        itemBuilder: (context, index) {
          final home = favoriteHomes[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(home.imagePath),
            ),
            title: Text(home.address),
            subtitle: Text(home.address_num),
            // Add functionality to view details of the favorite home
            onTap: () {
              // Implement navigation to view details of the selected home
            },
            // Add functionality to remove the home from favorites
            trailing: IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                // Implement functionality to remove the home from favorites
              },
            ),
          );
        },
      ),
    );
  }
}
