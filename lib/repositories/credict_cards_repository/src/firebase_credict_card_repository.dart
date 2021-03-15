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
    final credictCardStats = CredictCardsStats.empty;
    final double totalBalance = cards.fold(0.0, (previousValue, element) {
      return previousValue + element.balance;
    });
    final double average = totalBalance / cards.length;

    return credictCardStats.copyWith(
      numOfCards: cards.length,
      purposeStats: _getCardTypes(cards),
      averageBalance: average,
      biggestBalance: _biggestBalance(cards),
      smallestBalance: _smallestBalance(cards),
    );
  }

  double _biggestBalance(List<CredictCard> cards) {
    return cards.reduce((a, b) => a.balance > b.balance ? a : b).balance;
  }

  double _smallestBalance(List<CredictCard> cards) {
    return cards.reduce((a, b) => a.balance < b.balance ? a : b).balance;
  }

  List<CardTypeStat> _getCardTypes(List<CredictCard> cards) {
    final List<CredictCardType> cardsTransformed = cards.map((e) => e.type).toList();

    final List<CredictCardType> originalTypes = CredictCardType.values;
    List<CardTypeStat> cardsTypes = [];

    for (int i = 0; i < originalTypes.length; i++) {
      int amount = cardsTransformed.fold(0, (previousValue, element) {
        if (element == originalTypes[i]) {
          return previousValue + 1;
        }
        return previousValue;
      });

      if (amount > 0) {
        cardsTypes.add(
          CardTypeStat(
            type: originalTypes[i],
            numOfCards: amount,
          ),
        );
      }
    }

    return cardsTypes..sort((a, b) => b.numOfCards.compareTo(a.numOfCards));
  }
}
