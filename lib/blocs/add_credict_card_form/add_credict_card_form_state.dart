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
    required this.mode,
    this.credictCard,
  });

  final FormzStatus status;
  final CredictCardCompany company;
  final Amount balance;
  final CredictCardType type;
  final Note note;
  final Color color;
  final CredictCard? credictCard;
  final Mode mode;

  @override
  List<Object?> get props => [status, company, balance, type, note, color, credictCard, mode];

  factory AddCredictCardFormState.add() {
    return AddCredictCardFormState._(
      balance: const Amount.pure(),
      color: CardColors.blue300 as Color,
      company: CredictCardCompany.none,
      note: const Note.pure(),
      status: FormzStatus.pure,
      type: CredictCardType.none,
      mode: Mode.add,
    );
  }

  factory AddCredictCardFormState.edit(CredictCard card) {
    return AddCredictCardFormState._(
      status: FormzStatus.pure,
      company: card.company,
      balance: Amount.pure(card.balance.toString()),
      type: card.type,
      note: Note.pure(card.note),
      color: card.color,
      credictCard: card,
      mode: Mode.edit,
    );
  }

  AddCredictCardFormState copyWith({
    FormzStatus? status,
    CredictCardCompany? company,
    Amount? balance,
    CredictCardType? type,
    Note? note,
    Color? color,
    CredictCard? credictCard,
    Mode? mode,
  }) {
    return AddCredictCardFormState._(
      mode: mode ?? this.mode,
      status: status ?? this.status,
      company: company ?? this.company,
      balance: balance ?? this.balance,
      type: type ?? this.type,
      note: note ?? this.note,
      color: color ?? this.color,
      credictCard: credictCard ?? this.credictCard,
    );
  }
}
