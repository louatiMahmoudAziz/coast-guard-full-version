import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/auth/login.dart';
import 'package:first_app/auth/signup_page.dart';
import 'package:first_app/auth/reset_pwd.dart';
import 'package:first_app/mission_dashboard.dart';
import 'package:first_app/mission_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/signup_page': (context) => SignUpPage(),
        '/reset_pwd': (context) => Reset(),
        '/mission_dashboard': (context) => MissionDashboard(),
        '/mission_details': (context) => MissionDetails(
              title: 'Search and rescue mission for a boat with 6 passengers',
              description: 'The boat is reported to be in the area of 37.82N, 122.49W. The weather is clear with waves of 1-3 ft.',
              location: '37.82N, 122.49W',
              time: 'Starts in 30 minutes',
              priority: 'High',
            ),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
