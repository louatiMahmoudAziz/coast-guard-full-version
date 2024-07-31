import 'package:flutter/material.dart';
import 'package:first_app/auth/changepwd.dart'; // Import the new ChangePasswordPage

class SettingsPage extends StatefulWidget {
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
        backgroundColor: Colors.lightBlue, // Consistent AppBar color
      ),
      body: Container(
        color: Colors.grey[300], // Consistent background color
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Language',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlue), // Consistent text style
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlue), // Consistent text style
            ),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value;
                });
                // Update the theme here if needed
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Change Password',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlue), // Consistent text style
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                );
              },
              height: 50,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.lightBlue,
              textColor: Colors.white,
              child: const Text(
                'Change Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                // Implement log out functionality or navigate to the login page
                Navigator.pushReplacementNamed(context, '/login');
              },
              height: 50,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.red,
              textColor: Colors.white,
              child: const Text(
                'Log Out',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
