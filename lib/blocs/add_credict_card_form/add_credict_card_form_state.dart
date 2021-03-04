part of 'add_credict_card_form_bloc.dart';

@immutable
class AddCredictCardFormState extends Equatable {
  AddCredictCardFormState._({
    required this.status,
    required this.company,
    required this.balance,
    required this.type,
    required this.note,
    required this.color,
  });

  static AddCredictCardFormState initial() {
    return AddCredictCardFormState._(
      balance: const Amount.pure(),
      color: CardColors.blue300 as Color,
      company: CredictCardCompany.none,
      note: const Note.pure(),
      status: FormzStatus.pure,
      type: CredictCardType.none,
    );
  }

  final FormzStatus status;
  final CredictCardCompany company;
  final Amount balance;
  final CredictCardType type;
  final Note note;
  final Color color;

  @override
  List<Object> get props => [status, company, balance, type, note, color];

  @override
  String toString() =>
      'AddCredictCardFormState { status: $status, company: $company, balance: ${balance.value}, type: $type, note: $note, color: $color }';

  AddCredictCardFormState copyWith({
    FormzStatus? status,
    CredictCardCompany? company,
    Amount? balance,
    CredictCardType? type,
    Note? note,
    Color? color,
  }) {
    return AddCredictCardFormState._(
      status: status ?? this.status,
      company: company ?? this.company,
      balance: balance ?? this.balance,
      type: type ?? this.type,
      note: note ?? this.note,
      color: color ?? this.color,
    );
  }
}
