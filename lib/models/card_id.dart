import 'package:formz/formz.dart';

enum CardIdValidationError { invalid }

class CardId extends FormzInput<String, CardIdValidationError> {
  const CardId.pure() : super.pure('');
  const CardId.dirty([String value = '']) : super.dirty(value);

  @override
  CardIdValidationError validator(String value) {
    return value.isEmpty ? CardIdValidationError.invalid : null;
  }
}
