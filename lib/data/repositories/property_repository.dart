import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/property_model.dart';

class PropertyRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all properties
  Future<List<Property>> getProperties() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('properties').orderBy('createdAt', descending: true).get();
      return snapshot.docs.map((doc) => Property.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception("Error fetching properties: ${e.toString()}");
    }
  }

  // Fetch properties by seller ID
  Future<List<Property>> getPropertiesBySeller(String sellerId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('properties')
          .where('sellerId', isEqualTo: sellerId)
          .get();
      return snapshot.docs.map((doc) => Property.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception("Error fetching seller properties: ${e.toString()}");
    }
  }

  // Add a new property
  Future<void> addProperty(Property property) async {
    try {
      await _firestore.collection('properties').doc(property.id).set(property.toFirestore());
    } catch (e) {
      throw Exception("Error adding property: ${e.toString()}");
    }
  }

  // Update a property
  Future<void> updateProperty(String propertyId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('properties').doc(propertyId).update(updates);
    } catch (e) {
      throw Exception("Error updating property: ${e.toString()}");
    }
  }

  // Delete a property
  Future<void> deleteProperty(String propertyId) async {
    try {
      await _firestore.collection('properties').doc(propertyId).delete();
    } catch (e) {
      throw Exception("Error deleting property: ${e.toString()}");
    }
  }
}
