import 'package:flutter/material.dart';
import 'emoji.dart'; // emoji.dart ফাইলটি কানেক্ট করা হলো

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
      theme: ThemeData(
        fontFamily: 'sans-serif',
        useMaterial3: true,
      ),
      // emoji.dart ফাইলে থাকা ক্লাসটি এখানে কল করা হয়েছে
      home: const CheckInScreen(), 
    );
  }
}