import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmployeeDashboard extends StatefulWidget {
  const EmployeeDashboard({super.key});

  @override
  State<EmployeeDashboard> createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  int _currentIndex = 0; // Track the selected bottom navigation index

  final List<Widget> _pages = [
    const DashboardTab(), // Dashboard content
    const AddContributionScreen(), // Add Contribution screen
    const SettingsScreen(), // Settings screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? "Dashboard"
              : _currentIndex == 1
                  ? "Add Contribution"
                  : "Settings",
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected tab index
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add Contribution",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

// Dashboard Tab
class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Dashboard Content (Optional)",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

// Add Contribution Screen
class AddContributionScreen extends StatelessWidget {
  const AddContributionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers to capture user input
    final TextEditingController headingController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController endGoalController = TextEditingController();
    final TextEditingController expectedAmountController = TextEditingController();
    final TextEditingController durationController = TextEditingController();

    // Function to submit contribution data
    Future<void> submitContribution() async {
      // Payload to send to the API
      final payload = {
        "companyId": "63fbeefad8390c00dcae1a5f", // Replace with actual company ID
        "heading": headingController.text,
        "description": descriptionController.text,
        "endGoal": endGoalController.text,
        "expectedAmount": int.tryParse(expectedAmountController.text) ?? 0,
        "duration": int.tryParse(durationController.text) ?? 0,
      };

      try {
        // POST request to the API
        final response = await http.post(
          Uri.parse('http://192.168.29.150:4000/create-poster'), // Replace <your-ip> with your backend's IP
          headers: {'Content-Type': 'application/json'},
          body: json.encode(payload),
        );

        // Handle response
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contribution added successfully!')),
          );
          // Clear form fields after successful submission
          headingController.clear();
          descriptionController.clear();
          endGoalController.clear();
          expectedAmountController.clear();
          durationController.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Input fields
          TextField(
            controller: headingController,
            decoration: const InputDecoration(
              labelText: "Heading",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: "Description",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: endGoalController,
            decoration: const InputDecoration(
              labelText: "End Goal",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: expectedAmountController,
            decoration: const InputDecoration(
              labelText: "Expected Amount",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: durationController,
            decoration: const InputDecoration(
              labelText: "Duration (in days)",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 32),

          // Submit button
          ElevatedButton(
            onPressed: submitContribution, // Call the function on button click
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}

// Settings Screen
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Settings Screen"),
    );
  }
}
