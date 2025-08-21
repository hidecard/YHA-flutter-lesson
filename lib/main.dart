import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const IconButtonExample(),
    );
  }
}

class IconButtonExample extends StatefulWidget {
  const IconButtonExample({super.key});

  @override
  _IconButtonExampleState createState() => _IconButtonExampleState();
}

class _IconButtonExampleState extends State<IconButtonExample> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: const Text('YHA Lesson')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isDarkMode ? 'Dark Mode' : 'Light Mode',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              IconButton(
                onPressed: _toggleTheme,
                icon: Icon(
                  _isDarkMode ? Icons.brightness_7 : Icons.brightness_4,
                  size: 40,
                  color: _isDarkMode ? Colors.yellow : Colors.blue,
                ),
                tooltip: 'Toggle Theme',
              ),
            ],
          ),
        ),
      ),
    );
  }
}