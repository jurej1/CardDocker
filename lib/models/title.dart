import 'package:formz/formz.dart';

enum TitleValidationError { invalid }

class Title extends FormzInput<String, TitleValidationError> {
  const Title.dirty([String value = '']) : super.dirty(value);
  const Title.pure([String value = '']) : super.pure(value);

  @override
  TitleValidationError validator(String value) {
    if (value.isEmpty) {
      return TitleValidationError.invalid;
    } else if (value.length > 100) {
      return TitleValidationError.invalid;
    } else {
      return null;
    }
  }
}
