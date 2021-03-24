import 'models/models.dart';

abstract class CredictCardsRepository {
  const CredictCardsRepository();

  Stream<List<CredictCard>> cards(String userId);

  Future<void> addCredictCard(CredictCard credictCard);

  Future<void> deleteCredictCard(CredictCard credictCard);

  Future<void> updateCredictCard(CredictCard credictCard);

  CredictCardsStats getCredictCardStats(List<CredictCard> cards);
}
