import 'package:flutter/material.dart';
import '../data/models/property_model.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/register_screen.dart';
import '../views/buyers/home_screen.dart';
import '../views/buyers/property_detail_screen.dart';
import '../views/sellers/seller_dashboard.dart';
import '../views/sellers/add_property_screen.dart'; // ✅ Import AddPropertyScreen
import '../views/sellers/my_listings_screen.dart';
import '../views/admin/admin_dashboard.dart';
import '../views/admin/manage_properties_screen.dart'; // ✅ Import ManagePropertiesScreen
import '../views/admin/manage_users_screen.dart';

class AppRoutes {
  static const String login = "/login";
  static const String register = "/register";
  static const String buyerHome = "/buyer-home";
  static const String propertyDetail = "/property-detail"; // ✅ Add this
  static const String addProperty = "/add-property"; // ✅ Add this
  static const String myListings = "/my-listings"; //
  static const String sellerDashboard = "/seller-dashboard";
  static const String adminDashboard = "/admin-dashboard";
  static const String manageProperties = "/manage-properties"; // ✅ Add this
  static const String manageUsers = "/manage-users"; // 

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case buyerHome:
        return MaterialPageRoute(builder: (_) => BuyerHomeScreen());
      case propertyDetail: // ✅ Add PropertyDetail Route
        final property = settings.arguments as Property;
        return MaterialPageRoute(builder: (_) => PropertyDetailScreen(property: property));
      case addProperty: // ✅ Add this route
        return MaterialPageRoute(builder: (_) => AddPropertyScreen());
      case myListings: // ✅ Add this route
        return MaterialPageRoute(builder: (_) => MyListingsScreen());
      case manageProperties: // ✅ Add this route
        return MaterialPageRoute(builder: (_) => ManagePropertiesScreen());
      case manageUsers: // ✅ Add this route
        return MaterialPageRoute(builder: (_) => ManageUsersScreen());
      case sellerDashboard:
        return MaterialPageRoute(builder: (_) => SellerDashboardScreen());
      case adminDashboard:
        return MaterialPageRoute(builder: (_) => AdminDashboardScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text("Page not found"))),
        );
    }
  }
}
