import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://localhost:3030/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String token = responseData['token'];
      // Store token and navigate to the next screen
      Navigator.pushNamed(context, '/mission_dashboard');
    } else {
      // Handle error...
      print('Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[300], // Consistent background color
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 60),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue[200], // Consistent logo background color
                ),
                width: 70,
                height: 70,
                padding: const EdgeInsets.all(10),
                child: const Image(
                  image: AssetImage("assets/logo.jpg"),
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Login',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.lightBlue), // Consistent text style
            ),
            const SizedBox(height: 10),
            const Text(
              'Login to continue using the app',
              style: TextStyle(fontSize: 16, color: Colors.lightBlue), // Consistent text style
            ),
            const SizedBox(height: 10),
            const Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlue), // Consistent text style
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter Your Email',
                hintStyle: const TextStyle(fontSize: 14),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Password',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlue), // Consistent text style
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter Your Password',
                hintStyle: const TextStyle(fontSize: 14),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(top: 15, bottom: 25),
              child: GestureDetector(
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 14, color: Colors.lightBlue), // Consistent text style
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/reset_pwd');
                },
              ),
            ),
            Center(
              child: MaterialButton(
                onPressed: login, // Call the login function
                height: 50,
                minWidth: 300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 300, // Set the width to match the Login button
                child: MaterialButton(
                  onPressed: () {
                    // Add your Google login functionality here
                  },
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login using Google    ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Image(
                        image: AssetImage("assets/google.png"),
                        width: 30,
                        height: 30,
                      ),
                    ],
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                child: const Text(
                  "Don't have an account? Register",
                  style: TextStyle(fontSize: 14, color: Colors.lightBlue), // Consistent text style
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/signup_page');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
