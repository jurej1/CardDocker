import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc({@required FirebaseTransactionsRepository firebaseTransactionsRepository})
      : _firebaseTransactionsRepository = firebaseTransactionsRepository,
        super(TransactionsLoading());

  final FirebaseTransactionsRepository _firebaseTransactionsRepository;
  StreamSubscription _transactionsSubscription;

  @override
  Stream<TransactionsState> mapEventToState(
    TransactionsEvent event,
  ) async* {
    if (event is LoadTransactions) {
      _mapLoadTransactionsToState(event);
    } else if (event is TransactionsUpdated) {
      yield _mapTransactionsUpdatedToState(event);
    } else if (event is DeleteTransaction) {
      _firebaseTransactionsRepository.deleteTransaction(event.transaction);
    }
  }

  TransactionsState _mapTransactionsUpdatedToState(TransactionsUpdated event) {
    if (event.transactions == null) {
      return TransactionsLoadSuccess();
    } else {
      return TransactionsLoadSuccess(transactions: event.transactions);
    }
  }

  void _mapLoadTransactionsToState(LoadTransactions event) {
    _transactionsSubscription = _firebaseTransactionsRepository.getTransactions(event.userId).listen((transactions) {
      add(TransactionsUpdated(transactions));
    });
  }

  @override
  Future<void> close() {
    _transactionsSubscription.cancel();
    return super.close();
  }
}
