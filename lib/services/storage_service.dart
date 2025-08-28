import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';
import 'dart:io' show File;

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadPhoto(String userId, dynamic file) async {
    try {
      final ref = _storage.ref().child('user_photos/$userId.jpg');
      UploadTask uploadTask;

      if (kIsWeb) {
        if (file is Uint8List) {
          uploadTask = ref.putData(file, SettableMetadata(contentType: 'image/jpeg'));
        } else {
          throw Exception('Invalid file type for web: Expected Uint8List');
        }
      } else {
        if (file is File) {
          uploadTask = ref.putFile(file, SettableMetadata(contentType: 'image/jpeg'));
        } else {
          throw Exception('Invalid file type for mobile: Expected File');
        }
      }

      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Upload error: $e');
      return null;
    }
  }

  Future<void> deletePhoto(String userId) async {
    try {
      final ref = _storage.ref().child('user_photos/$userId.jpg');
      await ref.delete();
    } catch (e) {
      print('Delete error: $e');
    }
  }
}