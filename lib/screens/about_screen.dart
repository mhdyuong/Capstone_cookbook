import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Developer'), backgroundColor: Colors.deepOrange),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.menu_book_sharp, size: 80, color: Colors.deepOrange),
              const SizedBox(height: 16),
              const Text('Digital Text Cookbook', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const Text('Version 1.0.0', style: TextStyle(color: Colors.grey)),
              const Divider(height: 40),
              const Text(
                'This application functions as a zero-authentication collaborative digital cookbook layout. All recipes are updated globally via an optimized NoSQL Firestore cloud database.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const Spacer(),
              const Text('Created for Capstone Milestone Requirements', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}