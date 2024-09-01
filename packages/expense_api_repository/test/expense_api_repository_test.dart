import 'package:expense_api/expense_api.dart';
import 'package:expense_api_client/expense_api_client.dart';
import 'package:expense_api_repository/expense_api_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockExpenseApiClient extends Mock implements ExpenseApiClient {}

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

void main() {
  late ExpenseApiRepository expenseApiRepository;
  late MockExpenseApiClient mockExpenseApiClient;
  late MockSecureStorageRepository mockSecureStorageRepository;

  setUp(() {
    mockExpenseApiClient = MockExpenseApiClient();
    mockSecureStorageRepository = MockSecureStorageRepository();
    expenseApiRepository = ExpenseApiRepository(
      expenseApiClient: mockExpenseApiClient,
      secureStorageRepository: mockSecureStorageRepository,
    );
  });

  group('ExpenseApiRepository', () {
    group('login', () {
      test('returns Success when login is successful', () async {
        // Arrange
        final loginModel =
            LoginModel(email: 'test@example.com', password: 'password');
        when(() => mockExpenseApiClient.postAuth(
              model: loginModel,
              endpoint: '/auth/login',
            )).thenAnswer((_) async => {'accessToken': 'fake_token'});
        when(() => mockSecureStorageRepository.write(
              key: any(named: 'key'),
              value: any(named: 'value'),
            )).thenAnswer((_) async {});

        // Act
        final result = await expenseApiRepository.login(loginModel: loginModel);

        // Assert
        expect(result, isA<Right<Failure, Success>>());
        verify(() => mockExpenseApiClient.postAuth(
              model: loginModel,
              endpoint: '/auth/login',
            )).called(1);
        verify(() => mockSecureStorageRepository.write(
              key: SecureStorageConstants.accessToken,
              value: 'fake_token',
            )).called(1);
      });

      test('returns ServerFailure when ServerException is thrown', () async {
        // Arrange
        final loginModel =
            LoginModel(email: 'test@example.com', password: 'password');
        when(() => mockExpenseApiClient.postAuth(
              model: loginModel,
              endpoint: '/auth/login',
            )).thenThrow(ServerException(errorMessage: 'Server error'));

        // Act
        final result = await expenseApiRepository.login(loginModel: loginModel);

        // Assert
        expect(result, isA<Left<Failure, Success>>());
        expect((result as Left).value, isA<ServerFailure>());
        // expect((result.value as ServerFailure).errorMessage, 'Server error');
      });
    });
  });
}
