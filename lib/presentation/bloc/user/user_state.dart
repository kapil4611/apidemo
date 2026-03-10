part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final List<User> users;
  UserLoadedState(this.users);
}

class UserErrorState extends UserState {
  final String message;
  UserErrorState(this.message);
}
