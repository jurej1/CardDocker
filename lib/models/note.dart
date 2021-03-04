import 'package:formz/formz.dart';

enum NoteValidationError { invalid }

class Note extends FormzInput<String, NoteValidationError> {
  const Note.pure([String value = '']) : super.pure(value);
  const Note.dirty([String value = '']) : super.dirty(value);

  @override
  NoteValidationError? validator(String value) {
    if (value.length > 300) {
      return NoteValidationError.invalid;
    } else {
      return null;
    }
  }
}
