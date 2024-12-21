import 'package:crowd_hive/components/my_button.dart';
import 'package:crowd_hive/screens/compregister.dart';
import 'package:crowd_hive/screens/compregister.dart';
import 'package:crowd_hive/screens/compui.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import Lottie

class LoginPageC extends StatefulWidget {
  const LoginPageC({super.key});

  @override
  State<LoginPageC> createState() => _LoginPageCState();
}

class _LoginPageCState extends State<LoginPageC> {
  // Text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final walletIdController = TextEditingController();

  // Password visibility toggle
  bool _isPasswordVisible = false;

  // Sign user in method
  void signUserIn() {
    // Placeholder for sign-in logic
    print('Sign In Clicked');
  }

  // Navigate to Register Page
  void navigateToRegisterPageC(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPageC()),
    );
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

                // Lottie animation
                Lottie.network(
                  'https://lottie.host/cf3cadc7-a962-4f9c-af23-48238d507c10/kcmohLQFCK.json',
                  height: 150,
                  width: 245,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Failed to load animation');
                  },
                ),

                const SizedBox(height: 50),

                // Welcome back text
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 25),

                // Username textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'Company Name',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
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
                        borderSide: BorderSide(color: Colors.grey),
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

                const SizedBox(height: 10),

                // Wallet ID textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: walletIdController,
                    decoration: InputDecoration(
                      hintText: 'Wallet ID',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Sign in button
                MyButton(
  onTap: () {
    // Navigate to DashboardScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmployeeDashboard(), // Replace with your screen
      ),
    );
  },
  buttonText: "Sign In",
)
,

                const SizedBox(height: 50),

                // Not a member? Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        navigateToRegisterPageC(context); // Navigate to Register Page
                      },
                      child: const Text(
                        'Register now',
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
