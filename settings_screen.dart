
import 'package:flutter/material.dart';
import 'profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.green.shade900,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('Account & Security'),
          _settingsTile(
            context,
            icon: Icons.person,
            title: 'Edit Profile',
            subtitle: 'Change name, email, and profile picture.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          _settingsTile(
            context,
            icon: Icons.lock_outline,
            title: 'Security',
            subtitle: 'Update password and enable Biometric Lock.',
            onTap: () {},
          ),
          _settingsTile(
            context,
            icon: Icons.link,
            title: 'Linked Accounts',
            subtitle: 'Manage connections with Google or Facebook.',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          _sectionTitle('Wellness & Personalization'),
          _settingsTile(
            context,
            icon: Icons.alarm,
            title: 'Daily Reminders',
            subtitle: 'Set times for mood check-in notifications.',
            onTap: () {},
          ),
          _settingsTile(
            context,
            icon: Icons.download,
            title: 'Data Export',
            subtitle: 'Download your monthly mood history.',
            onTap: () {},
          ),
          _settingsTile(
            context,
            icon: Icons.lock,
            title: 'Journal Privacy',
            subtitle: 'Lock your notes and journals with a passcode.',
            onTap: () {},
          ),
          _settingsTile(
            context,
            icon: Icons.music_note,
            title: 'Exercise Settings',
            subtitle: 'Customize music and timers for exercises.',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          _sectionTitle('App Preferences'),
          _settingsTile(
            context,
            icon: Icons.brightness_6,
            title: 'Theme',
            subtitle: 'Light, Dark, or System Default.',
            onTap: () {},
          ),
          _settingsTile(
            context,
            icon: Icons.language,
            title: 'Language',
            subtitle: 'Switch between English and Bangla.',
            onTap: () {},
          ),
          _settingsTile(
            context,
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Manage sound, vibration, and alerts.',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          _sectionTitle('Support & Legal'),
          _settingsTile(
            context,
            icon: Icons.help_outline,
            title: 'Help Center',
            subtitle: 'FAQs and Contact Us.',
            onTap: () {},
          ),
          _settingsTile(
            context,
            icon: Icons.privacy_tip,
            title: 'Legal',
            subtitle: 'Privacy Policy and Terms of Service.',
            onTap: () {},
          ),
          _settingsTile(
            context,
            icon: Icons.info_outline,
            title: 'App Info',
            subtitle: 'Check for updates and version details.',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          _sectionTitle('Danger Zone'),
          _settingsTile(
            context,
            icon: Icons.logout,
            title: 'Log Out',
            subtitle: 'Sign out from the current device.',
            onTap: () {},
            color: Colors.red,
          ),
          _settingsTile(
            context,
            icon: Icons.delete_forever,
            title: 'Delete Account',
            subtitle: 'Permanently remove all data and account.',
            onTap: () {},
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      );

  Widget _settingsTile(BuildContext context, {required IconData icon, required String title, String? subtitle, VoidCallback? onTap, Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.green.shade900),
      title: Text(title, style: TextStyle(color: color ?? Colors.black)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      onTap: onTap,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
