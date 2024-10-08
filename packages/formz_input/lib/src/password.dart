import 'package:formz/formz.dart';

enum PasswordValidationError {
  invalid,
}

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.dirty = '']) : super.dirty();

  // static final _passwordRegex =
  //     RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$');

  PasswordValidationError? validator(String? value) {
    if (value != null) {
      return value.length > 6 ? null : PasswordValidationError.invalid;
    }
    return PasswordValidationError.invalid;
  }
}
