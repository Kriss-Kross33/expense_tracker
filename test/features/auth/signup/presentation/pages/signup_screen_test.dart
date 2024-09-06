import 'package:expense_api_repository/expense_api_repository.dart';
import 'package:expense_track/src/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockExpenseAPiRepository extends Mock implements ExpenseApiRepository {}

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  group('SignupScreen', () {
    late ExpenseApiRepository expenseApiRepository;
    late GoRouter goRouter;

    setUp(() {
      expenseApiRepository = MockExpenseAPiRepository();
      goRouter = MockGoRouter();
    });

    // testWidgets('TextButton pops the screen when pressed',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(
    //     RepositoryProvider.value(
    //       value: expenseApiRepository,
    //       child: MaterialApp(
    //         home: InheritedGoRouter(
    //           goRouter: goRouter,
    //           child: const SignupScreen(),
    //         ),
    //       ),
    //     ),
    //   );
    //   await tester.tap(find.byType(TextButton));
    //   await tester.pumpAndSettle();
    //   expect(find.byKey(const Key('__signupForm')), findsOneWidget);
    //   expect(find.byType(TextButton), findsOneWidget);
    //   verify(() => goRouter.pop()).called(1);
    // });

    testWidgets('renders a Signup form', (WidgetTester tester) async {
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: expenseApiRepository,
          child: InheritedGoRouter(
            goRouter: goRouter,
            child: const MaterialApp(
              home: SignupScreen(),
            ),
          ),
        ),
      );
      expect(find.byKey(const Key('__signupForm')), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });
  });
}
