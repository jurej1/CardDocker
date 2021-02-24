import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

enum NoteValidationError { invalid }

class Note extends FormzInput<String, NoteValidationError> {
  const Note.pure([String value = '']) : super.pure(value);
  const Note.dirty([String value = '']) : super.dirty(value);

  @override
  NoteValidationError validator(String value) {
    if (value == null) {
      return NoteValidationError.invalid;
    } else if (value.isEmpty) {
      return NoteValidationError.invalid;
    } else if (value.length < 4) {
      return NoteValidationError.invalid;
    } else {
      return null;
    }
  }
}