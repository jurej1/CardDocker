part of 'transactions_bloc.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object?> get props => [];
}

class LoadTransactions extends TransactionsEvent {
  final String userId;

  const LoadTransactions(this.userId);

  @override
  List<Object> get props => [userId];
}

class TransactionsUpdated extends TransactionsEvent {
  final List<Transaction>? transactions;

  const TransactionsUpdated(this.transactions);
  @override
  List<Object?> get props => [transactions];
}

class DeleteTransaction extends TransactionsEvent {
  final Transaction transaction;

  const DeleteTransaction(this.transaction);

  @override
  List<Object> get props => [transaction];
}
