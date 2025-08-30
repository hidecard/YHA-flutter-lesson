import 'package:firebase_database/firebase_database.dart';
import '../models/user_model.dart';

class DatabaseService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref().child('users');

  // Create or Update user
  Future<void> saveUser(UserModel user) async {
    await _db.child(user.id).set(user.toMap());
  }

  // Read user
  Future<UserModel?> getUser(String id) async {
    final snapshot = await _db.child(id).get();
    if (snapshot.exists) {
      return UserModel.fromMap(id, _convertToMap(snapshot.value));
    }
    return null;
  }

  // Read all users
  Stream<List<UserModel>> getUsers() {
    return _db.onValue.map((event) {
      final List<UserModel> users = [];
      final data = event.snapshot.value;
      if (data != null) {
        // Convert LinkedMap to Map<String, dynamic>
        final mappedData = _convertToMap(data);
        mappedData.forEach((key, value) {
          users.add(UserModel.fromMap(key, value));
        });
      }
      return users;
    });
  } 

  // Delete user
  Future<void> deleteUser(String id) async {
    await _db.child(id).remove();
  }

  // Helper method to convert LinkedMap to Map<String, dynamic>
  Map<String, dynamic> _convertToMap(dynamic data) {
    if (data is Map) {
      return data.map((key, value) => MapEntry(key.toString(), value));
    }
    return {};
  }
}