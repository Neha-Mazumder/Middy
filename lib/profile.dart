import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'emoji.dart';

// Global profile image path holder
class ProfileImageStore {
  static String? imagePath;
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = true;
  String name = "Laiba Ahmar";
  String email = "youremail@domain.com";
  String phone = "+01 234 567 89";
  String selectedLanguage = "English";
  File? _profileImage;
  
  // ট্যাব ইনডেক্স ট্র্যাক করার জন্য
  int _selectedIndex = 4; // ডিফল্ট প্রোফাইল ট্যাব (৫ম পজিশন)

  final Map<String, Map<String, String>> _lang = {
    'English': {
      'edit_p': 'Edit Profile',
      'lang': 'Language',
      'theme': 'Theme',
      'help': 'Help & Support',
      'contact': 'Contact us',
      'privacy': 'Privacy policy',
      'edit_options': 'Edit Options',
      'change_pic': 'Change Profile Picture',
      'edit_name': 'Edit Name',
      'edit_email': 'Edit Email',
      'edit_phone': 'Edit Phone Number',
    },
    'Bangla': {
      'edit_p': 'প্রোফাইল এডিট',
      'lang': 'ভাষা',
      'theme': 'থিম',
      'help': 'সাহায্য ও সাপোর্ট',
      'contact': 'যোগাযোগ করুন',
      'privacy': 'গোপনীয়তা নীতি',
      'edit_options': 'এডিট অপশন',
      'change_pic': 'ছবি পরিবর্তন করুন',
      'edit_name': 'নাম পরিবর্তন',
      'edit_email': 'ইমেইল পরিবর্তন',
      'edit_phone': 'ফোন নম্বর পরিবর্তন',
    }
  };

  String t(String key) => _lang[selectedLanguage]![key]!;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
        ProfileImageStore.imagePath = image.path;
      });
    }
  }

  void _showEditOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(t('edit_options'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black)),
              const SizedBox(height: 20),
              _buildEditTile(Icons.camera_alt, t('change_pic'), () {
                Navigator.pop(context);
                _pickImage();
              }),
              _buildEditTile(Icons.person, t('edit_name'), () {
                Navigator.pop(context);
                _showEditDialog("Name", name, (val) => name = val);
              }),
              _buildEditTile(Icons.email, t('edit_email'), () {
                Navigator.pop(context);
                _showEditDialog("Email", email, (val) => email = val);
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEditTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title, style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
      onTap: onTap,
    );
  }

  void _showEditDialog(String title, String initialValue, Function(String) onSave) {
    TextEditingController controller = TextEditingController(text: initialValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update $title"),
        content: TextField(controller: controller, decoration: const InputDecoration(border: OutlineInputBorder())),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(onPressed: () {
            setState(() => onSave(controller.text));
            Navigator.pop(context);
          }, child: const Text("Save")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = isDarkMode ? const Color(0xFF121212) : const Color(0xFFF5F5F5);
    Color cardColor = isDarkMode ? const Color(0xFF1A1A1A) : Colors.white;
    Color textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 280),
                painter: HeaderPainter(color: isDarkMode ? const Color(0xFF262626) : Colors.blueGrey.shade100),
              ),
              Column(
                children: [
                  const SizedBox(height: 60),
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.orange,
                      child: CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.grey,
                        backgroundImage: _profileImage != null 
                          ? FileImage(_profileImage!) 
                          : const NetworkImage('https://i.pravatar.cc/150?img=5') as ImageProvider,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor)),
                  Text("$email | $phone", style: const TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildSection(cardColor, [
                  _buildMenuItem(Icons.edit_note, t('edit_p'), null, _showEditOptions, textColor),
                  _buildMenuItem(Icons.translate, t('lang'), selectedLanguage, () {
                    setState(() => selectedLanguage = selectedLanguage == "English" ? "Bangla" : "English");
                  }, textColor),
                ]),
                const SizedBox(height: 15),
                _buildSection(cardColor, [
                  _buildMenuItem(Icons.wb_sunny_outlined, t('theme'), isDarkMode ? "Dark" : "Light", () {
                    setState(() => isDarkMode = !isDarkMode);
                  }, textColor),
                ]),
                const SizedBox(height: 15),
                _buildSection(cardColor, [
                  _buildMenuItem(Icons.help_outline, t('help'), null, () => launchUrl(Uri.parse("https://google.com")), textColor),
                  _buildMenuItem(Icons.privacy_tip_outlined, t('privacy'), null, () => launchUrl(Uri.parse("https://pub.dev")), textColor),
                ]),
              ],
            ),
          ),
        ],
      ),
      
      // নিচের নেভিগেশন বার অংশ (আপডেটেড)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 0) {
            // Home এ ক্লিক করলে CheckInScreen (Emoji Page) এ নিয়ে যাবে
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CheckInScreen()),
            );
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: cardColor,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notification'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildSection(Color color, List<Widget> children) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
    child: Column(children: children),
  );

  Widget _buildMenuItem(IconData icon, String title, String? trailing, VoidCallback onTap, Color textColor) => ListTile(
    onTap: onTap,
    leading: Icon(icon, color: textColor),
    title: Text(title, style: TextStyle(color: textColor, fontSize: 15)),
    trailing: trailing != null 
        ? Text(trailing, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold))
        : Icon(Icons.arrow_forward_ios, size: 14, color: textColor.withOpacity(0.5)),
  );
}

class HeaderPainter extends CustomPainter {
  final Color color;
  HeaderPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 220, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}