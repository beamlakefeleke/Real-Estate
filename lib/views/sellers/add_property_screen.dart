import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../view_models/property_view_model.dart';
import '../../data/models/property_model.dart';
import '../../core/theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/text_field.dart';

class AddPropertyScreen extends StatefulWidget {
  @override
  _AddPropertyScreenState createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final propertyViewModel = Provider.of<PropertyViewModel>(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(title: const Text("Add New Property")),
      
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _titleController,
                  hintText: "Property Title",
                  icon: Icons.home,
                  validator: (value) => value!.isEmpty ? "Enter a title" : null,
                ),
                const SizedBox(height: 15),

                CustomTextField(
                  controller: _priceController,
                  hintText: "Price (\$)",
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? "Enter a price" : null,
                ),
                const SizedBox(height: 15),

                CustomTextField(
                  controller: _locationController,
                  hintText: "Location",
                  icon: Icons.location_on,
                  validator: (value) => value!.isEmpty ? "Enter a location" : null,
                ),
                const SizedBox(height: 15),

                CustomTextField(
                  controller: _descriptionController,
                  hintText: "Description",
                  icon: Icons.description,
                  maxLines: 4,
                  validator: (value) => value!.isEmpty ? "Enter a description" : null,
                ),
                const SizedBox(height: 20),

                // Submit Button
                propertyViewModel.isLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: "Add Property",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final newProperty = Property(
                              id: const Uuid().v4(), // Generate unique ID
                              title: _titleController.text,
                              price: double.parse(_priceController.text),
                              location: _locationController.text,
                              description: _descriptionController.text,
                              sellerId: "seller123", // Fetch seller ID dynamically
                              images: ["https://via.placeholder.com/300"], // Temporary placeholder
                              isFeatured: false,
                              propertyType: "Apartment",
                              bedrooms: 2,
                              bathrooms: 2,
                              area: 120.0,
                              createdAt: DateTime.now(),
                              amenities: ["WiFi", "Parking"],
                              status: "pending",
                            );

                            await propertyViewModel.addProperty(newProperty);
                            Navigator.pop(context);
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
