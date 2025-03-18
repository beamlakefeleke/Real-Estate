import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/property_view_model.dart';
import '../../core/theme.dart';
import '../../widgets/property_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyListingsScreen extends StatefulWidget {
  @override
  _MyListingsScreenState createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends State<MyListingsScreen> {
 @override
void initState() {
  super.initState();

  Future.microtask(() {
    final sellerId = FirebaseAuth.instance.currentUser?.uid;
    print("sellerId $sellerId");
    if (sellerId != null) {
      Provider.of<PropertyViewModel>(context, listen: false).fetchPropertiesBySeller(sellerId);
    }
  });
}


  @override
  Widget build(BuildContext context) {
    final propertyViewModel = Provider.of<PropertyViewModel>(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(title: const Text("My Listings")),
      body: propertyViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : propertyViewModel.properties.isEmpty
              ? const Center(child: Text("No properties listed"))
              : ListView.builder(
                  itemCount: propertyViewModel.properties.length,
                  itemBuilder: (context, index) {
                    final property = propertyViewModel.properties[index];
                    return PropertyCard(
                      property: property,
                      onTap: () {
                        // Implement Edit Property Feature
                      },
                      onRemove: () async {
                        await propertyViewModel.deleteProperty(property.id);
                      },
                    );
                  },
                ),
    );
  }
}
