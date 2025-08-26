import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('ListView.separated Example')),
        body: ListView.separated(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Item $index'),
              leading: Icon(Icons.check_circle),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(color: Colors.grey);
          },
        ),
      ),
    );
  }
}