part of 'add_transaction_form_bloc.dart';

class AddTransactionFormState extends Equatable {
  final TransactionPurpose purpose;
  final Amount amount;
  final Card card;
  final Title title;
  final Note note;
  final FormzStatus status;

  const AddTransactionFormState({
    this.purpose,
    this.amount,
    this.card,
    this.title,
    this.note,
    this.status,
  });

  factory AddTransactionFormState.initial() {
    return AddTransactionFormState(
      amount: const Amount.pure(),
      card: const Card.pure(),
      note: const Note.pure(),
      purpose: TransactionPurpose.none,
      title: const Title.pure(),
      status: FormzStatus.pure,
    );
  }

  @override
  List<Object> get props {
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
    TransactionPurpose purpose,
    Amount amount,
    Card card,
    Title title,
    Note note,
    FormzStatus status,
  }) {
    return AddTransactionFormState(
      purpose: purpose ?? this.purpose,
      amount: amount ?? this.amount,
      card: card ?? this.card,
      title: title ?? this.title,
      note: note ?? this.note,
      status: status ?? this.status,
    );
  }
}
