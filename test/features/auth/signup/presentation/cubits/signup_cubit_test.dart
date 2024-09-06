import 'package:bloc_test/bloc_test.dart';
import 'package:expense_api/expense_api.dart';
import 'package:expense_api_repository/expense_api_repository.dart';
import 'package:expense_track/src/features/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:formz_input/formz_input.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockExpenseApiRepository extends Mock implements ExpenseApiRepository {}

void main() {
  late ExpenseApiRepository expenseApiRepository;
  late SignupCubit signupCubit;
  const invalidString = 'invalid';
  // name
  const usernameString = 'rasfosu';
  const name = Field.dirty(usernameString);
  const invalidUsername = Field.dirty(invalidString);
  // email
  const emailString = 'email@gmail.com';
  const email = Email.dirty(emailString);
  const invalidEmail = Email.dirty(invalidString);
  // password
  const passwordString = 'pAssw0rd@';
  const password = Password.dirty(passwordString);
  const invalidPassword = Password.dirty(invalidString);
  // confirm password
  const confirmPasswordString = 'pAssw0rd@';
  const confirmPassword = ConfirmPassword.dirty(
    password: passwordString,
    value: confirmPasswordString,
  );
  const invalidConfirmPassword = ConfirmPassword.dirty(
    password: passwordString,
    value: invalidString,
  );

  setUpAll(() {
    registerFallbackValue(SignupModel(
        email: emailString, password: passwordString, name: usernameString));
    expenseApiRepository = MockExpenseApiRepository();
    signupCubit = SignupCubit(
      expenseApiRepository: expenseApiRepository,
    );
    when(
      () => expenseApiRepository.signup(
        signupModel: any(named: 'signupModel'),
      ),
    ).thenAnswer((_) async => right(Success.instance));
  });

  group('SignupCubit', () {
    test('initial state is SignupState', () {
      expect(signupCubit.state, equals(const SignupState()));
    });

    group('onUsernameInput', () {
      blocTest<SignupCubit, SignupState>(
        'emits [valid] when name is valid',
        build: () => SignupCubit(
          expenseApiRepository: expenseApiRepository,
        ),
        seed: () => const SignupState(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          isValid: true,
        ),
        act: (cubit) => cubit.onUsernameInput(usernameString),
        expect: () => <SignupState>[
          const SignupState(
            name: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            isValid: true,
          ),
        ],
      );

      blocTest<SignupCubit, SignupState>(
        'emits [invalid] when name is invalid',
        build: () => SignupCubit(
          expenseApiRepository: expenseApiRepository,
        ),
        act: (cubit) => cubit.onUsernameInput(invalidString),
        expect: () => <SignupState>[
          const SignupState(
            name: invalidUsername,
            isValid: false,
          ),
        ],
      );
    });

    group('onEmailInput', () {
      blocTest<SignupCubit, SignupState>(
        'emits [valid] when emai is valid',
        build: () => SignupCubit(
          expenseApiRepository: expenseApiRepository,
        ),
        seed: () => const SignupState(
          name: name,
          password: password,
          confirmPassword: confirmPassword,
          isValid: true,
        ),
        act: (cubit) => cubit.onEmailInput(emailString),
        expect: () => <SignupState>[
          const SignupState(
            name: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            isValid: true,
          ),
        ],
      );

      blocTest<SignupCubit, SignupState>(
        'emits [invalid] when email is invalid',
        build: () => SignupCubit(
          expenseApiRepository: expenseApiRepository,
        ),
        act: (cubit) => cubit.onEmailInput(invalidString),
        expect: () => <SignupState>[
          const SignupState(
            email: invalidEmail,
            isValid: false,
          ),
        ],
      );
    });

    group('onPasswordInput', () {
      blocTest<SignupCubit, SignupState>(
        'emits [valid] when password is valid',
        build: () => SignupCubit(
          expenseApiRepository: expenseApiRepository,
        ),
        seed: () => const SignupState(
          name: name,
          email: email,
          confirmPassword: confirmPassword,
        ),
        act: (cubit) => cubit.onPasswordInput(passwordString),
        expect: () => <SignupState>[
          const SignupState(
            password: password,
            name: name,
            email: email,
            confirmPassword: confirmPassword,
            isValid: true,
          )
        ],
      );

      blocTest<SignupCubit, SignupState>(
        'emits [invalid] when password is invalid',
        build: () => SignupCubit(
          expenseApiRepository: expenseApiRepository,
        ),
        act: (cubit) => cubit.onPasswordInput(invalidString),
        expect: () => <SignupState>[
          const SignupState(
            password: invalidPassword,
            confirmPassword: ConfirmPassword.dirty(
              password: invalidString,
            ),
            isValid: false,
          )
        ],
      );
    });

    group('onConfirmPasswordInput', () {
      blocTest<SignupCubit, SignupState>(
        'emits [valid] when confirmpassword is valid',
        build: () => SignupCubit(
          expenseApiRepository: expenseApiRepository,
        ),
        seed: () => const SignupState(
          name: name,
          email: email,
          password: password,
          isValid: true,
        ),
        act: (cubit) => cubit.onConfirmPasswordInput(confirmPasswordString),
        expect: () => <SignupState>[
          const SignupState(
            confirmPassword: confirmPassword,
            name: name,
            email: email,
            password: password,
            isValid: true,
          ),
        ],
      );

      blocTest<SignupCubit, SignupState>(
        'emits [invalid] when confirmPassword is invalid',
        build: () => SignupCubit(
          expenseApiRepository: expenseApiRepository,
        ),
        act: (cubit) => cubit.onConfirmPasswordInput(invalidString),
        expect: () => <SignupState>[
          const SignupState(
              confirmPassword: invalidConfirmPassword, isValid: false),
        ],
      );
    });

    group('onSignupPressed', () {
      final signupModel = SignupModel(
        email: emailString,
        password: passwordString,
        name: usernameString,
      );
      blocTest<SignupCubit, SignupState>(
        'emits nothing if state is not valid',
        build: () => SignupCubit(
          expenseApiRepository: expenseApiRepository,
        ),
        seed: () => const SignupState(isValid: false),
        act: (cubit) => cubit.onSignupPressed(),
        expect: () => <SignupState>[],
      );

      blocTest<SignupCubit, SignupState>(
        'calls signup with the correct data',
        build: () => SignupCubit(
          expenseApiRepository: expenseApiRepository,
        ),
        seed: () => const SignupState(
          name: name,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          isValid: true,
        ),
        act: (cubit) => cubit.onSignupPressed(),
        verify: (cubit) {
          final captured = verify(
            () => expenseApiRepository.signup(
              signupModel: captureAny(named: 'signupModel'),
            ),
          ).captured.single as SignupModel;

          expect(captured.email, equals(emailString));
          expect(captured.password, equals(passwordString));
          expect(captured.name, equals(usernameString));
        },
      );

      blocTest<SignupCubit, SignupState>(
        'emits [loading, success] when signup is successful',
        build: () => SignupCubit(
          expenseApiRepository: expenseApiRepository,
        ),
        seed: () => const SignupState(
          name: name,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          isValid: true,
        ),
        act: (cubit) => cubit.onSignupPressed(),
        expect: () => <SignupState>[
          const SignupState(
            status: FormzSubmissionStatus.inProgress,
            name: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            isValid: true,
          ),
          const SignupState(
            status: FormzSubmissionStatus.success,
            name: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            isValid: true,
          ),
        ],
      );

      blocTest<SignupCubit, SignupState>(
        'emits [loading, failure] when an error occurs',
        build: () => SignupCubit(
          expenseApiRepository: expenseApiRepository,
        ),
        setUp: () {
          when(
            () => expenseApiRepository.signup(
              signupModel: any(named: 'signupModel'),
            ),
          ).thenThrow(
            const ServerException(
              errorMessage: 'Something went wrong',
            ),
          );
        },
        seed: () => const SignupState(
          name: name,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          isValid: true,
        ),
        act: (cubit) => cubit.onSignupPressed(),
        expect: () => <SignupState>[
          const SignupState(
            status: FormzSubmissionStatus.inProgress,
            name: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            isValid: true,
          ),
          const SignupState(
            status: FormzSubmissionStatus.failure,
            errorMessage: 'Something went wrong',
            name: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            isValid: true,
          ),
        ],
      );
    });
  });
}
