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

class MockLoginModel extends Mock implements LoginModel {}

void main() {
  const emailString = 'kwamefosu@gmail.com';
  const email = Email.dirty(emailString);
  const invalidEmailString = 'invalid';
  const invalidEmail = Email.dirty(invalidEmailString);
  const passwordString = 'pAssw0rd@';
  const password = Password.dirty(passwordString);
  const invalidPasswordString = 'invalid';
  const invalidPassword = Password.dirty(invalidPasswordString);

  group(
    'LoginCubit',
    () {
      late ExpenseApiRepository expenseApiRepository;

      setUp(() {
        registerFallbackValue(
            LoginModel(email: emailString, password: passwordString));
        expenseApiRepository = MockExpenseApiRepository();
        when(
          () => expenseApiRepository.login(
            loginModel: any(named: 'loginModel'),
          ),
        ).thenAnswer((_) async => right(Success()));
      });

      group('onEmailInput', () {
        blocTest<LoginCubit, LoginState>(
          'emits [invalid] when email is invalid',
          build: () => LoginCubit(expenseApiRepository: expenseApiRepository),
          act: (cubit) => cubit.onEmailInput(invalidEmailString),
          expect: () => <LoginState>[
            const LoginState(
              isValid: false,
              email: invalidEmail,
            )
          ],
        );
      });

      group('onPasswordInput', () {
        blocTest<LoginCubit, LoginState>(
          'emits [valid] when password is valid',
          build: () => LoginCubit(expenseApiRepository: expenseApiRepository),
          seed: () => const LoginState(email: email),
          act: (cubit) => cubit.onPasswordInput(passwordString),
          expect: () => <LoginState>[
            const LoginState(
              password: password,
              email: email,
              isValid: true,
            ),
          ],
        );

        blocTest<LoginCubit, LoginState>(
          'emits [invalid] when password is invalid',
          build: () => LoginCubit(expenseApiRepository: expenseApiRepository),
          act: (cubit) => cubit.onPasswordInput(invalidPasswordString),
          expect: () => <LoginState>[
            const LoginState(
              isValid: false,
              password: invalidPassword,
            ),
          ],
        );
      });

      group('onLoginPressed', () {
        blocTest<LoginCubit, LoginState>(
          'emits nothing when state is invalid',
          build: () => LoginCubit(expenseApiRepository: expenseApiRepository),
          seed: () => const LoginState(
            isValid: false,
          ),
          act: (cubit) => cubit.onLoginPressed(),
          expect: () => <LoginState>[],
        );

        blocTest<LoginCubit, LoginState>(
          'emits [loading, success] when login is successful',
          build: () => LoginCubit(expenseApiRepository: expenseApiRepository),
          setUp: () {
            when(() => expenseApiRepository.login(
                    loginModel: any(named: 'loginModel')))
                .thenAnswer((_) async => right(Success()));
          },
          seed: () => const LoginState(
            email: email,
            password: password,
            isValid: true,
          ),
          act: (cubit) => cubit.onLoginPressed(),
          expect: () => const <LoginState>[
            LoginState(
              status: FormzSubmissionStatus.inProgress,
              email: email,
              password: password,
              isValid: true,
            ),
            LoginState(
              status: FormzSubmissionStatus.success,
              email: email,
              password: password,
              isValid: true,
            ),
          ],
          verify: (_) {
            verify(() => expenseApiRepository.login(
                  loginModel: any(named: 'loginModel'),
                )).called(1);
          },
        );
        blocTest<LoginCubit, LoginState>(
          'emits [loading, failure] when an error occurs',
          build: () => LoginCubit(expenseApiRepository: expenseApiRepository),
          setUp: () {
            when(() => expenseApiRepository.login(
                    loginModel: any(named: 'loginModel')))
                .thenThrow(
                    const ServerException(errorMessage: 'Unknown Error'));
          },
          seed: () => const LoginState(
            email: email,
            password: password,
            isValid: true,
          ),
          act: (cubit) => cubit.onLoginPressed(),
          expect: () => <LoginState>[
            const LoginState(
              status: FormzSubmissionStatus.inProgress,
              email: email,
              password: password,
              isValid: true,
            ),
            const LoginState(
              status: FormzSubmissionStatus.failure,
              email: email,
              password: password,
              isValid: true,
              errorMessage: 'Unknown Error',
            ),
          ],
        );
      });

      blocTest<LoginCubit, LoginState>(
        'calls login with the correct email and password',
        build: () => LoginCubit(expenseApiRepository: expenseApiRepository),
        seed: () => const LoginState(
          email: email,
          password: password,
          isValid: true,
          errorMessage: '',
        ),
        act: (cubit) => cubit.onLoginPressed(),
        verify: (_) {
          verify(
            () => expenseApiRepository.login(
              loginModel: any(named: 'loginModel'),
            ),
          ).called(1);
        },
      );
    },
  );
}
