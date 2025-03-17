import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/property_view_model.dart';
import '../../data/models/property_model.dart';
import '../../core/theme.dart';
import '../../widgets/property_card.dart';

class ManagePropertiesScreen extends StatefulWidget {
  @override
  _ManagePropertiesScreenState createState() => _ManagePropertiesScreenState();
}

class _ManagePropertiesScreenState extends State<ManagePropertiesScreen> {
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
      appBar: AppBar(title: const Text("Manage Properties")),
      body: propertyViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : propertyViewModel.properties.isEmpty
              ? const Center(child: Text("No properties available"))
              : ListView.builder(
                  itemCount: propertyViewModel.properties.length,
                  itemBuilder: (context, index) {
                    final property = propertyViewModel.properties[index];
                    return PropertyCard(
                      property: property,
                      onTap: () {
                        // Implement View Details
                      },
                      onRemove: () async {
                        await propertyViewModel.deleteProperty(property.id);
                      },
                      // Action Buttons
                      extraActions: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check_circle, color: Colors.green),
                            onPressed: () {
                              propertyViewModel.updateProperty(property.id, {'status': 'approved'});
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            onPressed: () {
                              propertyViewModel.updateProperty(property.id, {'status': 'rejected'});
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
