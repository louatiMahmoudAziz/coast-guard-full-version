import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile; // Variable to store the selected image
  Map<String, dynamic>? profileData; // Variable to store fetched profile data
  List<dynamic>? patrols; // Variable to store fetched patrols data
  bool isLoading = true; // Variable to indicate loading state
  String? token; // Variable to store the JWT token

  @override
  void initState() {
    super.initState();
    fetchToken(); // Fetch token when the page is initialized
  }

  // Function to fetch the token
  Future<void> fetchToken() async {
    print('Fetching token...');
    // Simulate fetching token. Replace with actual implementation
    final response = await http.post(
      Uri.parse('http://localhost:3030/api/auth/login'), // Adjust to your login endpoint
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': 'supervisor@example.com', // Replace with actual supervisor email
        'password': 'password123', // Replace with actual password
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      setState(() {
        token = responseData['token'];
        print('Token fetched: $token');
        fetchProfileData();
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Failed to fetch token: ${response.body}');
    }
  }

  // Function to fetch profile data from the backend
  Future<void> fetchProfileData() async {
    if (token == null) return;

    print('Fetching profile data...');
    final response = await http.get(
      Uri.parse('http://localhost:3030/api/patrols/supervisor/patrols'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token', // Use the valid JWT token
      },
    );

    print('Profile data response status: ${response.statusCode}');
    print('Profile data response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        profileData = data['supervisor'];
        patrols = data['patrols'];
        isLoading = false;
        print('Profile data fetched successfully');
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Failed to load profile data: ${response.body}');
    }
  }

  // Function to pick an image from gallery
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  // Function to pick an image from camera
  Future<void> _pickImageFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

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
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue, // Consistent AppBar color
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator while fetching data
          : profileData == null
          ? Center(child: Text('Failed to load profile data')) // Show error message if data fetch fails
          : Container(
        color: Colors.grey[300], // Consistent background color
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Image Section
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : AssetImage('assets/profile.png') as ImageProvider,
                      backgroundColor: Colors.grey[200], // Consistent background color
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // Show bottom sheet to pick image
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.camera_alt, color: Colors.lightBlue),
                                    title: Text('Take a Photo'),
                                    onTap: () {
                                      _pickImageFromCamera();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.photo, color: Colors.lightBlue),
                                    title: Text('Choose from Gallery'),
                                    onTap: () {
                                      _pickImage();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.lightBlue,
                          child: Icon(Icons.edit, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Supervisor Name
                Text(
                  profileData!['name'],
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),
                const SizedBox(height: 10),
                // Supervisor Email
                Text(
                  profileData!['email'],
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[700], // Adjusted for better readability
                  ),
                ),
                const SizedBox(height: 10),
                // Supervisor Rank
                Text(
                  'Rank: ${profileData!['rank']}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[700], // Adjusted for better readability
                  ),
                ),
                const SizedBox(height: 30),
                // Patrols Section
                Text(
                  'Assigned Patrols',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),
                const SizedBox(height: 10),
                // List of Patrols
                ListView.builder(
                  shrinkWrap: true, // Use shrinkWrap to fit content height
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling in ListView
                  itemCount: patrols?.length ?? 0,
                  itemBuilder: (context, index) {
                    final patrol = patrols![index];
                    return Card(
                      child: ListTile(
                        title: Text('Patrol ID: ${patrol['_id']}'),
                        subtitle: Text('Status: ${patrol['status']}'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                // Mission History Button
                MaterialButton(
                  onPressed: () {
                    // Navigate to Mission History Page
                  },
                  height: 50,
                  minWidth: 300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  child: const Text(
                    'Mission History',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
