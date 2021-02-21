import 'package:card_docker/repositories/credict_cards_repository/src/credict_cards_repository.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/entities/credict_card_entity.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/models/credict_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCredictCardRepository implements CredictCardsRepository {
  final cardsRef = FirebaseFirestore.instance.collection('credict_cards');

  @override
  Future<void> addCredictCard(CredictCard credictCard) {
    return cardsRef.add(credictCard.toEntity().toDocument());
  }

  @override
  Stream<List<CredictCard>> cards(String userId) {
    return cardsRef.orderBy('created').where('ownerId', isEqualTo: userId).snapshots().map((snapshot) {
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
    return cardsRef.doc(credictCard.id).delete();
  }

  @override
  Future<void> updateCredictCard(CredictCard credictCard) {
    return cardsRef.doc(credictCard.id).update(credictCard.toEntity().toDocument());
  }
}
