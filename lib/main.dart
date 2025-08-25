import 'package:flutter/material.dart';

void main() {
  runApp(const BottomNavApp());
}

class BottomNavApp extends StatelessWidget {
  const BottomNavApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.orange,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      home: const BottomNavScreen(),
    );
  }
}

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0; // Tracks selected tab

  @override
  Widget build(BuildContext context) {
    final screens = [
      // Home Screen UI
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: const Text(
              'Home Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Welcome to the Home tab!',
              style: TextStyle(fontSize: 18),
            ),
          ),
          ElevatedButton(
            onPressed: () {}, // Placeholder
            child: const Text('Explore'),
          ),
        ],
      ),
      // Profile Screen UI
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: const Text(
              'Profile Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'View your profile details here.',
              style: TextStyle(fontSize: 18),
            ),
          ),
          ElevatedButton(
            onPressed: () {}, // Placeholder
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('YHA Lesson'),
        backgroundColor: Colors.orange,
      ),
      body: Center(child: screens[_currentIndex]), // Show selected tab content
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Switch tabs
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
      ),
    );
  }
}