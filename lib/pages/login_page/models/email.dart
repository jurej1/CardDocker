import 'package:formz/formz.dart';

enum EmailValidationerror { invalid }

class Email extends FormzInput<String, EmailValidationerror> {
  const Email.pure([String value = '']) : super.pure(value);
  const Email.dirty([String value = '']) : super.dirty(value);

  static const pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  EmailValidationerror validator(String value) {
    return RegExp(pattern).hasMatch(value) ? null : EmailValidationerror.invalid;
  }
}
