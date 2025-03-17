import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/property_view_model.dart';
import '../../data/models/property_model.dart';
import '../../core/theme.dart';
import '../../widgets/property_card.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final propertyViewModel = Provider.of<PropertyViewModel>(context);
    final List<Property> wishlist = propertyViewModel.properties.where((p) => p.isFeatured).toList();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(title: const Text("Wishlist")),
      body: wishlist.isEmpty
          ? const Center(child: Text("No favorite properties yet"))
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final property = wishlist[index];
                return PropertyCard(
                  property: property,
                  onTap: () {
                    Navigator.pushNamed(context, '/property-detail', arguments: property);
                  },
                  onRemove: () {
                    // Implement remove from wishlist functionality
                  },
                );
              },
            ),
    );
  }
}
