import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _timeController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();
  String _selectedCategory = 'Baking';

  final List<String> _categories = ['Baking', 'Dinner', 'Breakfast', 'Snacks', 'Desserts'];

  void _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('recipes').add({
        'name': _titleController.text.trim(),
        'prepTime': _timeController.text.trim(),
        'category': _selectedCategory,
        'ingredients': _ingredientsController.text.trim(),
        'instructions': _instructionsController.text.trim(),
      });
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Recipe Saved!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Recipe')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Recipe Title', border: OutlineInputBorder()),
              validator: (v) => v!.isEmpty ? 'Enter a title' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _timeController,
              decoration: const InputDecoration(labelText: 'Prep Time (e.g. 30 mins)', border: OutlineInputBorder()),
              validator: (v) => v!.isEmpty ? 'Enter prep time' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) => setState(() => _selectedCategory = val!),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _ingredientsController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Ingredients (One per line)', border: OutlineInputBorder()),
              validator: (v) => v!.isEmpty ? 'Enter ingredients' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _instructionsController,
              maxLines: 8,
              decoration: const InputDecoration(labelText: 'Instructions / Steps', border: OutlineInputBorder()),
              validator: (v) => v!.isEmpty ? 'Enter processing steps' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14)),
              onPressed: _saveRecipe,
              child: const Text('Save Recipe to Firestore', style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}