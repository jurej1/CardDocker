import 'package:card_docker/repositories/credict_cards_repository/src/credict_cards_repository.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/entities/credict_card_entity.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/models/credict_cards_stats.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/models/credict_card.dart';
import 'package:hive/hive.dart';

class HiveCredictCardRepository extends CredictCardsRepository {
  const HiveCredictCardRepository({
    required Box<List<CredictCard>> hiveBox,
  }) : _databaseBox = hiveBox;

  final Box<List<CredictCard>> _databaseBox;

  @override
  Future<void> addCredictCard(CredictCard credictCard) {
    final currentHiveCards = _databaseBox.get(credictCard.ownerId!, defaultValue: []);
    var credictCards = currentHiveCards;
    CredictCard newCard = credictCard.copyWith(
      created: DateTime.now(),
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    if (credictCards!.isEmpty) {
      credictCards.add(newCard);
    } else {
      credictCards.insert(0, newCard);
    }

    return _databaseBox.put(credictCard.ownerId, credictCards);
  }

  @override
  Stream<List<CredictCard>> cards(String userId) {
    return _databaseBox.watch(key: userId).map((event) {
      return _databaseBox.get(userId, defaultValue: [])!;
    });
  }

  @override
  Future<void> deleteCredictCard(CredictCard credictCard) {
    var credictCards = _databaseBox.get(credictCard.ownerId)!;
    if (credictCards.contains(credictCard)) {
      credictCards.removeWhere((element) => element.id == credictCard.id);
    }

    return _databaseBox.put(credictCard.ownerId, credictCards);
  }

  @override
  CredictCardsStats getCredictCardStats(List<CredictCard> cards) {
    return CredictCardsStats.empty;
  }

  @override
  Future<void> updateCredictCard(CredictCard credictCard) {
    final cards = _databaseBox.get(credictCard.ownerId, defaultValue: [])!;

    var updatedCards = cards.map((e) {
      if (e.id == credictCard.id) {
        return credictCard;
      }
      return e;
    }).toList();

    return _databaseBox.put(credictCard.id, updatedCards);
  }
}
