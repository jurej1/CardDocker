import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:card_docker/repositories/authentication_repository/authentication_repository.dart';
import 'package:card_docker/repositories/authentication_repository/src/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required FirebaseAuthenticationRepository firebaseAuthenticationRepository})
      : _authenticationRepository = firebaseAuthenticationRepository,
        super(Loading());

  final FirebaseAuthenticationRepository _authenticationRepository;
  late StreamSubscription _authSubscription;

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
    _authSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthStatusUpdated(user!)),
    );
  }

  Stream<AuthState> _mapAuthStatusUpdatedToState(AuthStatusUpdated event) async* {
    if (event.user != null) {
      yield Authenticated(event.user!);
    } else {
      yield Unauthenticated();
    }
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
