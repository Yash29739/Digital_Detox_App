import 'package:digital_detox/LogIn-SignUp/Services/authentication.dart';
import 'package:digital_detox/LogIn-SignUp/screens/login.dart';
import 'package:flutter/material.dart';

import '../widgets/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Digital Detox'),
        backgroundColor: Colors.teal, // A calming color for detox
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Take a break your screen',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Embrace mindfulness and reconnect with the world around you.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              MyButtons(onTap: () async {
                await AuthMethod().signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const LoginScreen(),),);
              },text: "Log-Out",)
            ],

          ),
        ),
      ),
    );
  }
}
