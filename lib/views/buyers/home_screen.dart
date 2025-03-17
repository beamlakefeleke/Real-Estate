import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/property_view_model.dart';
import '../../data/models/property_model.dart';
import '../../core/theme.dart';
import '../../core/routes.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/property_card.dart';

class BuyerHomeScreen extends StatefulWidget {
  @override
  _BuyerHomeScreenState createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PropertyViewModel>(context, listen: false).fetchProperties();
  }

  @override
  Widget build(BuildContext context) {
    final propertyViewModel = Provider.of<PropertyViewModel>(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(title: const Text("Find Your Dream Home")),
      drawer: AppDrawer(),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search properties...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (query) {
                // Future: Implement search functionality
              },
            ),
          ),

          // Property Listings
          Expanded(
            child: propertyViewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : propertyViewModel.properties.isEmpty
                    ? const Center(child: Text("No properties found"))
                    : ListView.builder(
                        itemCount: propertyViewModel.properties.length,
                        itemBuilder: (context, index) {
                          final property = propertyViewModel.properties[index];
                          return PropertyCard(
                            property: property,
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.propertyDetail, arguments: property);
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
