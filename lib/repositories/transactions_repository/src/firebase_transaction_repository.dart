import 'package:card_docker/repositories/transactions_repository/src/models/basic_transactions_stats.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fb;

import 'package:card_docker/repositories/transactions_repository/src/entities/entities.dart';
import 'package:card_docker/repositories/transactions_repository/src/models/transaction.dart';
import 'package:card_docker/repositories/transactions_repository/src/transactions_repository.dart';

import 'models/transaction_purpose_stat.dart';

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

  @override
  BasicTransactionsStats getBasicTransactionsStats(List<Transaction> transactions) {
    var stats = BasicTransactionsStats.empty;

    List<num> amountList = transactions.map((e) => e.amount).toList();
    double biggestTransaction = amountList.reduce((current, next) => current > next ? current : next).toDouble();
    double smallestTransaction = amountList.reduce((current, next) => current > next ? next : current).toDouble();

    int numOfPositiveTransactions = transactions.where((element) => !element.amount.isNegative).toList().length;
    int numNegativeTransacions = transactions.length - numOfPositiveTransactions;

    double totalCashFlow = transactions.fold(0, (cashFlow, element) {
      double amount = element.amount.toDouble();
      if (amount.isNegative) {
        amount *= -1;
      }
      return cashFlow += amount;
    });
    double totalPositiveCashFlow = transactions.fold(0, (cashFlow, element) {
      if (!element.amount.isNegative) {
        return cashFlow += element.amount.toDouble();
      }
      return cashFlow;
    });
    double totalNegativeCashFlow = (totalCashFlow - totalPositiveCashFlow) * -1;

    final DateTime currentDate = DateTime.now();
    DateTime minMonthDate = currentDate.subtract(const Duration(days: 30));
    int numTransactionsThisMonth = 0;
    DateTime minWeekDate = currentDate.subtract(const Duration(days: 7));
    int numTransactionsThisWeeek = 0;
    DateTime minDayDate = currentDate.subtract(const Duration(hours: 24));
    int numTransactionsToday = 0;

    transactions.forEach((element) {
      if (element.created != null) {
        if (element.created!.isAfter(minMonthDate)) {
          numTransactionsThisMonth += 1;
        }
        if (element.created!.isAfter(minWeekDate)) {
          numTransactionsThisWeeek += 1;
        }
        if (element.created!.isAfter(minDayDate)) {
          numTransactionsToday += 1;
        }
      }
    });

    List<TransactionPurposeStat> transactionPurposeRaw = transactions.map((e) {
      return TransactionPurposeStat(purpose: e.purpose, count: 0);
    }).toList();

    List<TransactionPurposeStat> purposeStats = [];

    transactionPurposeRaw.forEach((stat) {
      if (!purposeStats.contains(stat)) {
        int amount = transactionPurposeRaw.fold(0, (previousValue, element) {
          if (element.purpose == stat.purpose) {
            return previousValue + 1;
          } else {
            return previousValue;
          }
        });

        purposeStats.add(
          TransactionPurposeStat(
            purpose: stat.purpose,
            count: amount,
          ),
        );
      }
    });

    return stats.copyWith(
      biggestTransaction: biggestTransaction,
      smallestTranasction: smallestTransaction,
      lastTransactionAdded: transactions.first,
      numOfTransactions: transactions.length,
      numTotalNegativeTransactions: numNegativeTransacions,
      numTotalPositiveTransactions: numOfPositiveTransactions,
      totalNegativeCashFlow: totalNegativeCashFlow,
      totalPositiveCashFlow: totalPositiveCashFlow,
      numTransactionsThisMonth: numTransactionsThisMonth,
      numTransactionsThisWeek: numTransactionsThisWeeek,
      totalCashFlow: totalCashFlow,
      numTransactionsToday: numTransactionsToday,
      purposeStat: purposeStats,
    );
  }
}
