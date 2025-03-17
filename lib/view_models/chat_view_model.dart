import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/repositories/chat_repository.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatRepository _chatRepository = ChatRepository();
  bool _isSending = false;
  String? _errorMessage;

  bool get isSending => _isSending;
  String? get errorMessage => _errorMessage;

  // Get messages stream
  Stream<QuerySnapshot> getMessages(String chatId) {
    return _chatRepository.getMessages(chatId);
  }

  // Send message
  Future<void> sendMessage(String chatId, String senderId, String message) async {
    _isSending = true;
    notifyListeners();

    try {
      await _chatRepository.sendMessage(chatId, senderId, message);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isSending = false;
    notifyListeners();
  }

  // Create chat session
  Future<void> createChatSession(String buyerId, String sellerId) async {
    try {
      await _chatRepository.createChatSession(buyerId, sellerId);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
