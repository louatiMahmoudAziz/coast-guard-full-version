import 'package:flutter/material.dart';
import 'package:first_app/auth/changepwd.dart';
import 'mission_dashboard.dart';
import 'profile.dart'; // Ensure only necessary imports are included

class SettingsPage extends StatefulWidget {
  final String token;  // Assuming the token needs to be passed

  const SettingsPage({Key? key, required this.token}) : super(key: key); // Accept token in constructor

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        color: Colors.grey[300],
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              'Language',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlue),
            ),
            DropdownButton<String>(
              value: _selectedLanguage,
              items: <String>['English', 'Arabic', 'French'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Theme',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlue),
            ),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                );
              },
              color: Colors.lightBlue,
              textColor: Colors.white,
              child: const Text('Change Password', style: TextStyle(fontSize: 15)),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              color: Colors.red,
              textColor: Colors.white,
              child: const Text('Log Out', style: TextStyle(fontSize: 15)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,  // current index is 2 for SettingsPage
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MissionDashboard(token: widget.token)));
              break;
            case 1:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfilePage(token: widget.token)));
              break;
            case 2:
            // Already on Settings
              break;
          }
        },
        selectedItemColor: Colors.lightBlue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Missions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
