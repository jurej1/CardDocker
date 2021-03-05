import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formz/formz.dart';

enum CreatedValidationError { invalid }

class Created extends FormzInput<DateTime, CreatedValidationError> {
  Created.pure([DateTime? value]) : super.pure(value ?? DateTime.now());
  Created.dirty([DateTime? value]) : super.pure(value ?? DateTime.now());

  @override
  CreatedValidationError? validator(DateTime? value) {
    final currentDate = Timestamp.now().toDate();

    if (value!.isAfter(currentDate)) {
      return CreatedValidationError.invalid;
    } else {
      return null;
    }
  }
}
