import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = StreamController<int>();

  @override
  void initState() {
    super.initState();
    // Simulate a stream emitting numbers 1 to 5
    int i = 1;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (i > 5) {
        timer.cancel();
        _controller.close();
      } else {
        _controller.add(i++);
      }
    });
  }

  @override
  void dispose() {
    _controller.close(); // Clean up the StreamController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('StreamBuilder Example')),
      body: Center(
        child: StreamBuilder<int>(
          stream: _controller.stream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.hasData) {
                  return Text('Count: ${snapshot.data}', style: TextStyle(fontSize: 20));
                }
                return Text('Stream closed');
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}