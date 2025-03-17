import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all users
  Future<List<UserModel>> getUsers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception("Error fetching users: ${e.toString()}");
    }
  }

  // Update user data (Ban, Verify, etc.)
  Future<void> updateUser(String userId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('users').doc(userId).update(updates);
    } catch (e) {
      throw Exception("Error updating user: ${e.toString()}");
    }
  }


//delete user data
Future<void> deleteUser(String userId) async {
  try {
    await _firestore.collection('users').doc(userId).delete();
  } catch (e) {
    throw Exception("Error deleting user: ${e.toString()}");
  }
}
}