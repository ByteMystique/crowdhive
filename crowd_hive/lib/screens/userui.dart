import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const FundsScreen(),
    const SettingsScreen(),
    const UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? "Explore Funds"
              : _currentIndex == 1
                  ? "Settings"
                  : "Profile",
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Funds",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class FundsScreen extends StatefulWidget {
  const FundsScreen({super.key});

  @override
  State<FundsScreen> createState() => _FundsScreenState();
}

class _FundsScreenState extends State<FundsScreen> {
  List<Map<String, dynamic>> funds = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchFunds();
  }

  Future<void> fetchFunds() async {
    final url = 'http://192.168.29.150:4000/get-posters'; // Replace <your-ip> with the backend IP

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          funds = List<Map<String, dynamic>>.from(data['posters']);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to fetch funds: ${response.reasonPhrase}';
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error: $error';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(
        child: Text(errorMessage, style: const TextStyle(color: Colors.red)),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: funds.length,
        itemBuilder: (context, index) {
          final fund = funds[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FundDetailsScreen(fund: fund),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fund["heading"] ?? "No Title",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      fund["description"] ?? "No Description",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FundDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> fund;

  const FundDetailsScreen({super.key, required this.fund});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fund['heading'] ?? "Fund Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fund['heading'] ?? "No Title",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              fund['description'] ?? "No Description",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              "End Goal: ${fund['endGoal'] ?? 'N/A'}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              "Expected Amount: ₹${fund['expectedAmount'] ?? 'N/A'}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              "Duration: ${fund['duration'] ?? 'N/A'} days",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Settings Screen"),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Profile Screen"),
    );
  }
}
