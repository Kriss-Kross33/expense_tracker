import 'package:bloc_test/bloc_test.dart';
import 'package:expense_track/src/features/auth/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:formz_input/formz_input.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
  group('LoginForm', () {
    late LoginCubit loginCubit;

    setUp(() {
      loginCubit = MockLoginCubit();
      when(() => loginCubit.state).thenReturn(const LoginState());
    });

    // final loginForm = find.byKey(const Key('__loginForm'));

    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: loginCubit,
              child: const LoginForm(
                constraints: BoxConstraints(),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(LoginForm), findsOneWidget);

      expect(find.byKey(const Key('__emailLoginTextField')), findsOneWidget);
      expect(find.byKey(const Key('__passwordLoginTextField')), findsOneWidget);
      expect(find.byKey(const Key('__loginButton')), findsOneWidget);
    });

    testWidgets('add onEmailInput to LoginCubit when email is changed',
        (WidgetTester tester) async {
      const email = 'test@test.com';
      when(() => loginCubit.state).thenReturn(const LoginState());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: loginCubit,
              child: const LoginForm(
                constraints: BoxConstraints(),
              ),
            ),
          ),
        ),
      );
      await tester.enterText(
          find.byKey(const Key('__emailLoginTextField')), email);
      await tester.pumpAndSettle();

      verify(() => loginCubit.onEmailInput(email)).called(1);
    });

    testWidgets('add onPasswordInput to LoginCubit when password is changed',
        (WidgetTester tester) async {
      const password = 'password';
      when(() => loginCubit.state).thenReturn(const LoginState());
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: BlocProvider.value(
            value: loginCubit,
            child: const LoginForm(
              constraints: BoxConstraints(),
            ),
          ),
        ),
      ));
      await tester.enterText(
          find.byKey(const Key('__passwordLoginTextField')), password);
      await tester.pumpAndSettle();
      verify(() => loginCubit.onPasswordInput(password)).called(1);
    });

    testWidgets('Login button is disabled by default',
        (WidgetTester tester) async {
      when(() => loginCubit.state).thenReturn(const LoginState());
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: BlocProvider.value(
            value: loginCubit,
            child: const LoginForm(
              constraints: BoxConstraints(),
            ),
          ),
        ),
      ));

      final button =
          tester.widget<ElevatedButton>(find.byKey(const Key('__loginButton')));

      expect(button.enabled, isFalse);
    });

    testWidgets('Login button is enabled when email and password are valid',
        (WidgetTester tester) async {
      when(() => loginCubit.state).thenReturn(const LoginState(
          email: Email.dirty('test@test.com'),
          password: Password.dirty('password'),
          isValid: true));
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: BlocProvider.value(
            value: loginCubit,
            child: const LoginForm(
              constraints: BoxConstraints(),
            ),
          ),
        ),
      ));

      final button =
          tester.widget<ElevatedButton>(find.byKey(const Key('__loginButton')));

      expect(button.enabled, isTrue);
    });

    testWidgets('CupertinoProgressIndicator is displayed when loading',
        (WidgetTester tester) async {
      when(() => loginCubit.state).thenReturn(
          const LoginState(status: FormzSubmissionStatus.inProgress));
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: BlocProvider.value(
            value: loginCubit,
            child: const LoginForm(
              constraints: BoxConstraints(),
            ),
          ),
        ),
      ));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
    });

    testWidgets('shows SnackBar when status is failure',
        (WidgetTester tester) async {
      whenListen(
        loginCubit,
        Stream.fromIterable([
          const LoginState(status: FormzSubmissionStatus.inProgress),
          const LoginState(status: FormzSubmissionStatus.failure),
        ]),
        initialState: const LoginState(status: FormzSubmissionStatus.failure),
      );
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: BlocProvider.value(
            value: loginCubit,
            child: const LoginForm(
              constraints: BoxConstraints(),
            ),
          ),
        ),
      ));
      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);
    });

    // testWidgets('onLoginPressed is called when login button is pressed',
    //     (WidgetTester tester) async {
    //   when(() => loginCubit.state).thenReturn(const LoginState(isValid: true));
    //   when(() => loginCubit.onLoginPressed()).thenAnswer((_) async {});
    //   await tester.pumpWidget(MaterialApp(
    //     home: Scaffold(
    //       body: BlocProvider.value(
    //         value: loginCubit,
    //         child: const LoginForm(
    //           constraints: BoxConstraints(),
    //         ),
    //       ),
    //     ),
    //   ));
    //   await tester.tap(find.byKey(const Key('__loginButton')));
    //   await tester.pumpAndSettle();
    //   verify(() => loginCubit.onLoginPressed()).called(1);
    // });
  });
}
