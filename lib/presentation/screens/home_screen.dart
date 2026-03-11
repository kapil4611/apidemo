import 'package:apidemo/models/user_response.dart';
import 'package:apidemo/presentation/bloc/user/user_bloc.dart';
import 'package:apidemo/presentation/screens/user_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> allUsers = [];
  List<User> filteredUsers = [];

  void filterUsers(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredUsers = allUsers;
      });
    } else {
      setState(() {
        filteredUsers = allUsers
            .where(
              (user) =>
                  user.firstName!.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: Column(
        children: [
          /// SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: filterUsers,
              decoration: InputDecoration(
                hintText: "Search user...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is UserErrorState) {
                  return Center(child: Text(state.message));
                }
                if (state is UserLoadedState) {
                  allUsers = state.users;
                  filteredUsers = filteredUsers.isEmpty
                      ? allUsers
                      : filteredUsers;
                  if (filteredUsers.isEmpty) Center(child: Text("No user..."));
                  return ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      User user = filteredUsers[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetailScreen(user),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          child: Image.network(
                            user.avatar!,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;

                              return Center(child: CircularProgressIndicator());
                            },

                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.broken_image,
                                size: 50,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                        title: Text("${user.firstName}"),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
