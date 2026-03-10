import 'package:apidemo/di/injector.dart';
import 'package:apidemo/models/user_response.dart';
import 'package:apidemo/presentation/bloc/user/user_bloc.dart';
import 'package:apidemo/repository/user_repository.dart';
import 'package:apidemo/presentation/screens/user_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<User>> getUsers() async {
    return await sl<UserRepository>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is UserErrorState) {
            return Center(child: Text(state.message));
          }
          if (state is UserLoadedState) {
            List<User> users = state.users;
            if (users.isEmpty) Center(child: Text("No user..."));
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                User user = users[index];
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
    );
  }
}
