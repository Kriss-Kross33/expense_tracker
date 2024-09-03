import 'package:expense_api_repository/expense_api_repository.dart';
import 'package:expense_track/src/app.dart';
import 'package:expense_track/src/app_view.dart';
import 'package:expense_track/src/common/blocs/expense_cubit/expense_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers.dart';

class MockExpenseApiRepository extends Mock implements ExpenseApiRepository {}

class MockExpenseApiCubit extends Mock implements ExpenseApiCubit {}

class MockStorage extends Mock implements Storage {}

void main() async {
  initHydratedStorage();
  group('App', () {
    late ExpenseApiRepository mockExpenseApiRepository;

    setUp(() {
      mockExpenseApiRepository = MockExpenseApiRepository();
    });

    testWidgets('renders AppView', (WidgetTester tester) async {
      await tester.pumpWidget(
        App(expenseApiRepository: mockExpenseApiRepository),
      );

      expect(find.byType(AppView), findsOneWidget);
    });
  });
}
