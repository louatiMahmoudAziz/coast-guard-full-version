import 'package:flutter/material.dart';

class MissionDetails extends StatefulWidget {
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
      body: Container(
        color: Colors.grey[300],
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.lightBlue),
            ),
            const SizedBox(height: 10),
            Text(
              widget.description,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.lightBlue),
                const SizedBox(width: 10),
                Text(
                  widget.location,
                  style: TextStyle(fontSize: 16, color: Colors.lightBlue),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.lightBlue),
                const SizedBox(width: 10),
                Text(
                  widget.time,
                  style: TextStyle(fontSize: 16, color: Colors.lightBlue),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.priority_high, color: Colors.lightBlue),
                const SizedBox(width: 10),
                Text(
                  'Priority: ${widget.priority}',
                  style: TextStyle(fontSize: 16, color: Colors.lightBlue),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (!_missionFinished)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_hasStarted) {
                        _showReportForm = true;
                      } else {
                        _hasStarted = true;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _hasStarted ? Colors.green : Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(200, 50),
                  ),
                  child: Text(_hasStarted ? 'Mark as Complete' : 'Start'),
                ),
              ),
            const SizedBox(height: 20),
            if (_showReportForm) _buildReportForm(),
            if (_missionFinished)
              Center(
                child: Text(
                  'Mission Finished',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Report',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlue),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _reportController,
          decoration: InputDecoration(
            labelText: 'Enter your report',
            hintText: 'Detailed description of the task',
            hintStyle: const TextStyle(fontSize: 14),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          maxLines: 4,
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Implement the submit action here
              // For example, you can print the report to the console or send it to the backend
              print('Report submitted: ${_reportController.text}');
              setState(() {
                _showReportForm = false;
                _hasStarted = false;
                _missionFinished = true; // Set mission as finished
                _reportController.clear();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minimumSize: Size(200, 50),
            ),
            child: Text('Submit'),
          ),
        ),
      ],
    );
  }
}
