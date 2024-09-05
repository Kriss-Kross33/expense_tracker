import 'package:formz/formz.dart';

enum DoubleFieldValidationError { invalid }

class DoubleField extends FormzInput<double, DoubleFieldValidationError> {
  const DoubleField.pure() : super.pure(0);
  const DoubleField.dirty([double value = 0]) : super.dirty(value);

  static final _doubleRegExp = RegExp(r'^[0-9]+(\.[0-9]{1,2})?$');

  @override
  DoubleFieldValidationError? validator(double? value) {
    final hasValue = _doubleRegExp.hasMatch(value.toString())
        ? null
        : DoubleFieldValidationError.invalid;
    return hasValue;
  }
}
