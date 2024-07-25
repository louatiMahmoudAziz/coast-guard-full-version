import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                  image: AssetImage("assets/logo.jpg"),
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Login',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Login to continue using the app'),
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
                  'Forgot Password?',
                  style: TextStyle(fontSize: 14),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/reset_pwd');
                },
              ),
            ),
            Center(
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/mission_dashboard'); // Navigate to the Mission Dashboard page
                },
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
              child: MaterialButton(
                onPressed: () {
                  // Add your Google login functionality here
                },
                height: 50,
                minWidth: 300,
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
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                child: const Text("Don't have an account? Register"),
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
