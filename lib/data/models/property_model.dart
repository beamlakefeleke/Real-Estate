import 'package:cloud_firestore/cloud_firestore.dart';

class Property {
  final String id;
  final String title;
  final String description;
  final double price;
  final String location;
  final List<String> images;
  final String sellerId;
  final bool isFeatured;
  final String propertyType;
  final int bedrooms;
  final int bathrooms;
  final double area;
  final DateTime createdAt;
  final List<String> amenities;
  final String status;

  Property({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    required this.images,
    required this.sellerId,
    required this.isFeatured,
    required this.propertyType,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.createdAt,
    required this.amenities,
    required this.status,
  });

  // Convert Firestore document to Property object
  factory Property.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Property(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      location: data['location'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      sellerId: data['sellerId'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      propertyType: data['propertyType'] ?? 'Unknown',
      bedrooms: data['bedrooms'] ?? 0,
      bathrooms: data['bathrooms'] ?? 0,
      area: (data['area'] ?? 0).toDouble(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      amenities: List<String>.from(data['amenities'] ?? []),
      status: data['status'] ?? 'available',
    );
  }

  // Convert Property object to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'location': location,
      'images': images,
      'sellerId': sellerId,
      'isFeatured': isFeatured,
      'propertyType': propertyType,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area': area,
      'createdAt': Timestamp.fromDate(createdAt),
      'amenities': amenities,
      'status': status,
    };
  }

  // **✅ Add `copyWith()` Method for Updates**
  Property copyWith({
    String? title,
    String? description,
    double? price,
    String? location,
    List<String>? images,
    bool? isFeatured,
    String? propertyType,
    int? bedrooms,
    int? bathrooms,
    double? area,
    List<String>? amenities,
    String? status,
  }) {
    return Property(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      location: location ?? this.location,
      images: images ?? this.images,
      sellerId: sellerId,
      isFeatured: isFeatured ?? this.isFeatured,
      propertyType: propertyType ?? this.propertyType,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      area: area ?? this.area,
      createdAt: createdAt,
      amenities: amenities ?? this.amenities,
      status: status ?? this.status,
    );
  }
}
