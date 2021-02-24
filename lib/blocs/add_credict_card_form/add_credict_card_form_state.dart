part of 'add_credict_card_form_bloc.dart';

@immutable
class AddCredictCardFormState extends Equatable {
  const AddCredictCardFormState({
    this.status,
    this.company,
    this.balance,
    this.type,
    this.note,
    this.color,
  });

  final FormzStatus status;
  final CredictCardCompany company;
  final Balance balance;
  final CredictCardType type;
  final Note note;
  final Color color;
  static AddCredictCardFormState initial() {
    return AddCredictCardFormState(
      balance: const Balance.pure(),
      color: CardColors.blue300,
      company: CredictCardCompany.none,
      note: const Note.pure(),
      status: FormzStatus.pure,
      type: CredictCardType.none,
    );
  }

  @override
  List<Object> get props => [status, company, balance, type, note, color];

  @override
  String toString() =>
      'AddCredictCardFormState { status: $status, company: $company, balance: ${balance.value}, type: $type, note: $note, color: $color }';

  AddCredictCardFormState copyWith({
    FormzStatus status,
    CredictCardCompany company,
    Balance balance,
    CredictCardType type,
    Note note,
    Color color,
  }) {
    return AddCredictCardFormState(
      status: status ?? this.status,
      company: company ?? this.company,
      balance: balance ?? this.balance,
      type: type ?? this.type,
      note: note ?? this.note,
      color: color ?? this.color,
    );
  }
}
