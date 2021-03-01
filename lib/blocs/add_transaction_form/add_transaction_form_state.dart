part of 'add_transaction_form_bloc.dart';

class AddTransactionFormState extends Equatable {
  final TransactionPurpose purpose;
  final Amount balance;
  final CardId cardId;
  final Title title;
  final Note note;
  final FormzStatus status;

  const AddTransactionFormState({
    this.purpose,
    this.balance,
    this.cardId,
    this.title,
    this.note,
    this.status,
  });

  factory AddTransactionFormState.initial() {
    return AddTransactionFormState(
        balance: Amount.pure(),
        cardId: CardId.pure(),
        note: Note.pure(),
        purpose: TransactionPurpose.none,
        title: Title.pure(),
        status: FormzStatus.pure);
  }

  @override
  List<Object> get props {
    return [
      purpose,
      balance,
      cardId,
      title,
      note,
      status,
    ];
  }

  AddTransactionFormState copyWith({
    TransactionPurpose purpose,
    Amount balance,
    CardId cardId,
    Title title,
    Note note,
    FormzStatus status,
  }) {
    return AddTransactionFormState(
      purpose: purpose ?? this.purpose,
      balance: balance ?? this.balance,
      cardId: cardId ?? this.cardId,
      title: title ?? this.title,
      note: note ?? this.note,
      status: status ?? this.status,
    );
  }
}
