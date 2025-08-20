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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: Colors.blue,
                  width: 100,
                  height: 100,
                  child: Center(child: Text('Box 1', style: TextStyle(color: Colors.white))),
                ),
                Container(
                  color: Colors.green,
                  width: 100,
                  height: 100,
                  child: Center(child: Text('Box 2', style: TextStyle(color: Colors.white))),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              color: Colors.red,
              width: 100,
              height: 100,
              child: Center(child: Text('Box 3', style: TextStyle(color: Colors.white))),
            ),
          ],
        ),
      ),
    );
  }
}