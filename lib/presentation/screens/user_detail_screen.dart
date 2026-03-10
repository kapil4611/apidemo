import 'package:apidemo/models/user_response.dart';
import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;
  const UserDetailScreen(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${user.firstName} ${user.lastName}")),
      body: Column(
        children: [
          Image.network(user.avatar!),
          ListTile(
            title: Text("${user.firstName} ${user.lastName}"),

            subtitle: Text("${user.email}"),
          ),
        ],
      ),
    );
  }
}
