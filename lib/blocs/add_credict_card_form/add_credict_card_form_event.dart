part of 'add_credict_card_form_bloc.dart';

abstract class AddCredictCardFormEvent extends Equatable {
  const AddCredictCardFormEvent();

  @override
  List<Object> get props => [];
}

class CredictCardCompanyChanged extends AddCredictCardFormEvent {
  final CredictCardCompany company;

  const CredictCardCompanyChanged(this.company);

  @override
  List<Object> get props => [props];
}

class CredictCardBalanceChanged extends AddCredictCardFormEvent {
  final String value;

  const CredictCardBalanceChanged(this.value);

  @override
  List<Object> get props => [value];
}

class CredictCardBalanceUnfocused extends AddCredictCardFormEvent {}

class CredictCardTypeChanged extends AddCredictCardFormEvent {
  final CredictCardType type;

  const CredictCardTypeChanged(this.type);

  @override
  List<Object> get props => [type];
}

class CredictCardNoteChanged extends AddCredictCardFormEvent {
  final String value;

  const CredictCardNoteChanged(this.value);
  @override
  List<Object> get props => [value];
}

class CredictCardNoteUnfocused extends AddCredictCardFormEvent {}

class CredictCardColorChanged extends AddCredictCardFormEvent {
  final Color color;

  const CredictCardColorChanged(this.color);
  @override
  List<Object> get props => [color];
}

class CrediCardFormSubmit extends AddCredictCardFormEvent {}
