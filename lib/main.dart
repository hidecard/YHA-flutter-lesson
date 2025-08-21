import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('YHA Lesson')),
        body: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                height: 100,
                color: Colors.blue,
                child: const Center(child: Text('Flex 1', style: TextStyle(color: Colors.white))),
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                height: 100,
                color: Colors.green,
                child: const Center(child: Text('Flex 3', style: TextStyle(color: Colors.white))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}