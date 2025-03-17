import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/routes.dart';
import '../../widgets/app_drawer.dart';

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(title: const Text("Admin Dashboard")),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Dashboard Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dashboardCard("Total Users", "150", Icons.people, Colors.blue),
                _dashboardCard("Total Properties", "45", Icons.apartment, Colors.green),
              ],
            ),
            const SizedBox(height: 30),

            // Buttons for Admin Actions
            ElevatedButton.icon(
              icon: const Icon(Icons.business),
              label: const Text("Manage Properties"),
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.manageProperties);
              },
            ),
            const SizedBox(height: 15),

            ElevatedButton.icon(
              icon: const Icon(Icons.supervisor_account),
              label: const Text("Manage Users"),
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.manageUsers);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboardCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}
