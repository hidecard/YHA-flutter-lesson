import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../services/database_service.dart';
import '../services/storage_service.dart';
import 'package:uuid/uuid.dart';
import 'dart:typed_data';

class UserFormScreen extends StatefulWidget {
  final UserModel? user;

  const UserFormScreen({Key? key, this.user}) : super(key: key);

  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _phone;
  late String _userClass;
  dynamic _image; // Supports File (mobile) or Uint8List (web)

  @override
  void initState() {
    super.initState();
    _name = widget.user?.name ?? '';
    _email = widget.user?.email ?? '';
    _phone = widget.user?.phone ?? '';
    _userClass = widget.user?.userClass ?? '';
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        if (kIsWeb) {
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            _image = bytes; // Uint8List for web
          });
        } else {
          setState(() {
            _image = File(pickedFile.path); // File for mobile
          });
        }
      }
    } catch (e) {
      print('Image picker error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final databaseService = Provider.of<DatabaseService>(context, listen: false);
      final storageService = Provider.of<StorageService>(context, listen: false);
      final userId = widget.user?.id ?? const Uuid().v4();

      String? photoUrl = widget.user?.photoUrl;
      if (_image != null) {
        photoUrl = await storageService.uploadPhoto(userId, _image);
        if (photoUrl == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to upload photo')),
          );
          return;
        }
      }

      final user = UserModel(
        id: userId,
        name: _name,
        email: _email,
        phone: _phone,
        userClass: _userClass,
        photoUrl: photoUrl,
      );

      try {
        await databaseService.saveUser(user);
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save user: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Add User' : 'Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null
                        ? (kIsWeb
                            ? MemoryImage(_image as Uint8List)
                            : FileImage(_image as File))
                        : widget.user?.photoUrl != null
                            ? NetworkImage(widget.user!.photoUrl!)
                            : null,
                    child: _image == null && widget.user?.photoUrl == null
                        ? const Icon(Icons.add_a_photo, size: 50)
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _name,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter a name' : null,
                  onSaved: (value) => _name = value!,
                ),
                TextFormField(
                  initialValue: _email,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter an email' : null,
                  onSaved: (value) => _email = value!,
                ),
                TextFormField(
                  initialValue: _phone,
                  decoration: const InputDecoration(labelText: 'Phone'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter a phone number' : null,
                  onSaved: (value) => _phone = value!,
                ),
                TextFormField(
                  initialValue: _userClass,
                  decoration: const InputDecoration(labelText: 'Class'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter a class' : null,
                  onSaved: (value) => _userClass = value!,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveUser,
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}