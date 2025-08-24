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
        body: const CheckboxExample(),
      ),
    );
  }
}

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({super.key});

  @override
  _CheckboxExampleState createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: _agreed,
                onChanged: (bool? value) {
                  setState(() {
                    _agreed = value ?? false;
                  });
                },
              ),
              const Text('I agree', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _agreed ? 'You agreed!' : 'Please agree',
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}