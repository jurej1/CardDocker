import 'package:card_docker/repositories/transactions_repository/src/models/models.dart';

abstract class TransactionsRepository {
  Future<void> addTransaction(Transaction transaction);

  Future<void> deleteTransaction(Transaction transaction);

  Future<void> updateTransaction({required Transaction transaction, required Transaction oldTransaction});

  Stream<List<Transaction>?> getTransactions(String userId);

  BasicTransactionsStats getBasicTransactionsStats(List<Transaction> transactions);
}
