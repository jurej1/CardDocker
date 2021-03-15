import 'package:formz/formz.dart';

enum CreatedValidationError { invalid }

class Created extends FormzInput<DateTime, CreatedValidationError> {
  Created.pure([DateTime? value]) : super.pure(value ?? DateTime.now());
  Created.dirty([DateTime? value]) : super.pure(value ?? DateTime.now());

  @override
  CreatedValidationError? validator(DateTime? value) {
    final currentDate = DateTime.now();

    if (value!.isAfter(currentDate)) {
      return CreatedValidationError.invalid;
    } else {
      return null;
    }
  }
}
