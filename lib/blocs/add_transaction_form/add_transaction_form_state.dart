part of 'add_transaction_form_bloc.dart';

class AddTransactionFormState extends Equatable {
  final TransactionPurpose purpose;
  final Amount amount;
  final CardId cardId;
  final Title title;
  final Note note;
  final FormzStatus status;

  const AddTransactionFormState({
    this.purpose,
    this.amount,
    this.cardId,
    this.title,
    this.note,
    this.status,
  });

  factory AddTransactionFormState.initial() {
    return AddTransactionFormState(
      amount: const Amount.pure(),
      cardId: const CardId.pure(),
      note: const Note.pure(),
      purpose: TransactionPurpose.none,
      title: const Title.pure(),
      status: const FormzStatus.pure,
    );
  }

  @override
  List<Object> get props {
    return [
      purpose,
      amount,
      cardId,
      title,
      note,
      status,
    ];
  }

  AddTransactionFormState copyWith({
    TransactionPurpose purpose,
    Amount amount,
    CardId cardId,
    Title title,
    Note note,
    FormzStatus status,
  }) {
    return AddTransactionFormState(
      purpose: purpose ?? this.purpose,
      amount: amount ?? this.amount,
      cardId: cardId ?? this.cardId,
      title: title ?? this.title,
      note: note ?? this.note,
      status: status ?? this.status,
    );
  }
}
