import 'package:formz/formz.dart';

enum BalanceValidationError { invalid }

class Balance extends FormzInput<String, BalanceValidationError> {
  const Balance.pure([String value = '']) : super.pure(value);
  const Balance.dirty([String value = '']) : super.dirty(value);

  @override
  BalanceValidationError validator(String value) {
    if (value == null || value.isEmpty) {
      return BalanceValidationError.invalid;
    } else if (num.parse(value, (error) {
          return null;
        }) ==
        null) {
      return BalanceValidationError.invalid;
    } else {
      return null;
    }
  }
}
