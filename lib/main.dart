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
        body: const DropdownButtonExample(),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  _DropdownButtonExampleState createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String? _selectedFruit = 'Apple';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: _selectedFruit,
              items: <String>['Apple', 'Banana', 'Orange'].map((String fruit) {
                return DropdownMenuItem<String>(
                  value: fruit,
                  child: Text(fruit),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFruit = newValue;
                });
              },
              hint: const Text('Pick a fruit'),
            ),
          ),
          Text(
            'You chose: ${_selectedFruit ?? 'Nothing'}',
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}