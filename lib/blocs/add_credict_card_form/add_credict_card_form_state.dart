part of 'add_credict_card_form_bloc.dart';

class AddCredictCardFormState extends Equatable {
  const AddCredictCardFormState({
    this.status = FormzStatus.pure,
    this.company = CredictCardCompany.none,
    this.balance = const Balance.pure(),
    this.type = CredictCardType.none,
    this.note = const Note.pure(),
    this.color = Colors.red,
  });

  final FormzStatus status;
  final CredictCardCompany company;
  final Balance balance;
  final CredictCardType type;
  final Note note;
  final Color color;

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
