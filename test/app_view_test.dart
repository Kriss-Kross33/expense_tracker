import 'package:expense_api_repository/expense_api_repository.dart';
import 'package:expense_track/src/app_view.dart';
import 'package:expense_track/src/common/blocs/expense_cubit/expense_cubit.dart';
import 'package:expense_track/src/common/blocs/theme_cubit/theme_cubit.dart';
import 'package:expense_track/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers.dart';

// Mock classes
class MockThemeCubit extends Mock implements ThemeCubit {}

class MockExpenseApiCubit extends Mock implements ExpenseApiCubit {}

class MockExpenseApiRepository extends Mock implements ExpenseApiRepository {}

void main() {
  initHydratedStorage();
  group('AppView', () {
    late MockThemeCubit mockThemeCubit;
    late MockExpenseApiCubit mockExpenseApiCubit;
    late MockExpenseApiRepository mockExpenseApiRepository;

    setUp(() {
      mockThemeCubit = MockThemeCubit();
      mockExpenseApiCubit = MockExpenseApiCubit();
      mockExpenseApiRepository = MockExpenseApiRepository();
    });

    testWidgets('renders MaterialApp.router with correct properties',
        (WidgetTester tester) async {
      when(() => mockThemeCubit.state)
          .thenReturn(const ThemeState(themeMode: AppThemeMode.lightMode));

      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<ExpenseApiRepository>.value(
                value: mockExpenseApiRepository),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<ThemeCubit>.value(value: mockThemeCubit),
              BlocProvider<ExpenseApiCubit>.value(value: mockExpenseApiCubit),
            ],
            child: const AppView(),
          ),
        ),
      );

      expect(find.byType(MaterialApp), findsOneWidget);

      final MaterialApp app =
          tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app.theme, equals(AppTheme.light));
      expect(app.darkTheme, equals(AppTheme.dark));
      expect(app.themeMode, equals(ThemeMode.light));
      expect(app.debugShowCheckedModeBanner, isFalse);
      expect(app.routerDelegate, equals(AppRouter.router.routerDelegate));
      expect(app.routeInformationParser,
          equals(AppRouter.router.routeInformationParser));
      expect(app.routeInformationProvider,
          equals(AppRouter.router.routeInformationProvider));
    });
  });
}
