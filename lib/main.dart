import 'package:flutter/material.dart';
// import 'emoji.dart'; // Removed unused import
import 'home_page.dart';

void main() {
  runApp(const SanctuaryApp());
}

class SanctuaryApp extends StatelessWidget {
  const SanctuaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Middy App',
      theme: ThemeData(fontFamily: 'sans-serif', useMaterial3: true),
      // HomePage ফাইলটি এখানে কল করা হয়েছে
      home: const HomePage(),
    );
  }
}
