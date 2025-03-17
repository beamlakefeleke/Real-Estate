import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get chat messages as a stream (real-time updates)
  Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Send a new message
  Future<void> sendMessage(String chatId, String senderId, String message) async {
    try {
      await _firestore.collection('chats').doc(chatId).collection('messages').add({
        'senderId': senderId,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception("Error sending message: ${e.toString()}");
    }
  }

  // Create a new chat session between buyer and seller
  Future<void> createChatSession(String buyerId, String sellerId) async {
    try {
      String chatId = buyerId + "_" + sellerId; // Unique chat ID
      await _firestore.collection('chats').doc(chatId).set({
        'buyerId': buyerId,
        'sellerId': sellerId,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception("Error creating chat: ${e.toString()}");
    }
  }
}
