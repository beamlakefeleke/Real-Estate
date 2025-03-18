import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current authenticated user
  User? get currentUser => _auth.currentUser;

  // Stream for auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Register a new user
    // Register a new user
  Future<UserModel?> registerUser(
      String name, String email, String password, String phone, String role) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        UserModel newUser = UserModel(
          id: user.uid,
          name: name,
          email: email,
          phoneNumber: phone,
          profileImage: "",
          role: role, // "buyer", "seller", "admin"
          createdAt: DateTime.now(),
        );

        await _firestore.collection('users').doc(user.uid).set(newUser.toFirestore());
        return newUser;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.code} - ${e.message}");
      return null;
    } catch (e) {
      print("Unknown Error: ${e.toString()}");
      return null;
    }
  }


  // Login user
  Future<UserModel?> loginUser(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();

    if (userDoc.exists) {
      UserModel user = UserModel.fromFirestore(userDoc);
      return user; // ✅ Return the user model with role
    }
    return null;
  } catch (e) {
    throw Exception("Login failed: ${e.toString()}");
  }
}


  // Logout user
  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}
