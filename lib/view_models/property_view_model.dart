import 'package:flutter/material.dart';
import '../data/models/property_model.dart';
import '../data/repositories/property_repository.dart';

class PropertyViewModel extends ChangeNotifier {
  final PropertyRepository _propertyRepository = PropertyRepository();
  List<Property> _properties = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Property> get properties => _properties;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch properties
  Future<void> fetchProperties() async {
    _isLoading = true;
    notifyListeners();

    try {
      _properties = await _propertyRepository.getProperties();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Fetch properties by seller
  Future<void> fetchPropertiesBySeller(String sellerId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _properties = await _propertyRepository.getPropertiesBySeller(sellerId);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Add new property
  Future<void> addProperty(Property property) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _propertyRepository.addProperty(property);
      _properties.add(property);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateProperty(String propertyId, Map<String, dynamic> updates) async {
  try {
    await _propertyRepository.updateProperty(propertyId, updates);
    
    int index = _properties.indexWhere((prop) => prop.id == propertyId);
    if (index != -1) {
      _properties[index] = _properties[index].copyWith(
        title: updates['title'],
        description: updates['description'],
        price: updates['price'],
        location: updates['location'],
        images: updates['images'] != null ? List<String>.from(updates['images']) : null,
        isFeatured: updates['isFeatured'],
        propertyType: updates['propertyType'],
        bedrooms: updates['bedrooms'],
        bathrooms: updates['bathrooms'],
        area: updates['area'],
        amenities: updates['amenities'] != null ? List<String>.from(updates['amenities']) : null,
        status: updates['status'],
      );
    }
    notifyListeners();
  } catch (e) {
    _errorMessage = e.toString();
    notifyListeners();
  }
}



  // Delete property
  Future<void> deleteProperty(String propertyId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _propertyRepository.deleteProperty(propertyId);
      _properties.removeWhere((property) => property.id == propertyId);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
