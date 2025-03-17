import 'package:flutter/material.dart';
import '../data/models/property_model.dart';
import '../core/theme.dart';

class PropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;
  final Widget? extraActions;

  const PropertyCard({
    Key? key,
    required this.property,
    this.onTap,
    this.onRemove,
    this.extraActions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                property.images.isNotEmpty ? property.images.first : 'https://via.placeholder.com/300',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          property.title,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "\$${property.price}",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  // Location
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.grey, size: 18),
                      Expanded(
                        child: Text(
                          property.location,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Bedrooms & Bathrooms
                  Row(
                    children: [
                      const Icon(Icons.king_bed, size: 18, color: Colors.blueGrey),
                      Text(" ${property.bedrooms} Beds", style: const TextStyle(fontSize: 14, color: Colors.black54)),
                      const SizedBox(width: 15),
                      const Icon(Icons.bathtub, size: 18, color: Colors.blueGrey),
                      Text(" ${property.bathrooms} Baths", style: const TextStyle(fontSize: 14, color: Colors.black54)),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Wishlist / Remove / Admin Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (onRemove != null)
                        IconButton(
                          icon: const Icon(Icons.favorite_border, color: Colors.red),
                          onPressed: onRemove,
                        ),
                      if (extraActions != null) extraActions!,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
