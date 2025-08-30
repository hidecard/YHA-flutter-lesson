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
      print('Raw snapshot value: $data'); // Debug raw data
      if (data != null) {
        final mappedData = _convertToMap(data);
        print('Mapped data type: ${mappedData.runtimeType}'); // Debug type
        print('Mapped data: $mappedData'); // Debug converted data
        mappedData.forEach((key, value) {
          if (key is String && value is Map) {
            try {
              final typedValue = Map<String, dynamic>.from(value); // Explicit conversion
              users.add(UserModel.fromMap(key, typedValue));
            } catch (e) {
              print('Error converting value for key $key: $e'); // Debug conversion errors
            }
          } else {
            print('Skipping invalid key-value pair: key=$key, value=$value'); // Debug skipped data
          }
        });
      } else {
        print('No data received from snapshot');
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
      return Map<String, dynamic>.fromIterable(
        data.entries,
        key: (entry) => entry.key.toString(), // Ensure string keys
        value: (entry) => entry.value is Map ? _convertToMap(entry.value) : entry.value,
      );
    }
    return <String, dynamic>{}; // Return empty map with correct type
  }
}