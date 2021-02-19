import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/repositories/authentication_repository/src/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:card_docker/repositories/authentication_repository/authentication_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({@required FirebaseAuthenticationRepository firebaseAuthenticationRepository})
      : assert(firebaseAuthenticationRepository != null),
        _authenticationRepository = firebaseAuthenticationRepository,
        super(AuthState.initial());

  final FirebaseAuthenticationRepository _authenticationRepository;
  StreamSubscription _authSubscription;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      _mapAppStartedToState();
    } else if (event is AuthStatusUpdated) {
      yield* _mapAuthStatusUpdatedToState(event);
    } else if (event is LogoutRequested) {
      _authenticationRepository.logout();
    }
  }

  void _mapAppStartedToState() {
    _authSubscription?.cancel();
    _authSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthStatusUpdated(user)),
    );
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }

  Stream<AuthState> _mapAuthStatusUpdatedToState(AuthStatusUpdated event) async* {
    if (event.user != null) {
      yield AuthState(
        status: AuthStatus.authenticated,
        user: event.user,
      );
    } else {
      yield AuthState(
        user: User.empty,
        status: AuthStatus.authenticated,
      );
    }
  }
}
