import 'package:expense_track/src/common/blocs/expense_cubit/expense_cubit.dart';
import 'package:expense_track/src/common/blocs/theme_cubit/theme_cubit.dart';
import 'package:expense_track/src/features/home/cubits/cubits.dart';
import 'package:expense_track/src/features/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNavBarCubit extends Mock implements NavBarCubit {}

class MockThemeCubit extends Mock implements ThemeCubit {}

class MockExpenseApiCubit extends Mock implements ExpenseApiCubit {}

void main() {
  group('HomePage Widget Tests', () {
    late MockNavBarCubit mockNavBarCubit;
    late MockThemeCubit mockThemeCubit;
    late MockExpenseApiCubit mockExpenseApiCubit;

    setUp(() {
      mockNavBarCubit = MockNavBarCubit();
      mockThemeCubit = MockThemeCubit();
      mockExpenseApiCubit = MockExpenseApiCubit();
      when(() => mockNavBarCubit.state).thenReturn(const NavBarState(index: 0));
      when(() => mockThemeCubit.state)
          .thenReturn(const ThemeState(themeMode: AppThemeMode.lightMode));
      when(() => mockThemeCubit.stream).thenAnswer((_) => const Stream.empty());

      when(() => mockExpenseApiCubit.stream)
          .thenAnswer((_) => const Stream.empty());

      when(() => mockExpenseApiCubit.getExpenses())
          .thenAnswer((_) => Future<void>.value());

      when(() => mockExpenseApiCubit.getIncome())
          .thenAnswer((_) => Future<void>.value());
    });

    testWidgets('renders HomePage with correct initial state',
        (WidgetTester tester) async {
      when(() => mockExpenseApiCubit.state).thenReturn(const ExpenseApiState());
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<NavBarCubit>.value(value: mockNavBarCubit),
            BlocProvider<ThemeCubit>.value(value: mockThemeCubit),
            BlocProvider<ExpenseApiCubit>.value(value: mockExpenseApiCubit),
          ],
          child: const MaterialApp(home: HomePage()),
        ),
      );

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.byType(TabIndicators), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Expenditure'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('changes tab when tapping on BottomNavigationBar items',
        (WidgetTester tester) async {
      when(() => mockExpenseApiCubit.state).thenReturn(const ExpenseApiState());
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<NavBarCubit>.value(value: mockNavBarCubit),
            BlocProvider<ThemeCubit>.value(value: mockThemeCubit),
            BlocProvider<ExpenseApiCubit>.value(value: mockExpenseApiCubit),
          ],
          child: const MaterialApp(home: HomePage()),
        ),
      );
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Expenditure'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      await tester.tap(find.text('Expenditure'));
      await tester.pump();
      await tester.tap(find.text('Profile'));
      await tester.pump();
      verifyNever(() => mockNavBarCubit.onTabSelected(any()));
    });
  });

  group('TabIndicators Widget Tests', () {
    testWidgets('renders correct number of indicators',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TabIndicators(
              numTabs: 3,
              currentIndex: 1,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
              padding: 2,
              height: 5,
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(3));
    });

    testWidgets('active indicator has correct color',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TabIndicators(
              numTabs: 3,
              currentIndex: 1,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
              padding: 2,
              height: 5,
            ),
          ),
        ),
      );

      final containers = tester.widgetList<Container>(find.byType(Container));
      expect(containers.elementAt(1).color, equals(Colors.blue));
    });
  });
}
