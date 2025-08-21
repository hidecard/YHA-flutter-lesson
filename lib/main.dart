import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('YHA Lesson')),
        body: const GestureDetectorExample(),
      ),
    );
  }
}

class GestureDetectorExample extends StatefulWidget {
  const GestureDetectorExample({super.key});

  @override
  _GestureDetectorExampleState createState() => _GestureDetectorExampleState();
}

class _GestureDetectorExampleState extends State<GestureDetectorExample> {
  Color _boxColor = Colors.blue;
  String _message = 'Tap or Double-Tap the Box';

  void _handleTap() {
    setState(() {
      _boxColor = Colors.green;
      _message = 'Single Tap Detected!';
    });
  }

  void _handleDoubleTap() {
    setState(() {
      _boxColor = Colors.red;
      _message = 'Double Tap Detected!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _message,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _handleTap,
            onDoubleTap: _handleDoubleTap,
            child: Container(
              width: 150,
              height: 150,
              color: _boxColor,
              child: const Center(
                child: Text(
                  'Tap Me',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}