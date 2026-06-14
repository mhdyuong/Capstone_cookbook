import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'recipe_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final Set<String> favorites;
  const FavoritesScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Saved Favorites'), backgroundColor: Colors.deepOrange),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorite recipes saved yet!'))
          : StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('recipes').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final favoriteDocs = snapshot.data!.docs.where((doc) => favorites.contains(doc.id)).toList();

          if (favoriteDocs.isEmpty) return const Center(child: Text('No favorite recipes saved yet!'));

          return ListView.builder(
            itemCount: favoriteDocs.length,
            itemBuilder: (context, index) {
              final doc = favoriteDocs[index];
              final data = doc.data() as Map<String, dynamic>;

              return ListTile(
                leading: const Icon(Icons.favorite, color: Colors.red),
                title: Text(data['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(data['category'] ?? ''),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailScreen(
                      docId: doc.id,
                      recipeData: data,
                      favoritesRef: favorites,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}