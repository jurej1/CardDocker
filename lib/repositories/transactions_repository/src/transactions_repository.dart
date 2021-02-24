import 'package:card_docker/repositories/transactions_repository/src/models/models.dart';

abstract class TransactionsRepository {
  Future<void> addTransaction(Transaction transaction);

  Future<void> deleteTransaction(Transaction transaction);

  Future<void> updateTransaction({Transaction transaction, Transaction oldTransaction});

  Stream<List<Transaction>> getTransactions(String userId);
}
