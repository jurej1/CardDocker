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

  BasicTransactionsStats({
    this.biggestTransaction = 0,
    this.smallestTranasction = 0,
    this.numOfTransactions = 0,
    this.numTotalPositiveTransactions = 0,
    this.numTotalNegativeTransactions = 0,
    this.totalCashFlow = 0,
    this.totalPositiveCashFlow = 0,
    this.totalNegativeCashFlow = 0,
    this.numTransactionsThisMonth = 0,
    this.numTransactionsThisWeek = 0,
    this.lastTransactionAdded,
  });

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
