part of 'add_transaction_form_bloc.dart';

class AddTransactionFormState extends Equatable {
  final repository.TransactionPurpose? purpose;
  final Amount amount;
  final CardId card;
  final Title title;
  final Note note;
  final repository.Transaction transaction;
  final Created created;
  final FormzStatus status;
  final Mode mode;

  const AddTransactionFormState._({
    this.purpose,
    required this.created,
    required this.amount,
    required this.card,
    required this.title,
    required this.note,
    required this.status,
    required this.transaction,
    required this.mode,
  });

  factory AddTransactionFormState.add() {
    return AddTransactionFormState._(
      amount: const Amount.pure(),
      card: CardId.pure(),
      note: const Note.pure(),
      title: const Title.pure(),
      status: FormzStatus.pure,
      transaction: repository.Transaction.empty,
      created: Created.pure(),
      mode: Mode.add,
    );
  }

  factory AddTransactionFormState.edit({required repository.Transaction transaction, required List<CredictCard> cards}) {
    return AddTransactionFormState._(
      amount: Amount.pure(transaction.amount.toString()),
      card: CardId.pure(
        cards.firstWhere((element) => element.id == transaction.cardId, orElse: () => CredictCard.empty()),
      ),
      title: Title.pure(transaction.title),
      note: Note.pure(transaction.note),
      status: FormzStatus.pure,
      transaction: transaction,
      created: Created.pure(transaction.created!),
      purpose: transaction.purpose,
      mode: Mode.edit,
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
      transaction,
      created,
      status,
      mode,
    ];
  }

  AddTransactionFormState copyWith({
    repository.TransactionPurpose? purpose,
    Amount? amount,
    CardId? card,
    Title? title,
    Note? note,
    repository.Transaction? transaction,
    Created? created,
    FormzStatus? status,
    Mode? mode,
  }) {
    return AddTransactionFormState._(
      purpose: purpose ?? this.purpose,
      amount: amount ?? this.amount,
      card: card ?? this.card,
      title: title ?? this.title,
      note: note ?? this.note,
      transaction: transaction ?? this.transaction,
      created: created ?? this.created,
      status: status ?? this.status,
      mode: mode ?? this.mode,
    );
  }
}
