import 'package:formz/formz.dart';

enum DisplayNameValidationError { invalid }

class DisplayName extends FormzInput<String, DisplayNameValidationError> {
  const DisplayName.pure([String value = '']) : super.pure(value);
  const DisplayName.dirty([String value = '']) : super.dirty(value);

  @override
  DisplayNameValidationError validator(String value) {
    return value.length < 5 ? DisplayNameValidationError.invalid : null;
  }
}
