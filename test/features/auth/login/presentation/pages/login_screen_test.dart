import 'package:expense_api_repository/expense_api_repository.dart';
import 'package:expense_track/src/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExpenseApiRepository extends Mock implements ExpenseApiRepository {}

void main() {
  group('LoginScreen', () {
    late ExpenseApiRepository expenseApiRepository;

    setUp(() {
      expenseApiRepository = MockExpenseApiRepository();
    });

    testWidgets('renders a Login form', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: expenseApiRepository,
          child: const MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );
      expect(find.byKey(const Key('__loginForm')), findsOneWidget);
    });
  });
}
