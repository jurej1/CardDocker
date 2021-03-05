part of 'add_transaction_form_bloc.dart';

class AddTransactionFormState extends Equatable {
  final TransactionPurpose? purpose;
  final Amount amount;
  final CardId card;
  final Title title;
  final Note note;
  final Transaction transaction;
  final FormzStatus status;

  const AddTransactionFormState._({
    this.purpose,
    required this.amount,
    required this.card,
    required this.title,
    required this.note,
    required this.status,
    required this.transaction,
  });

  factory AddTransactionFormState.add() {
    return AddTransactionFormState._(
      amount: const Amount.pure(),
      card: const CardId.pure(),
      note: const Note.pure(),
      title: const Title.pure(),
      status: FormzStatus.pure,
      transaction: Transaction.empty,
    );
  }

  factory AddTransactionFormState.edit(Transaction transaction) {
    return AddTransactionFormState._(
      amount: Amount.pure(transaction.amount.toString()),
      card: CardId.pure(transaction.cardId),
      title: Title.pure(transaction.title),
      note: Note.pure(transaction.note),
      status: FormzStatus.pure,
      transaction: transaction,
    );
  }

  @override
  List<Object?> get props {
    return [
      purpose,
      amount,
      card,
      title,
      note,
      status,
    ];
  }

  AddTransactionFormState copyWith({
    TransactionPurpose? purpose,
    Amount? amount,
    CardId? card,
    Title? title,
    Note? note,
    Transaction? transaction,
    FormzStatus? status,
  }) {
    return AddTransactionFormState._(
      purpose: purpose ?? this.purpose,
      amount: amount ?? this.amount,
      card: card ?? this.card,
      title: title ?? this.title,
      note: note ?? this.note,
      transaction: transaction ?? this.transaction,
      status: status ?? this.status,
    );
  }
}
