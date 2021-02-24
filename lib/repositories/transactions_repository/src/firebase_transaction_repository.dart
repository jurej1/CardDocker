import 'package:card_docker/repositories/transactions_repository/src/entities/entities.dart';
import 'package:card_docker/repositories/transactions_repository/src/models/transaction.dart';
import 'package:card_docker/repositories/transactions_repository/src/transactions_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fb;

class FirebaseTransactionsRepository implements TransactionsRepository {
  final _transactionsRef = fb.FirebaseFirestore.instance.collection('transaction');

  @override
  Future<void> addTransaction(Transaction transaction) async {
    return _transactionsRef.add(transaction.toEntity().toDocument());
  }

  @override
  Future<void> deleteTransaction(Transaction transaction) {
    return _transactionsRef.doc(transaction.id).delete();
  }

  @override
  Stream<List<Transaction>> getTransactions(String userId) {
    return _transactionsRef.where('ownerId', isEqualTo: userId).orderBy('created').snapshots().map((snapshot) {
      if (snapshot.docs == null || snapshot.docs.isEmpty) {
        return null;
      } else {
        List<Transaction> transactions = [];
        snapshot.docs.forEach((doc) {
          var entity = TransactionEntity.fromDocument(doc);
          if (transactions.isEmpty) {
            transactions.add(Transaction.fromEntity(entity));
          } else {
            transactions.insert(0, Transaction.fromEntity(entity));
          }
        });
        return transactions;
      }
    }).;
  }

  @override
  Future<void> updateTransaction(Transaction transaction) {
    return _transactionsRef.doc(transaction.id).update(transaction.toEntity().toDocument());
  }
}
