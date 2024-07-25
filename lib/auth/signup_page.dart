import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[300],
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 60),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue[200],
                ),
                width: 70,
                height: 70,
                padding: const EdgeInsets.all(10),
                child: const Image(
                  image: AssetImage("assets/logo.jpg"), // Ensure the logo path is correct
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Create an account to continue using the app'),
            const SizedBox(height: 10),
            const Text(
              'Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter Your Name',
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
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
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
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
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
                  'Already have an account? Login',
                  style: TextStyle(fontSize: 14),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ),
            Center(
              child: MaterialButton(
                onPressed: () {
                  // Add your sign-up functionality here
                },
                height: 50,
                minWidth: 300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
