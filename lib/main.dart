import 'package:flutter/material.dart';
import 'auth/login.dart';
import 'auth/reset_pwd.dart';
import 'auth/signup_page.dart';
import 'mission_dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SeaSOS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/mission_dashboard': (context) => MissionDashboard(),
        '/reset_pwd': (context) => ResetPwd(),
        '/signup_page': (context) => SignupPage(),
      },
    );
  }
}
