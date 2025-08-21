import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('YHA Lesson')),
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            color: Colors.orange,
            child: Text(
              'Text with Margin',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}