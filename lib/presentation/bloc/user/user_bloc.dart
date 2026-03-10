import 'dart:async';

import 'package:apidemo/models/user_response.dart';
import 'package:apidemo/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc(this.userRepository) : super(UserInitial()) {
    on<GetUsersEvent>(_onGetUsersEvent);
  }

  FutureOr<void> _onGetUsersEvent(
    GetUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());
    try {
      final result = await userRepository.getUsers();
      emit(UserLoadedState(result));
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }
}
