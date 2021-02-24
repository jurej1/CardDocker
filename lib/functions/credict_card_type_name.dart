import 'package:card_docker/repositories/credict_cards_repository/src/enums/credict_card_type.dart';

String credictCardTypeName(CredictCardType type) {
  if (type == CredictCardType.business) {
    return 'Business Card';
  } else if (type == CredictCardType.credict) {
    return 'Credict Card';
  } else if (type == CredictCardType.debit) {
    return 'Debit Card';
  } else if (type == CredictCardType.none) {
    return 'None';
  } else if (type == CredictCardType.premiumRewards) {
    return 'Premium Rewards Card';
  } else if (type == CredictCardType.retail) {
    return 'Retail Card';
  } else if (type == CredictCardType.rewards) {
    return 'Rewards Card';
  } else if (type == CredictCardType.students) {
    return 'Students Card';
  } else {
    return 'None';
  }
}
