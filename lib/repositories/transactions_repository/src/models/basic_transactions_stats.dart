import 'package:card_docker/repositories/transactions_repository/src/models/models.dart';
import 'package:equatable/equatable.dart';

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

  final Transaction? lastTransactionAdded;

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
    this.lastTransactionAdded,
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
    );
  }
}
