import 'package:cloud_firestore/cloud_firestore.dart' as fb;

import 'package:card_docker/repositories/transactions_repository/src/entities/entities.dart';
import 'package:card_docker/repositories/transactions_repository/src/models/transaction.dart';
import 'package:card_docker/repositories/transactions_repository/src/transactions_repository.dart';

class FirebaseTransactionsRepository implements TransactionsRepository {
  final _transactionsRef = fb.FirebaseFirestore.instance.collection('transaction');
  final _cardsRef = fb.FirebaseFirestore.instance.collection('credict_cards');

  @override
  Future<void> addTransaction(Transaction transaction) async {
    try {
      await _transactionsRef.add(transaction.toEntity().toDocument());
      await _cardsRef.doc(transaction.cardId).update({
        'balance': fb.FieldValue.increment(transaction.amount),
      });
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> deleteTransaction(Transaction transaction) async {
    try {
      await _transactionsRef.doc(transaction.id!).delete();
      await _cardsRef.doc(transaction.cardId).update(
        {
          'balance': fb.FieldValue.increment(transaction.amount),
        },
      );
    } catch (e) {
      throw e;
    }
  }

  @override
  Stream<List<Transaction>?> getTransactions(String userId) {
    return _transactionsRef.where('ownerId', isEqualTo: userId).orderBy('created').snapshots().map((snapshot) {
      if (snapshot.docs.isEmpty) {
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
    });
  }

  @override
  Future<void> updateTransaction({required Transaction transaction, required Transaction oldTransaction}) async {
    try {
      await _transactionsRef.doc(transaction.id!).update(transaction.toEntity().toDocument());

      if (transaction.amount != oldTransaction.amount) {
        final diff = transaction.amount - oldTransaction.amount;

        await _cardsRef.doc(transaction.cardId).update({
          'balance': fb.FieldValue.increment(diff),
        });
      }
    } catch (e) {
      throw e;
    }
  }
}
