import 'package:expense_api_repository/expense_api_repository.dart';
import 'package:expense_track/src/app_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required ExpenseApiRepository expenseApiRepository,
  }) : _expenseApiRepository = expenseApiRepository;

  final ExpenseApiRepository _expenseApiRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _expenseApiRepository,
        ),
      ],
      child: const AppView(),
    );
  }
}
