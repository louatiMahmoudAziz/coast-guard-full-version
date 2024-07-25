import 'package:flutter/material.dart';

class MissionDetails extends StatelessWidget {
  final String title;
  final String description;
  final String location;
  final String time;
  final String priority;

  MissionDetails({
    required this.title,
    required this.description,
    required this.location,
    required this.time,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mission 0012'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  location,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  time,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.priority_high, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  'Priority: $priority',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Start'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Mark as Complete'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Cancel'),
            ),
            const SizedBox(height: 20),
            Text(
              'Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              title: Text('Check weather report'),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('Prepare equipment'),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('Brief team'),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('Launch boat'),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('Report back'),
              value: false,
              onChanged: (bool? value) {},
            ),
          ],
        ),
      ),
    );
  }
}
