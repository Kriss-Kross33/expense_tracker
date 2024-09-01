import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:expense_api/expense_api.dart';
import 'package:expense_api_client/expense_api_client.dart';
import 'package:fpdart/fpdart.dart';

/// {@template expense_api_repository}
/// The repository for the expense API.
/// {@endtemplate}
class ExpenseApiRepository extends ExpenseApi {
  final ExpenseApiClient _expenseApiClient;
  final SecureStorageRepository _secureStorageRepository;

  /// {@macro expense_api_repository}
  ExpenseApiRepository({
    required ExpenseApiClient expenseApiClient,
    required SecureStorageRepository secureStorageRepository,
  })  : _expenseApiClient = expenseApiClient,
        _secureStorageRepository = secureStorageRepository;

  @override
  Future<Either<Failure, Success>> login(
      {required LoginModel loginModel}) async {
    try {
      final responseData = await _expenseApiClient.postAuth(
        model: loginModel,
        endpoint: '/auth/login',
      );
      final accessToken = responseData['accessToken'] as String;
      await _cacheAccessToken(accessToken);
      final decodedToken = JWT.decode(accessToken);
      final userPayload = decodedToken.payload as Map<String, dynamic>;
      final user = User(id: userPayload['user_id'] as String);
      await _cacheUser(user);
      return right(Success.instance);
    } on ServerException catch (e) {
      return left(ServerFailure(errorMessage: e.errorMessage));
    } catch (e) {
      return left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _cacheUser(User user) async {
    final userEncoded = jsonEncode(user.toJson());
    await _secureStorageRepository.write(
      key: SecureStorageConstants.user,
      value: userEncoded,
    );
  }

  Future<void> _cacheAccessToken(String accessToken) async {
    await _secureStorageRepository.write(
      key: SecureStorageConstants.accessToken,
      value: accessToken,
    );
  }

  @override
  Future<Either<Failure, Success>> signup({
    required SignupModel signupModel,
  }) async {
    return _handleApiRequest(() => _expenseApiClient.postAuth(
          model: signupModel,
          endpoint: '/auth/signup',
        ));
  }

  @override
  Future<Either<Failure, Success>> addExpense(
      {required Expense expense}) async {
    return _handleApiRequest(() => _expenseApiClient.post(
          model: expense,
          endpoint: '/expenses',
        ));
  }

  @override
  Future<Either<Failure, Success>> addIncome({required Income income}) async {
    return _handleApiRequest(() => _expenseApiClient.post(
          model: income,
          endpoint: '/income',
        ));
  }

  @override
  Future<Either<Failure, Success>> deleteExpense(
      {required String expenseId}) async {
    return _handleApiRequest(() => _expenseApiClient.delete(
          endpoint: '/expenses/$expenseId',
        ));
  }

  /// Handle the API request.
  ///
  /// apiCall: The function to call to send the request.
  ///
  /// Returns the response from the API.
  Future<Either<Failure, Success>> _handleApiRequest(
      Future<dynamic> Function() apiCall) async {
    try {
      await apiCall();
      return right(Success.instance);
    } on ServerException catch (e) {
      return left(ServerFailure(errorMessage: e.errorMessage));
    } catch (e) {
      return left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> deleteIncome(
      {required String incomeId}) async {
    return _handleApiRequest(() => _expenseApiClient.delete(
          endpoint: '/income/$incomeId',
        ));
  }

  @override
  Future<Either<Failure, List<Expense>>> getExpenses() async {
    return _handleApiRequestWithParsingData(
      () => _expenseApiClient.get(endpoint: '/expenses'),
      (data) =>
          List<Expense>.from((data as List).map((e) => Expense.fromJson(e))),
    );
  }

  @override
  Future<Either<Failure, List<Income>>> getIncome() async {
    return _handleApiRequestWithParsingData(
      () => _expenseApiClient.get(endpoint: '/income'),
      (data) =>
          List<Income>.from((data as List).map((e) => Income.fromJson(e))),
    );
  }

  @override
  Future<Either<Failure, User>> getUser({required String userId}) async {
    return _handleApiRequestWithParsingData(
      () => _expenseApiClient.get(endpoint: '/users/$userId'),
      (data) => User.fromJson(data),
    );
  }

  /// Handle the API request with parsing data.
  ///
  /// apiCall: The function to call to send the request.
  /// parseData: The function to parse the data.
  ///
  /// Returns the parsed data.
  Future<Either<Failure, T>> _handleApiRequestWithParsingData<T>(
    Future<dynamic> Function() apiCall,
    T Function(dynamic) parseData,
  ) async {
    try {
      final responseData = await apiCall();
      final parsedData = parseData(responseData);
      return right(parsedData);
    } on ServerException catch (e) {
      return left(ServerFailure(errorMessage: e.errorMessage));
    } catch (e) {
      return left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Expense>> getExpenseById({required String expenseId}) {
    return _handleApiRequestWithParsingData(
      () => _expenseApiClient.get(endpoint: '/expenses/$expenseId'),
      (data) => Expense.fromJson(data),
    );
  }

  @override
  Future<Either<Failure, Income>> getIncomeById({required String incomeId}) {
    return _handleApiRequestWithParsingData(
      () => _expenseApiClient.get(endpoint: '/income/$incomeId'),
      (data) => Income.fromJson(data),
    );
  }
}
