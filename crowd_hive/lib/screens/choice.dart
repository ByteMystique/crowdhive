import 'package:crowd_hive/screens/complogin.dart';
import 'package:flutter/material.dart';
import 'package:crowd_hive/components/my_button.dart';
import 'package:crowd_hive/screens/welcome.dart'; // Import the LoginPage

class ChoicePage extends StatelessWidget {
  const ChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // Title
                Text(
                  "I'm",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),

                const SizedBox(height: 50),

                // Buttons horizontally placed
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Contributor Button
                      Expanded(
                        child: MyButton(
                          onTap: () {
                            // Navigate to LoginPage for Contributor
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          buttonText: "Contributor",
                        ),
                      ),

                      const SizedBox(width: 20), // Space between buttons

                      // Fundraiser Button
                      Expanded(
                        child: MyButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPageC(),
                              ),
                            ); // Replace with navigation if needed
                          },
                          buttonText: "Fundraiser",
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
