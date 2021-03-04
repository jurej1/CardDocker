import 'package:card_docker/repositories/credict_cards_repository/src/models/models.dart';
import 'package:formz/formz.dart';

enum CardIdValidationError { invalid }

class Card extends FormzInput<CredictCard, CardIdValidationError> {
  const Card.pure([CredictCard card = CredictCard.empty]) : super.pure(card);
  const Card.dirty([CredictCard card = CredictCard.empty]) : super.dirty(card);

  @override
  CardIdValidationError? validator(CredictCard value) {
    if (value == CredictCard.empty) {
      return CardIdValidationError.invalid;
    } else {
      return null;
    }
  }
}
