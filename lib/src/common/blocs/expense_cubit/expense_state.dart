part of 'expense_cubit.dart';

enum ExpenseApiStatus {
  initial,
  loading,
  success,
  failure,
  postSuccess,
}

extension ExpenseApiStatusX on ExpenseApiStatus {
  bool get isInitial => this == ExpenseApiStatus.initial;
  bool get isLoading => this == ExpenseApiStatus.loading;
  bool get isSuccess => this == ExpenseApiStatus.success;
  bool get isFailure => this == ExpenseApiStatus.failure;
  bool get isPostSuccess => this == ExpenseApiStatus.postSuccess;
}

final class ExpenseApiState extends Equatable {
  const ExpenseApiState({
    this.status = ExpenseApiStatus.initial,
    this.errorMessage,
    this.expenses = const [],
    this.incomeList = const [],
    this.expense = Expense.empty,
    this.income = Income.empty,
    this.user = User.empty,
    this.totalExpense = 0,
    this.totalIncome = 0,
    this.balance = 0,
    this.allCategories = const [],
  });

  final ExpenseApiStatus status;
  final String? errorMessage;
  final List<Expense> expenses;

  final List<Income> incomeList;
  final Expense expense;
  final Income income;
  final User user;
  final double totalExpense;
  final double totalIncome;
  final double balance;
  final List<CategoryExpense> allCategories;

  ExpenseApiState copyWith({
    ExpenseApiStatus? status,
    String? errorMessage,
    List<Expense>? expenses,
    List<Income>? incomeList,
    Expense? expense,
    Income? income,
    User? user,
    double? totalExpense,
    double? totalIncome,
    double? balance,
    List<CategoryExpense>? allCategories,
  }) {
    return ExpenseApiState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      expenses: expenses ?? this.expenses,
      incomeList: incomeList ?? this.incomeList,
      expense: expense ?? this.expense,
      income: income ?? this.income,
      user: user ?? this.user,
      totalExpense: totalExpense ?? this.totalExpense,
      totalIncome: totalIncome ?? this.totalIncome,
      balance: balance ?? this.balance,
      allCategories: allCategories ?? this.allCategories,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        expenses,
        incomeList,
        expense,
        income,
        user,
        totalExpense,
        totalIncome,
        balance,
        allCategories,
      ];
}

class CategoryExpense extends Equatable {
  /// The category name
  final String category;

  /// The amount of the expense for the category
  final double amount;

  const CategoryExpense({required this.category, required this.amount});

  @override
  List<Object?> get props => [category, amount];
}
