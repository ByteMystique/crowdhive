import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0; // Track the currently selected tab

  // Screens for each tab
  final List<Widget> _pages = [
    FundsScreen(), // Funds screen with cards
    SettingsScreen(), // Settings screen
    UserProfileScreen(), // Profile screen
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
      body: _pages[_currentIndex], // Display the current page

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected tab
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

// Funds Screen
class FundsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two cards in a row
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 5, // Number of cards
        itemBuilder: (context, index) {
          // Example data for cards
          final cardsData = [
            {"title": "Play & Win", "subtitle": "Rewards", "color": Colors.purple},
            {"title": "December Spends", "subtitle": "₹441", "color": Colors.green},
            {"title": "Pay Bills", "subtitle": "Instantly", "color": Colors.deepPurple},
            {"title": "Autopay", "subtitle": "0 Active", "color": Colors.blue},
            {"title": "Invite", "subtitle": "Earn up to ₹500", "color": Colors.red},
          ];
          final card = cardsData[index];

          return GestureDetector(
            onTap: () {
              // Navigate to FundDetailsScreen with card details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FundDetailsScreen(fund: card),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: card["color"] as Color,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card["title"] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      card["subtitle"] as String,
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

// Fund Details Screen
class FundDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> fund;

  const FundDetailsScreen({super.key, required this.fund});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fund['title'] as String),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fund['title'] as String,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              fund['subtitle'] as String,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              "More details about this fund will go here...",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// Settings Screen
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Settings Screen",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

// User Profile Screen
class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Profile Screen",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
