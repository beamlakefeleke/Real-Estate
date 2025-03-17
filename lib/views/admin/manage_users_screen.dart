import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/user_view_model.dart';
import '../../data/models/user_model.dart';
import '../../core/theme.dart';

class ManageUsersScreen extends StatefulWidget {
  @override
  _ManageUsersScreenState createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserViewModel>(context, listen: false).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(title: const Text("Manage Users")),
      body: userViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : userViewModel.users.isEmpty
              ? const Center(child: Text("No users found"))
              : ListView.builder(
                  itemCount: userViewModel.users.length,
                  itemBuilder: (context, index) {
                    final user = userViewModel.users[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profileImage.isNotEmpty ? user.profileImage : 'https://via.placeholder.com/150'),
                        ),
                        title: Text(user.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Text(user.email),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == "Ban") {
                              userViewModel.updateUser(user.id, {'status': 'banned'});
                            } else if (value == "Verify") {
                              userViewModel.updateUser(user.id, {'status': 'verified'});
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(value: "Verify", child: Text("Verify User")),
                            const PopupMenuItem(value: "Ban", child: Text("Ban User")),
                            const PopupMenuItem(value: "Delete", child: Text("Remove User")),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
