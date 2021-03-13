import 'package:card_docker/repositories/transactions_repository/src/models/basic_transactions_stats.dart';
import 'package:card_docker/repositories/transactions_repository/src/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fb;

import 'package:card_docker/repositories/transactions_repository/src/entities/entities.dart';
import 'package:card_docker/repositories/transactions_repository/src/models/transaction.dart';
import 'package:card_docker/repositories/transactions_repository/src/transactions_repository.dart';
import 'package:jiffy/jiffy.dart' as jiffy;

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

    double totalCashFlow = _totalCashFlow(transactions);
    double totalPositiveCashFlow = _totalPositiveCashFlow(transactions);
    double totalNegativeCashFlow = (totalCashFlow - totalPositiveCashFlow) * -1;

    List<TransactionPurposeStat> purposeStats = _transactionPurposeStats(transactions);

    Map<String, int> numOfTransactionsOverTime = _transactionsQuantityOverTime(transactions);
    int numTransactionsThisMonth = numOfTransactionsOverTime['month']!;
    int numTransactionsThisWeeek = numOfTransactionsOverTime['week']!;
    int numTransactionsToday = numOfTransactionsOverTime['day']!;

    List<WeekTransactionData> byWeek = _transactionsByWeek(transactions);

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
      transactionsByWeek: byWeek,
    );
  }

  double _totalCashFlow(List<Transaction> transactions) {
    return transactions.fold(0, (cashFlow, element) {
      double amount = element.amount.toDouble();
      if (amount.isNegative) {
        amount *= -1;
      }
      return cashFlow += amount;
    });
  }

  double _totalPositiveCashFlow(List<Transaction> transactions) {
    return transactions.fold(0, (cashFlow, element) {
      if (!element.amount.isNegative) {
        return cashFlow += element.amount.toDouble();
      }
      return cashFlow;
    });
  }

  List<TransactionPurposeStat> _transactionPurposeStats(List<Transaction> transactions) {
    List<TransactionPurposeStat> purposeStats = [];

    transactions.forEach((stat) {
      final bool containsData = purposeStats.any((element) {
        return element.purpose == stat.purpose;
      });

      if (!containsData) {
        int amount = transactions.fold(0, (previousValue, element) {
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

    return purposeStats;
  }

  Map<String, int> _transactionsQuantityOverTime(List<Transaction> transactions) {
    Map<String, int> numOfTransactions = {'month': 0, 'week': 0, 'day': 0};

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

    numOfTransactions['month'] = numTransactionsThisMonth;
    numOfTransactions['week'] = numTransactionsThisWeeek;
    numOfTransactions['day'] = numTransactionsToday;

    return numOfTransactions;
  }

  // List<PeriodTransactions> _transactionsByWeek(List<Transaction> transactions) {
  //   final int length = 7;
  //   int loweerBounce = 7;
  //   int upperBounce = 0;
  //   final currentDate = DateTime.now();
  //   List<PeriodTransactions> byWeek = [];

  //   for (int i = 0; i < length; i++) {
  //     int quantity = transactions.fold(0, (previousValue, element) {
  //       final created = element.created!;
  //       final lowerDate = currentDate.subtract(Duration(days: loweerBounce));
  //       final upperDate = currentDate.subtract(Duration(days: upperBounce));

  //       bool isFit = created.isAfter(lowerDate) && created.isBefore(upperDate);

  //       if (isFit) {
  //         return previousValue + 1;
  //       } else {
  //         return previousValue;
  //       }
  //     });

  //     byWeek.add(
  //       PeriodTransactions(
  //         period: currentDate.subtract(Duration(days: loweerBounce)),
  //         count: quantity,
  //       ),
  //     );

  //     upperBounce = loweerBounce;
  //     loweerBounce += 7;
  //   }

  //   return byWeek;
  // }
  List<WeekTransactionData> _transactionsByWeek(List<Transaction> transactions) {
    final int length = 7;
    int substract = 0;
    final currentDate = DateTime.now();
    List<WeekTransactionData> byWeek = [];

    for (int i = 0; i < length; i++) {
      final int currentWeek = jiffy.Jiffy(currentDate).week - substract;
      int quantity = transactions.fold(0, (previousValue, element) {
        final int elementWeek = jiffy.Jiffy(element.created!).week;

        if (currentWeek == elementWeek) {
          return previousValue + 1;
        }

        return previousValue;
      });

      byWeek.add(
        WeekTransactionData(
          count: quantity,
          weekNumber: currentWeek,
        ),
      );
    }

    return byWeek;
  }
}
