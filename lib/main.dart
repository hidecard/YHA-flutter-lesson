import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const SimpleJsonApp());
}

class SimpleJsonApp extends StatelessWidget {
  const SimpleJsonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: const NewPostScreen(),
    );
  }
}

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final TextEditingController _controller = TextEditingController();
  String _postTitle = ''; // Store parsed title

  // Send POST request and parse response
  Future<void> _createPost() async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': _controller.text,
        'body': 'Sample body',
        'userId': 1,
      }),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body); // Parse JSON
      setState(() {
        _postTitle = data['title']; // Get title
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Post')),
      body: Column(
        children: [
          // Input
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Post Title',
              ),
            ),
          ),
          // Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  _createPost();
                }
              },
              child: const Text('Send Post'),
            ),
          ),
          // Display
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _postTitle.isEmpty ? 'No post yet' : 'Posted: $_postTitle',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}