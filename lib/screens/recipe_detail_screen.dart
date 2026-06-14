import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String docId;
  final Map<String, dynamic> recipeData;
  final Set<String> favoritesRef;

  const RecipeDetailScreen({
    super.key,
    required this.docId,
    required this.recipeData,
    required this.favoritesRef,
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.favoritesRef.contains(widget.docId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeData['title'] ?? 'Recipe Details'),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
            onPressed: () {
              setState(() {
                if (isFavorite) {
                  widget.favoritesRef.remove(widget.docId);
                } else {
                  widget.favoritesRef.add(widget.docId);
                }
                isFavorite = !isFavorite;
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.recipeData['name'] ?? 'Untitled', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Category: ${widget.recipeData['category']}', style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16)),
            Text('Estimated Prep Time: ${widget.recipeData['prepTime']}', style: const TextStyle(fontSize: 16)),
            const Divider(height: 30),
            const Text('Ingredients', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
            const SizedBox(height: 8),
            Text(widget.recipeData['ingredients'] ?? '', style: const TextStyle(fontSize: 16, height: 1.5)),
            const Divider(height: 30),
            const Text('Instructions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
            const SizedBox(height: 8),
            Text(widget.recipeData['instructions'] ?? '', style: const TextStyle(fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }
}