import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MissionDetails extends StatefulWidget {
  final String title;
  final String description;
  final String location;
  final String time;
  final String priority;
  final String imagePath;
  final String patrolId;  // Unique identifier for the patrol


  MissionDetails({
    required this.title,
    required this.description,
    required this.location,
    required this.time,
    required this.priority,
    required this.imagePath,
    required this.patrolId,

  });
  Map<String, String> emergencyTypeToImage = {
    'Ship Collision': 'ship_collision.jpg',
    'Grounding': 'grounding.jpg',
    'Flooding': 'flooding.jpg',
    'Fire': 'fire.jpg',
    'Man Overboard': 'man_overboard.jpg',
    'Machinery Failure': 'machinery_failure.jpg',
    'Piracy and Armed Attacks': 'piracy_and_armed_attacks.jpg',
    'Medical Emergency': 'medical_emergency.jpg',
    'Search and Rescue': 'search_and_rescue.jpg',
    'Adverse Weather Conditions': 'adverse_weather_conditions.jpg',
  };


  @override
  _MissionDetailsState createState() => _MissionDetailsState();
}

class _MissionDetailsState extends State<MissionDetails> {
  bool _hasStarted = false;
  bool _showReportForm = false;
  bool _missionFinished = false;
  final TextEditingController _reportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mission Details'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.imagePath, width: MediaQuery.of(context).size.width, fit: BoxFit.cover),  // Display the image at the top
            SizedBox(height: 20),
            Text(
              widget.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.lightBlue),
            ),
            SizedBox(height: 10),
            Text(
              widget.description,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            _infoSection(Icons.location_on, "Location", widget.location),
            _infoSection(Icons.access_time, "Time", widget.time),
            _infoSection(Icons.priority_high, "Priority", widget.priority),
            SizedBox(height: 20),
            _startButton(),
            if (_showReportForm) _buildReportForm(),
            if (_missionFinished) _missionFinishedText(),
          ],
        ),
      ),
    );
  }

  Widget _infoSection(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.lightBlue),
        SizedBox(width: 10),
        Text("$label: $value", style: TextStyle(fontSize: 16, color: Colors.lightBlue)),
      ],
    );
  }
  Future<void> updatePatrolStatus(String status) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:3030/api/patrols/update/${widget.patrolId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({'status': status}),
      );
      if (response.statusCode == 200) {
        print('Patrol status updated');
      } else {
        print('Failed to update patrol status');
      }
    } catch (e) {
      print('Error updating patrol status: $e');
    }
  }

  Widget _startButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (_hasStarted) {
              _showReportForm = true;
              updatePatrolStatus('standby');
            } else {
              _hasStarted = true;
              updatePatrolStatus('on_mission');
            }
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _hasStarted ? Colors.green : Colors.lightBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          minimumSize: Size(200, 50),
        ),
        child: Text(_hasStarted ? 'Mark as Complete' : 'Start'),
      ),
    );
  }

  Widget _buildReportForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Report', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlue)),
        SizedBox(height: 10),
        TextFormField(
          controller: _reportController,
          decoration: InputDecoration(
            labelText: 'Enter your report',
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          maxLines: 4,
        ),
        SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              print('Report submitted: ${_reportController.text}');
              setState(() {
                _showReportForm = false;
                _hasStarted = false;
                _missionFinished = true;
                _reportController.clear();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              minimumSize: Size(200, 50),
            ),
            child: Text('Submit'),
          ),
        ),
      ],
    );
  }

  Widget _missionFinishedText() {
    return Center(
      child: Text(
        'Mission Finished',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.lightBlue),
      ),
    );
  }
}
