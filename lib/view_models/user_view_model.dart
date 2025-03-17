import 'package:flutter/material.dart';
import '../data/models/user_model.dart';
import '../data/repositories/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  List<UserModel> _users = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch users from Firestore
  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await _userRepository.getUsers();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Update user status (Ban/Verify)
  Future<void> updateUser(String userId, Map<String, dynamic> updates) async {
    try {
      await _userRepository.updateUser(userId, updates);
      await fetchUsers(); // Refresh the list after update
    } catch (e) {
      _errorMessage = e.toString();
    }
    notifyListeners();
  }
}
