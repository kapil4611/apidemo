part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final List<User> users;
  final bool hasReachedMax;
  UserLoadedState(this.users, {this.hasReachedMax = false});
}

class UserErrorState extends UserState {
  final String message;
  UserErrorState(this.message);
}
