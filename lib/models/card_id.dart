import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:formz/formz.dart';

enum CardIdValidationError { invalid }

class CardId extends FormzInput<CredictCard, CardIdValidationError> {
  CardId.pure([CredictCard? card]) : super.pure(card ?? CredictCard.empty());
  CardId.dirty([CredictCard? card]) : super.dirty(card ?? CredictCard.empty());

  @override
  CardIdValidationError? validator(CredictCard? value) {
    if (value != null && value.id != null) {
      if (value.id!.isNotEmpty) {
        return CardIdValidationError.invalid;
      }
    } else {
      return null;
    }
  }
}
