import 'package:flutter/material.dart';
import 'mission_details.dart';
import 'SettingsPage.dart';
import 'profile.dart';

class MissionDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mission Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        color: Colors.grey[300],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for a mission',
                hintStyle: TextStyle(fontSize: 14),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ToggleButtons(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('All'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('High'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Medium'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Low'),
                ),
              ],
              isSelected: [true, false, false, false],
              onPressed: (int index) {
                // Handle toggle button selection
              },
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.directions_boat, color: Colors.lightBlue),
                title: Text('Rescue Mission'),
                subtitle: Text('Injured fisher needs assistance'),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MissionDetails(
                          title: 'Search and rescue mission for a boat with 6 passengers',
                          description: 'The boat is reported to be in the area of 37.82N, 122.49W. The weather is clear with waves of 1-3 ft.',
                          location: '37.82N, 122.49W',
                          time: 'Starts in 30 minutes',
                          priority: 'High',
                        ),
                      ),
                    );
                  },
                  child: Text('Details'),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          switch (index) {
            case 0:
              // Stay on current page
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
              break;
          }
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey[700],
        items: const <BottomNavigationBarItem>[
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
