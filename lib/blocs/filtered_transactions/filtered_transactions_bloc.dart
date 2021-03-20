import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/models/models.dart';
import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';
import 'package:equatable/equatable.dart';

part 'filtered_transactions_event.dart';
part 'filtered_transactions_state.dart';

class FilteredTransactionsBloc extends Bloc<FilteredTransactionsEvent, FilteredTransactionsState> {
  FilteredTransactionsBloc({
    required this.card,
    required TransactionsBloc transactionsBloc,
  }) : super(
          transactionsBloc.state is TransactionsLoadSuccess
              ? FilteredTransactionsLoadSuccess(
                  transactions: (transactionsBloc.state as TransactionsLoadSuccess)
                      .transactions
                      .where((element) => element.cardId == card.id)
                      .toList(),
                )
              : FilteredTransactionsFailure(),
        );

  final CredictCard card;

  @override
  Stream<FilteredTransactionsState> mapEventToState(
    FilteredTransactionsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
