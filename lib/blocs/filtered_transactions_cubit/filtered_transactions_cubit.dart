import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/blocs/transactions_bloc/transactions_bloc.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/models/models.dart';
import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';
import 'package:equatable/equatable.dart';

part 'filtered_transactions_state.dart';

class FilteredTransactionsCubit extends Cubit<FilteredTransactionsState> {
  FilteredTransactionsCubit({
    required CredictCard credictCard,
    required TransactionsBloc transactionsBloc,
  })   : _transactionsBloc = transactionsBloc,
        super(
          transactionsBloc.state is TransactionsLoadSuccess
              ? FilteredTransactionsLoadSuccess(
                  transactions: (transactionsBloc.state as TransactionsLoadSuccess)
                      .transactions
                      .where((element) => element.cardId == credictCard.id)
                      .toList(),
                )
              : FilteredTransactionsFailure(),
        ) {
    _transactionsSubscription = _transactionsBloc.listen((transactionsState) {
      if (transactionsState is TransactionsLoadSuccess) {
        emit(FilteredTransactionsLoadSuccess(
          transactions: transactionsState.transactions.where((element) => element.cardId == credictCard.id).toList(),
        ));
      } else {
        emit(FilteredTransactionsFailure());
      }
    });
  }

  final TransactionsBloc _transactionsBloc;
  late final StreamSubscription _transactionsSubscription;

  @override
  Future<void> close() {
    _transactionsSubscription.cancel();
    return super.close();
  }
}
