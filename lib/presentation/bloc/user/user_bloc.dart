import 'dart:async';
import 'package:apidemo/models/user_response.dart';
import 'package:apidemo/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  int page = 1;
  bool isFetching = false;
  List<User> users = [];

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<GetUsersEvent>(_onGetUsersEvent);
  }

  // pagination
  FutureOr<void> _onGetUsersEvent(
    GetUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    if (isFetching) return;

    isFetching = true;

    try {
      if (state is UserInitial) {
        emit(UserLoadingState());
      }

      final newUsers = await userRepository.getUsers(page);

      if (newUsers.isEmpty) {
        emit(UserLoadedState(users, hasReachedMax: true));
      } else {
        page++;

        users.addAll(newUsers);
        emit(UserLoadedState(users));
      }
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }

    // IMPORTANT
    isFetching = false;
  }
}
