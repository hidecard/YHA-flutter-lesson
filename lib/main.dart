import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(const FileStorageApp());
}

class FileStorageApp extends StatelessWidget {
  const FileStorageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.orange,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      home: const FileStorageScreen(),
    );
  }
}

class FileStorageScreen extends StatefulWidget {
  const FileStorageScreen({super.key});

  @override
  _FileStorageScreenState createState() => _FileStorageScreenState();
}

class _FileStorageScreenState extends State<FileStorageScreen> {
  final TextEditingController _controller = TextEditingController();
  String _note = ''; // Displayed note

  @override
  void initState() {
    super.initState();
    _loadNote(); // Load saved note on start
  }

  // Get file path
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/note.txt';
  }

  // Load note from file
  Future<void> _loadNote() async {
    try {
      final file = File(await _localPath);
      final contents = await file.readAsString();
      setState(() {
        _note = contents;
      });
    } catch (e) {
      setState(() {
        _note = ''; // Default to empty if file doesn't exist
      });
    }
  }

  // Save note to file
  Future<void> _saveNote(String note) async {
    final file = File(await _localPath);
    await file.writeAsString(note);
    setState(() {
      _note = note; // Update UI
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Note Saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Storage UI'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Header
            Container(
              margin: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const Text(
                'Save a Note',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Display saved note
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _note.isEmpty ? 'No note saved' : _note,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            // Input field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your Note',
                  hintText: 'Enter your note',
                ),
                maxLines: 3,
              ),
            ),
            // Save button
            Container(
              margin: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    _saveNote(_controller.text);
                    _controller.clear();
                  }
                },
                child: const Text('Save Note'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}