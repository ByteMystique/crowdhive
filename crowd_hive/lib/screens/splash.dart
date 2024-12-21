import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../main.dart'; // Import relative to the folder

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds and navigate to the home screen
    Future.delayed(const Duration(seconds: 8), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(title: 'Home Page'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Splash screen background
      body: Center(
        child: Lottie.network(
          'https://lottie.host/9064b181-7d94-439e-a130-034f39583b20/ddsejJdZHL.json', // Example Lottie animation
          errorBuilder: (context, error, stackTrace) {
            return const Text('Failed to load animation');
          },
        ),
      ),
    );
  }
}
