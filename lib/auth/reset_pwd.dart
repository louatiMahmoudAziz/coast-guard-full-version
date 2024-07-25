import 'package:flutter/material.dart';

class Reset extends StatefulWidget {
  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
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
              'Reset Password',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Enter your email to receive a password reset link'),
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
            const SizedBox(height: 30),
            Center(
              child: MaterialButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Password Reset'),
                        content: const Text(
                            'We have sent a new password to your email.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                height: 50,
                minWidth: 300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Reset',
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
