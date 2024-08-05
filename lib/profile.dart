import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'mission_dashboard.dart';
import 'SettingsPage.dart'; // Make sure to have the correct imports for navigation

class ProfilePage extends StatefulWidget {
  final String token;

  const ProfilePage({Key? key, required this.token}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;
  Map<String, dynamic>? profileData;
  List<dynamic>? patrols = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:3030/api/patrols/supervisor/patrols'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          profileData = data[0]['supervisor'];
          patrols = data ?? [];
          isLoading = false;
        });
      } else {
        print('Failed to load profile data: ${response.body}');
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Error fetching profile data: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> _pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : profileData == null
          ? Center(child: Text('Failed to load profile data'))
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : AssetImage('assets/profile.png') as ImageProvider,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _pickImageFromCamera,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                child: Text('Update Profile Picture'),
              ),
            ),
            Divider(),
            Card(
              margin: EdgeInsets.all(8),
              elevation: 4,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.account_circle, color: Colors.lightBlue),
                    title: Text('Name'),
                    subtitle: Text('${profileData!['name']}'),
                  ),
                  ListTile(
                    leading: Icon(Icons.email, color: Colors.lightBlue),
                    title: Text('Email'),
                    subtitle: Text('${profileData!['email']}'),
                  ),
                  ListTile(
                    leading: Icon(Icons.security, color: Colors.lightBlue),
                    title: Text('Rank'),
                    subtitle: Text('${profileData!['rank']}'),
                  ),
                  ListTile(
                    leading: Icon(Icons.group, color: Colors.lightBlue),
                    title: Text('Team Members'),
                    subtitle: Text(patrols!.isNotEmpty && patrols![0]['teamMembers'] != null ? patrols![0]['teamMembers'].join(', ') : 'No team members'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Index 1 for ProfilePage
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MissionDashboard(token: widget.token)));
              break;
            case 1:
            // Current page
              break;
            case 2:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SettingsPage(token: widget.token)));
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
