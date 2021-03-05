import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formz/formz.dart';

enum CreatedValidationError { invalid }

class Created extends FormzInput<Timestamp, CreatedValidationError> {
  Created.pure([Timestamp? value]) : super.pure(value ?? Timestamp.now());
  Created.dirty([Timestamp? value]) : super.pure(value ?? Timestamp.now());

  @override
  CreatedValidationError? validator(Timestamp? value) {
    final insertedValue = value!.toDate();
    final currentDate = Timestamp.now().toDate();

    if (insertedValue.isAfter(currentDate)) {
      return CreatedValidationError.invalid;
    } else {
      return null;
    }
  }
}
