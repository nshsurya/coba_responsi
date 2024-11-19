import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> meals = [];

  @override
  void initState() {
    super.initState();
    _fetchMeals();
  }

  Future<void> _fetchMeals() async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s='));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        meals = data['meals'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Resep Makanan'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: meals.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                final isFavorite = favoritesProvider.isFavorite(meal);

                return ListTile(
                  leading: Image.network(meal['strMealThumb']),
                  title: Text(meal['strMeal']),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      if (isFavorite) {
                        favoritesProvider.removeFavorite(meal);
                      } else {
                        favoritesProvider.addFavorite(meal);
                      }
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: meal,
                    );
                  },
                );
              },
            ),
    );
  }
}
