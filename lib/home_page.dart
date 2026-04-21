import 'package:flutter/material.dart';
import 'profile.dart';
import 'emoji.dart';
import 'settings_screen.dart';
import 'todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isDarkTheme = false;

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
    // Optionally, you can use a callback or provider to update the app theme globally
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _HomeContent(
        onSettingsTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsScreen()),
          );
        },
        onMoodCheckTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CheckInScreen()),
          );
        },
      ),
      Center(child: Text('Todo List', style: TextStyle(fontSize: 24))),
    ];

    return Theme(
      data: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: const Text('Middy Home'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(_isDarkTheme ? Icons.light_mode : Icons.dark_mode),
              tooltip: 'Toggle Theme',
              onPressed: _toggleTheme,
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _isDarkTheme
                  ? [Colors.indigo.shade900, Colors.black]
                  : [
                      Colors.cyan.shade100,
                      Colors.pink.shade50,
                      Colors.yellow.shade100,
                    ],
            ),
          ),
          child: SafeArea(child: _pages[_selectedIndex]),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: _isDarkTheme
                ? Colors.black.withOpacity(0.8)
                : Colors.white.withOpacity(0.9),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Colors.purple,
            unselectedItemColor: Colors.grey,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_box),
                label: 'Todo',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final VoidCallback onSettingsTap;
  final VoidCallback onMoodCheckTap;

  const _HomeContent({
    required this.onSettingsTap,
    required this.onMoodCheckTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _FeatureCard(
            icon: Icons.emoji_emotions,
            title: 'Daily Mood Check',
            onTap: onMoodCheckTap,
            color: Colors.orange.shade100,
          ),
          _FeatureCard(
            icon: Icons.book,
            title: 'Journal',
            onTap: () {},
            color: Colors.pink.shade100,
          ),
          _FeatureCard(
            icon: Icons.chat,
            title: 'Chatbot',
            onTap: () {},
            color: Colors.blue.shade100,
          ),
          _FeatureCard(
            icon: Icons.fitness_center,
            title: 'Exercise Animation',
            onTap: () {},
            color: Colors.green.shade100,
          ),
          _FeatureCard(
            icon: Icons.check_box,
            title: 'Todo List',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TodoApp()),
              );
            },
            color: Colors.purple.shade100,
          ),
          _FeatureCard(
            icon: Icons.alarm,
            title: 'Alarm',
            onTap: () {},
            color: Colors.yellow.shade100,
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color color;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 4,
      color: color,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(icon, size: 28, color: Colors.black87),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
