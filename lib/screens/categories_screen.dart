import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'recipe_detail_screen.dart';
import '../main.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  final List<String> categories = const ['Baking', 'Dinner', 'Breakfast', 'Snacks', 'Desserts'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories'), backgroundColor: Colors.deepOrange),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ExpansionTile(
              title: Text(cat, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: const Icon(Icons.label, color: Colors.deepOrange),
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('recipes').where('category', isEqualTo: cat).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator());
                    final docs = snapshot.data!.docs;
                    if (docs.isEmpty) return const Padding(padding: EdgeInsets.all(12.0), child: Text('No recipes in this category yet.'));

                    return Column(
                      children: docs.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        return ListTile(
                          title: Text(data['name'] ?? ''),
                          subtitle: Text(data['prepTime'] ?? ''),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetailScreen(
                                docId: doc.id,
                                recipeData: data,
                                favoritesRef: MainNavigationHolder.favoriteRecipeIds,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}