import 'package:formz/formz.dart';
import 'package:regexpattern/regexpattern.dart' as reg;

enum PasswordValidationError { toShort, invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError validator(String value) {
    if (value.length < 6) {
      return PasswordValidationError.toShort;
    } else {
      return reg.RegVal.hasMatch(value, reg.RegexPattern.passwordNormal2) ? null : PasswordValidationError.invalid;
    }
  }
}
