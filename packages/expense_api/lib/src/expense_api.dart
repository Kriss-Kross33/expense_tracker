import 'package:expense_api/expense_api.dart';
import 'package:fpdart/fpdart.dart';

/// {@template expense_api}
/// An abstract class that defines the interface for an Expense API.
/// {@endtemplate}
abstract class ExpenseApi {
  /// Signs up a user.
  ///
  /// Returns a [Success] if successful, or an [Failure] if an error occurs.
  Future<Either<Failure, Success>> signup({required SignupModel signupModel});

  /// Logs in a user.
  ///
  /// Returns a [Success] if successful, or an [Failure] if an error occurs.
  Future<Either<Failure, Success>> login({required LoginModel loginModel});

  /// Fetches the user's information.
  ///
  /// Returns a [User] if successful, or an [Failure] if an error occurs.
  Future<Either<Failure, User>> getUser({required String userId});

  /// Fetches the user's income.
  ///
  /// Returns a [List<Income>] if successful, or an [Failure] if an error occurs.
  Future<Either<Failure, List<Income>>> getIncome();

  /// Fetches the user's income by id.
  ///
  /// [incomeId]: The id of the income to fetch.
  /// Returns a [Income] if successful, or an [Failure] if an error occurs.
  Future<Either<Failure, Income>> getIncomeById({required String incomeId});

  /// Adds an income to the API.
  ///
  /// Returns a [Success] if successful, or an [Failure] if an error occurs.
  Future<Either<Failure, Success>> addIncome({required Income income});

  /// Deletes an income from the API.
  ///
  /// Returns a [Success] if successful, or an [Failure] if an error occurs.
  Future<Either<Failure, Success>> deleteIncome({required String incomeId});

  /// Fetches a list of expenses from the API.
  ///
  /// Returns a [List<Expense>] if successful, or an [Exception] if an error occurs.
  Future<Either<Failure, List<Expense>>> getExpenses();

  /// Fetches an expense by id.
  ///
  /// [expenseId]: The id of the expense to fetch.
  /// Returns a [Expense] if successful, or an [Failure] if an error occurs.
  Future<Either<Failure, Expense>> getExpenseById({required String expenseId});

  /// Adds an expense to the API.
  ///
  /// Returns a [Success] if successful, or an [Failure] if an error occurs.
  Future<Either<Failure, Success>> addExpense({required Expense expense});

  /// Deletes an expense from the API.
  ///
  /// Returns a [Success] if successful, or an [Failure] if an error occurs.
  Future<Either<Failure, Success>> deleteExpense({required String expenseId});
}
