import 'models/models.dart';

abstract class CredictCardsRepository {
  Stream<List<CredictCard>> cards(String userId);

  Future<void> addCredictCard(CredictCard credictCard);

  Future<void> deleteCredictCard(CredictCard credictCard);

  Future<void> updateCredictCard(CredictCard credictCard);
}
