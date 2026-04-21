import 'package:flutter/material.dart';
import 'dart:io';
import 'settings_screen.dart';
import 'profile.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  int _currentIndex = 0; // বর্তমান ট্যাব ইনডেক্স

  @override
  Widget build(BuildContext context) {
    // যদি ৫ নম্বর (Profile) ট্যাব সিলেক্ট হয়, তবে ProfileScreen দেখাবে
    if (_currentIndex == 4) {
      return const ProfileScreen();
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F3F1), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // অ্যাপ বার সেকশন
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'SANCTUARY',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B4332),
                        letterSpacing: 1.2,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.settings_outlined, color: Color(0xFF1B4332)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SettingsScreen()),
                            );
                          },
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ProfileScreen()),
                            );
                          },
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.pinkAccent,
                            backgroundImage: ProfileImageStore.imagePath != null
                                ? FileImage(File(ProfileImageStore.imagePath!))
                                : null,
                            child: ProfileImageStore.imagePath == null
                                ? const Icon(Icons.person, color: Colors.white)
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              const Text(
                'CURRENT CHECK-IN',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF555555), letterSpacing: 1),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                child: Text(
                  'How are you feeling\nright now?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF2D2D2D)),
                ),
              ),

              const SizedBox(height: 50),

              // ইমোশন গ্রিড
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 25,
                    children: [
                      _buildEmotionCard(Icons.wb_sunny_rounded, 'HOPEFUL', const Color(0xFFE0F2F1), const Color(0xFF4DB6AC)),
                      _buildEmotionCard(Icons.cloud_rounded, 'TIRED', const Color(0xFFF3E5F5), const Color(0xFF7E57C2)),
                      _buildEmotionCard(Icons.back_hand_rounded, 'EMOTIONAL', const Color(0xFFFFF3E0), const Color(0xFF8D6E63)),
                      _buildEmotionCard(Icons.thunderstorm_rounded, 'FRUSTRATED', const Color(0xFFFFEBEE), const Color(0xFFD32F2F)),
                      _buildEmotionCard(Icons.eco_rounded, 'NORMAL', const Color(0xFFF1F8E9), const Color(0xFF689F38)),
                    ],
                  ),
                ),
              ),

              // স্টেপ ইন্ডিকেটর
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('● Step 1 of 3: Emotional Baseline', style: TextStyle(color: Colors.black54, fontSize: 13)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1B4332),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // ক্লিক করলে ইনডেক্স পরিবর্তন হবে
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.edit_note_rounded), label: 'Journal'),
          BottomNavigationBarItem(icon: Icon(Icons.sensors), label: 'Help'),
          BottomNavigationBarItem(icon: Icon(Icons.health_and_safety_outlined), label: 'Wellness'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildEmotionCard(IconData icon, String label, Color bgColor, Color iconColor) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(25)),
          child: Icon(icon, size: 40, color: iconColor),
        ),
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
      ],
    );
  }
}