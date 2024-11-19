import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorit'),
      ),
      body: favoritesProvider.favorites.isEmpty
          ? Center(child: Text('Belum ada menu favorit.'))
          : ListView.builder(
              itemCount: favoritesProvider.favorites.length,
              itemBuilder: (context, index) {
                final meal = favoritesProvider.favorites[index];
                return ListTile(
                  leading: Image.network(meal['strMealThumb']),
                  title: Text(meal['strMeal']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      favoritesProvider.removeFavorite(meal);
                    },
                  ),
                );
              },
            ),
    );
  }
}
