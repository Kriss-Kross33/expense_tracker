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
      final response = await _expenseApiClient.postAuth(
        model: loginModel,
        endpoint: '/auth/login',
      );

      final responseBody = response.body;

      final Map<String, dynamic> responseData = json.decode(responseBody);
      final accessToken = responseData['accessToken'] as String?;
      if (accessToken == null) {
        return left(ServerFailure(
            errorMessage: 'Access token is missing from the response'));
      }
      print('accessToken: $accessToken');
      await _cacheAccessToken(accessToken);
      await _cacheUserFromToken(accessToken);

      return right(Success.instance);
    } on ServerException catch (e) {
      return left(ServerFailure(errorMessage: e.errorMessage));
    } catch (e) {
      return left(UnknownFailure(
          errorMessage: 'An unexpected error occurred during login'));
    }
  }

  Future<void> _cacheAccessToken(String accessToken) async {
    await _secureStorageRepository.write(
      key: SecureStorageConstants.accessToken,
      value: accessToken,
    );
  }

  Future<void> _cacheUserFromToken(String accessToken) async {
    final jwtToken = JWT.decode(accessToken);
    print('jwtToken: ${jwtToken.payload}');
    final userId = jwtToken.payload['userId'] as String?;
    if (userId == null) {
      throw ServerException(errorMessage: 'User ID is missing from the token');
    }
    await _secureStorageRepository.write(
      key: SecureStorageConstants.user,
      value: jsonEncode({'userId': userId}),
    );
  }

  Future<void> _cacheUser(User user) async {
    final userEncoded = jsonEncode(user.toJson());
    await _secureStorageRepository.write(
      key: SecureStorageConstants.user,
      value: userEncoded,
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
    try {
      await _expenseApiClient.post(
        model: expense,
        endpoint: '/user/expenditure',
      );
      return right(Success.instance);
    } on ServerException catch (e) {
      return left(ServerFailure(errorMessage: e.errorMessage));
    } catch (e) {
      return left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> addIncome({required Income income}) async {
    try {
      await _expenseApiClient.post(
        model: income,
        endpoint: '/user/income',
      );
      return right(Success.instance);
    } on ServerException catch (e) {
      return left(ServerFailure(errorMessage: e.errorMessage));
    } catch (e) {
      return left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> deleteExpense(
      {required String expenseId}) async {
    return _handleApiRequest(() => _expenseApiClient.delete(
          endpoint: '/user/expenditure/$expenseId',
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
          endpoint: '/user/income/$incomeId',
        ));
  }

  @override
  Future<Either<Failure, List<Expense>>> getExpenses() {
    return _handleApiRequestWithParsingData(
        () => _expenseApiClient.get(endpoint: '/user/expenditure'), (data) {
      final responseData = json.decode(data.body) as List<dynamic>;
      return List<Expense>.from((responseData).map((e) => Expense.fromJson(e)));
    });
  }

  @override
  Future<Either<Failure, List<Income>>> getIncome() {
    return _handleApiRequestWithParsingData(
      () => _expenseApiClient.get(endpoint: '/user/income'),
      (data) {
        final responseData = json.decode(data.body) as List<dynamic>;
        return List<Income>.from(
          (responseData).map((e) => Income.fromJson(e)),
        );
      },
    );
  }

  @override
  Future<Either<Failure, User>> getUser({required String userId}) async {
    return _handleApiRequestWithParsingData(
      () => _expenseApiClient.get(endpoint: '/auth/user/$userId/profile'),
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
  Future<Either<Failure, Expense>> getExpenseById(
      {required String expenseId}) async {
    return _handleApiRequestWithParsingData(
      () => _expenseApiClient.get(endpoint: '/user/expenditure/$expenseId'),
      (data) => Expense.fromJson(data),
    );
  }

  @override
  Future<Either<Failure, Income>> getIncomeById({required String incomeId}) {
    return _handleApiRequestWithParsingData(
      () => _expenseApiClient.get(endpoint: '/user/income/$incomeId'),
      (data) => Income.fromJson(data),
    );
  }
}
