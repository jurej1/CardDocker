import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/models/display_name.dart';
import 'package:card_docker/models/email.dart';
import 'package:card_docker/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';

class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {
  SignUpFormBloc() : super(SignUpFormState());

  @override
  Stream<SignUpFormState> mapEventToState(
    SignUpFormEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
