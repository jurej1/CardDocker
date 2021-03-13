import 'package:card_docker/repositories/transactions_repository/src/models/models.dart';
import 'package:equatable/equatable.dart';

import 'transaction_purpose_stat.dart';

class BasicTransactionsStats extends Equatable {
  final double biggestTransaction;
  final double smallestTranasction;

  final int numOfTransactions;
  final int numTotalPositiveTransactions;
  final int numTotalNegativeTransactions;

  final double totalCashFlow;
  final double totalPositiveCashFlow;
  final double totalNegativeCashFlow;

  final int numTransactionsThisMonth;
  final int numTransactionsThisWeek;
  final int numTransactionsToday;

  final Transaction? lastTransactionAdded;

  final List<TransactionPurposeStat> purposeStats;

  final List<PeriodTransactionData> transactionsByWeek;
  final List<PeriodTransactionData> transactionsByMonth;
  final List<PeriodTransactionData> transactionsByDay;

  const BasicTransactionsStats({
    required this.biggestTransaction,
    required this.smallestTranasction,
    required this.numOfTransactions,
    required this.numTotalPositiveTransactions,
    required this.numTotalNegativeTransactions,
    required this.totalCashFlow,
    required this.totalPositiveCashFlow,
    required this.totalNegativeCashFlow,
    required this.numTransactionsThisMonth,
    required this.numTransactionsThisWeek,
    required this.numTransactionsToday,
    this.lastTransactionAdded,
    required this.purposeStats,
    required this.transactionsByWeek,
    required this.transactionsByMonth,
    required this.transactionsByDay,
  });

  static const empty = BasicTransactionsStats(
    biggestTransaction: 0,
    smallestTranasction: 0,
    numOfTransactions: 0,
    numTotalPositiveTransactions: 0,
    numTotalNegativeTransactions: 0,
    totalCashFlow: 0,
    totalPositiveCashFlow: 0,
    totalNegativeCashFlow: 0,
    numTransactionsThisMonth: 0,
    numTransactionsThisWeek: 0,
    numTransactionsToday: 0,
    purposeStats: const [],
    transactionsByWeek: const [],
    transactionsByMonth: const [],
    transactionsByDay: const [],
  );

  bool get isEmpty {
    var stats = BasicTransactionsStats(
      biggestTransaction: biggestTransaction,
      smallestTranasction: smallestTranasction,
      numOfTransactions: numOfTransactions,
      numTotalPositiveTransactions: numTotalPositiveTransactions,
      numTotalNegativeTransactions: numTotalNegativeTransactions,
      totalCashFlow: totalCashFlow,
      totalPositiveCashFlow: totalPositiveCashFlow,
      totalNegativeCashFlow: totalNegativeCashFlow,
      numTransactionsThisMonth: numTransactionsThisMonth,
      numTransactionsThisWeek: numTransactionsThisWeek,
      numTransactionsToday: numTransactionsToday,
      purposeStats: purposeStats,
      transactionsByWeek: transactionsByWeek,
      transactionsByDay: transactionsByDay,
      transactionsByMonth: transactionsByMonth,
    );

    return stats == empty;
  }

  bool get isNotEmpty => !isEmpty;

  @override
  List<Object?> get props {
    return [
      biggestTransaction,
      smallestTranasction,
      numOfTransactions,
      numTotalPositiveTransactions,
      numTotalNegativeTransactions,
      totalCashFlow,
      totalPositiveCashFlow,
      totalNegativeCashFlow,
      numTransactionsThisMonth,
      numTransactionsThisWeek,
      lastTransactionAdded,
      numTransactionsToday,
      purposeStats,
      transactionsByWeek,
      transactionsByDay,
      transactionsByMonth,
    ];
  }

  BasicTransactionsStats copyWith({
    double? biggestTransaction,
    double? smallestTranasction,
    int? numOfTransactions,
    int? numTotalPositiveTransactions,
    int? numTotalNegativeTransactions,
    double? totalCashFlow,
    double? totalPositiveCashFlow,
    double? totalNegativeCashFlow,
    int? numTransactionsThisMonth,
    int? numTransactionsThisWeek,
    Transaction? lastTransactionAdded,
    int? numTransactionsToday,
    List<TransactionPurposeStat>? purposeStat,
    List<PeriodTransactionData>? transactionsByWeek,
    List<PeriodTransactionData>? transactionsByDay,
    List<PeriodTransactionData>? transactionsByMonth,
  }) {
    return BasicTransactionsStats(
      biggestTransaction: biggestTransaction ?? this.biggestTransaction,
      smallestTranasction: smallestTranasction ?? this.smallestTranasction,
      numOfTransactions: numOfTransactions ?? this.numOfTransactions,
      numTotalPositiveTransactions: numTotalPositiveTransactions ?? this.numTotalPositiveTransactions,
      numTotalNegativeTransactions: numTotalNegativeTransactions ?? this.numTotalNegativeTransactions,
      totalCashFlow: totalCashFlow ?? this.totalCashFlow,
      totalPositiveCashFlow: totalPositiveCashFlow ?? this.totalPositiveCashFlow,
      totalNegativeCashFlow: totalNegativeCashFlow ?? this.totalNegativeCashFlow,
      numTransactionsThisMonth: numTransactionsThisMonth ?? this.numTransactionsThisMonth,
      numTransactionsThisWeek: numTransactionsThisWeek ?? this.numTransactionsThisWeek,
      lastTransactionAdded: lastTransactionAdded ?? this.lastTransactionAdded,
      numTransactionsToday: numTransactionsToday ?? this.numTransactionsToday,
      purposeStats: purposeStat ?? this.purposeStats,
      transactionsByWeek: transactionsByWeek ?? this.transactionsByWeek,
      transactionsByDay: transactionsByDay ?? this.transactionsByDay,
      transactionsByMonth: transactionsByMonth ?? this.transactionsByMonth,
    );
  }
}
