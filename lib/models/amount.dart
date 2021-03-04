import 'package:formz/formz.dart';

enum AmountValidationError { invalid }

class Amount extends FormzInput<String, AmountValidationError> {
  const Amount.pure([String value = '']) : super.pure(value);
  const Amount.dirty([String value = '']) : super.dirty(value);

  @override
  AmountValidationError? validator(String value) {
    if (value.isEmpty) {
      return AmountValidationError.invalid;
    } else {
      return null;
    }
  }
}
