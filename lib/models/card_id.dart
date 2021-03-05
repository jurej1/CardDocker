import 'package:formz/formz.dart';

enum CardIdValidationError { invalid }

class CardId extends FormzInput<String, CardIdValidationError> {
  const CardId.pure([String cardId = '']) : super.pure(cardId);
  const CardId.dirty([String cardId = '']) : super.dirty(cardId);

  @override
  CardIdValidationError? validator(String? value) {
    if (value!.isEmpty) {
      return CardIdValidationError.invalid;
    } else {
      return null;
    }
  }
}
