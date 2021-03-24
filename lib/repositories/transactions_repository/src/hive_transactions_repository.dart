import 'package:card_docker/repositories/transactions_repository/src/models/transaction.dart';
import 'package:card_docker/repositories/transactions_repository/src/models/basic_transactions_stats.dart';
import 'package:card_docker/repositories/transactions_repository/src/transactions_repository.dart';

class HiveTransactionsRepository extends TransactionsRepository {
  @override
  Future<void> addTransaction(Transaction transaction) {
    // TODO: implement addTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTransaction(Transaction transaction) {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

  @override
  BasicTransactionsStats getBasicTransactionsStats(List<Transaction> transactions) {
    // TODO: implement getBasicTransactionsStats
    throw UnimplementedError();
  }

  @override
  Stream<List<Transaction>?> getTransactions(String userId) {
    // TODO: implement getTransactions
    throw UnimplementedError();
  }

  @override
  Future<void> updateTransaction({required Transaction transaction, required Transaction oldTransaction}) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }
}
