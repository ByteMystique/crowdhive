import 'package:crowd_hive/components/my_button.dart';
import 'package:crowd_hive/api_service.dart';
import 'package:crowd_hive/screens/welcome.dart'; // Import your Login Page
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // Sign up method
  void signUserUp() async {
    try {
      await ApiService().signup(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );

      // Show success message and navigate to login page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup successful! Please login.')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: $e')),
      );
    }
  }

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

                // Title or Animation
                Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),

                const SizedBox(height: 50),

                // Full Name textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Password textfield with eye icon
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Sign up button
                MyButton(
                  onTap: signUserUp,
                  buttonText: "Sign Up",
                ),

                const SizedBox(height: 50),

                // Already have an account? Log in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Navigate back to LoginPage
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
