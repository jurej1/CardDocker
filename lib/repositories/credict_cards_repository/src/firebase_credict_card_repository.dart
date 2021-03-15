import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/credict_cards_repository.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/entities/credict_card_entity.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/models/credict_card.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/models/credict_cards_stats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCredictCardRepository implements CredictCardsRepository {
  final _cardsRef = FirebaseFirestore.instance.collection('credict_cards');

  @override
  Future<void> addCredictCard(CredictCard credictCard) {
    return _cardsRef.add(credictCard.toEntity().toDocument());
  }

  @override
  Stream<List<CredictCard>> cards(String userId) {
    return _cardsRef.orderBy('created').where('ownerId', isEqualTo: userId).snapshots().map((snapshot) {
      List<CredictCard> cards = [];

      snapshot.docs.forEach((doc) {
        final card = CredictCard.fromEntity(CredictCardEntity.fromDocument(doc));
        if (cards.isEmpty) {
          cards.add(card);
        } else {
          cards.insert(0, card);
        }
      });

      return cards;
    });
  }

  @override
  Future<void> deleteCredictCard(CredictCard credictCard) {
    return _cardsRef.doc(credictCard.id!).delete();
  }

  @override
  Future<void> updateCredictCard(CredictCard credictCard) {
    return _cardsRef.doc(credictCard.id!).update(credictCard.toEntity().toDocument());
  }

  @override
  CredictCardsStats getCredictCardStats(List<CredictCard> cards) {
    List<CardTypeStat> cardsTypes = [];

    cards.forEach((element) {
      final cardType = cardsTypes.indexWhere((stat) => stat.type == element.type);

      if (cardType < 0) {
        cardsTypes.add(
          CardTypeStat(type: element.type, numOfCards: 1),
        );
      } else {
        cardsTypes = cardsTypes.map((e) {
          if (e.type == element.type) {
            return CardTypeStat(
              type: e.type,
              numOfCards: (e.numOfCards + 1),
            );
          } else {
            return e;
          }
        }).toList();
      }
    });

    final double totalBalance = cards.fold(20, (previousValue, element) {
      return previousValue + element.balance;
    });

    final double average = totalBalance / cards.length;

    return CredictCardsStats(
      numOfCards: cards.length,
      purposeStats: cardsTypes,
      averageBalance: average,
    );
  }
}
