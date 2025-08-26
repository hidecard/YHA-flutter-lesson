import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('GridView.count Example')),
        body: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          padding: EdgeInsets.all(8.0),
          children: [
            Container(color: Colors.blue, child: Center(child: Text('Item 1'))),
            Container(color: Colors.red, child: Center(child: Text('Item 2'))),
            Container(color: Colors.green, child: Center(child: Text('Item 3'))),
            Container(color: Colors.yellow, child: Center(child: Text('Item 4'))),
          ],
        ),
      ),
    );
  }
}