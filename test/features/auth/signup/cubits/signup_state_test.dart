import 'package:expense_track/src/features/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz_input/formz_input.dart';

void main() {
  late SignupState signupState;
  const name = Field.dirty('Kwame Fosu');
  const email = Email.dirty('email@gmail.com');
  const password = Password.dirty('pAssword@');
  const confirmPassword = ConfirmPassword.dirty(
    password: 'pAssword@',
    value: 'pAssword@',
  );

  setUp(() {
    signupState = const SignupState();
  });

  group('SignupState', () {
    test('supports value comparison', () {
      expect(
        signupState,
        equals(
          const SignupState(),
        ),
      );
    });
    test('returns same objects when no properties are passed', () {
      expect(signupState.copyWith(), signupState);
    });

    test('returns object with updated status when status is passed', () {
      expect(
        signupState.copyWith(),
        const SignupState(),
      );
    });

    test('returns object with updated username when username is passed', () {
      expect(
        signupState.copyWith(name: name),
        const SignupState(name: name),
      );
    });

    test('returns object with updated email when email is passed', () {
      expect(
        signupState.copyWith(email: email),
        const SignupState(email: email),
      );
    });

    test('returns object with updated password when password is passed', () {
      expect(
        signupState.copyWith(password: password),
        const SignupState(password: password),
      );
    });

    test(
        'returns object with updated confirm password when '
        'confirmPassword is passed', () {
      expect(
        signupState.copyWith(confirmPassword: confirmPassword),
        const SignupState(confirmPassword: confirmPassword),
      );
    });
  });
}
