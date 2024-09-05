import 'package:equatable/equatable.dart';
import 'package:expense_api/expense_api.dart';
import 'package:expense_api_repository/expense_api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_state.dart';

class ExpenseApiCubit extends Cubit<ExpenseApiState> {
  ExpenseApiCubit({required ExpenseApiRepository expenseApiRepository})
      : _expenseApiRepository = expenseApiRepository,
        super(const ExpenseApiState());
  final ExpenseApiRepository _expenseApiRepository;

  Future<void> addExpense({required Expense expense}) async {
    emit(state.copyWith(status: ExpenseApiStatus.loading));
    final result = await _expenseApiRepository.addExpense(expense: expense);
    result.fold(
      (failure) => emit(state.copyWith(
          status: ExpenseApiStatus.failure,
          errorMessage: failure.errorMessage)),
      (_) async {
        emit(state.copyWith(status: ExpenseApiStatus.success));
        await Future.delayed(const Duration(milliseconds: 100), () {
          getExpenses();
        });
      },
    );
    //  await getExpenses();
  }

  Future<void> addIncome({required Income income}) async {
    emit(state.copyWith(status: ExpenseApiStatus.loading));
    final result = await _expenseApiRepository.addIncome(income: income);
    result.fold(
      (failure) => emit(state.copyWith(
          status: ExpenseApiStatus.failure,
          errorMessage: failure.errorMessage)),
      (_) async {
        emit(state.copyWith(status: ExpenseApiStatus.success));
        await Future.delayed(const Duration(milliseconds: 100), () {
          getIncome();
        });
      },
    );
    // await getIncome();
  }

  Future<void> deleteExpense(String expenseId) async {
    final result =
        await _expenseApiRepository.deleteExpense(expenseId: expenseId);
    result.fold(
      (failure) => emit(state.copyWith(
          status: ExpenseApiStatus.failure,
          errorMessage: failure.errorMessage)),
      (_) async {
        emit(state.copyWith(status: ExpenseApiStatus.success));
        await Future.delayed(const Duration(milliseconds: 100), () {
          getExpenses();
        });
      },
    );
    // await getExpenses();
  }

  Future<void> deleteIncome(String incomeId) async {
    //emit(state.copyWith(status: ExpenseApiStatus.loading));
    final result = await _expenseApiRepository.deleteIncome(incomeId: incomeId);
    result.fold(
      (failure) => emit(state.copyWith(
          status: ExpenseApiStatus.failure,
          errorMessage: failure.errorMessage)),
      (_) async {
        emit(state.copyWith(status: ExpenseApiStatus.success));
        await Future.delayed(const Duration(seconds: 2), () {
          getIncome();
        });
      },
    );
    // await getIncome();
  }

  Future<void> getExpenses() async {
    emit(state.copyWith(status: ExpenseApiStatus.loading));
    final eitherFailureOrExpenses = await _expenseApiRepository.getExpenses();
    eitherFailureOrExpenses.fold(
      (failure) => emit(state.copyWith(
          status: ExpenseApiStatus.failure,
          errorMessage: failure.errorMessage)),
      (expenses) {
        double totalExpense = 0;
        for (var item in expenses) {
          final estimatedAmount = item.estimatedAmount;
          if (estimatedAmount is num) {
            totalExpense += estimatedAmount.toDouble();
          }
        }

        double totalIncome = state.totalIncome;
        double balance = totalIncome - totalExpense;
        emit(
          state.copyWith(
            status: ExpenseApiStatus.success,
            expenses: expenses,
            totalExpense: totalExpense,
            totalIncome: totalIncome,
            balance: balance,
          ),
        );
      },
    );
  }

  Future<void> getIncome() async {
    emit(state.copyWith(status: ExpenseApiStatus.loading));
    final result = await _expenseApiRepository.getIncome();
    result.fold(
      (failure) => emit(state.copyWith(
          status: ExpenseApiStatus.failure,
          errorMessage: failure.errorMessage)),
      (income) {
        double totalIncome = 0;
        for (var item in income) {
          totalIncome += item.amount;
        }
        double totalExpense = state.totalExpense;
        double balance = totalIncome - totalExpense;
        emit(
          state.copyWith(
            status: ExpenseApiStatus.success,
            incomeList: income,
            totalIncome: totalIncome,
            balance: balance,
            totalExpense: totalExpense,
          ),
        );
      },
    );
  }

  Future<void> getUser(String userId) async {
    emit(state.copyWith(status: ExpenseApiStatus.loading));
    final result = await _expenseApiRepository.getUser(userId: userId);
    result.fold(
      (failure) => emit(state.copyWith(
          status: ExpenseApiStatus.failure,
          errorMessage: failure.errorMessage)),
      (user) =>
          emit(state.copyWith(status: ExpenseApiStatus.success, user: user)),
    );
  }

  Future<void> getExpenseById(String expenseId) async {
    emit(state.copyWith(status: ExpenseApiStatus.loading));
    final result =
        await _expenseApiRepository.getExpenseById(expenseId: expenseId);
    result.fold(
      (failure) => emit(state.copyWith(
          status: ExpenseApiStatus.failure,
          errorMessage: failure.errorMessage)),
      (expense) => emit(
          state.copyWith(status: ExpenseApiStatus.success, expense: expense)),
    );
  }

  Future<void> getIncomeById(String incomeId) async {
    emit(state.copyWith(status: ExpenseApiStatus.loading));
    final result =
        await _expenseApiRepository.getIncomeById(incomeId: incomeId);
    result.fold(
      (failure) => emit(state.copyWith(
          status: ExpenseApiStatus.failure,
          errorMessage: failure.errorMessage)),
      (income) => emit(
          state.copyWith(status: ExpenseApiStatus.success, income: income)),
    );
  }
}
