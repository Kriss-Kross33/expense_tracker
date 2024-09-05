import 'dart:convert';

import 'package:expense_api/expense_api.dart';
import 'package:expense_api_client/expense_api_client.dart';
import 'package:expense_api_repository/expense_api_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';
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
      final loginModel =
          LoginModel(email: 'test@example.com', password: 'password');
      final loginResponse = {
        'accessToken': 'access_token',
        'userId': 'userId',
      };
      final userPayload = {'userId': 'userId'};
      final user = User(id: 'userId');

      test('returns Success when login is successful', () async {
        // Arrange
        when(() => mockExpenseApiClient.postAuth(
              model: loginModel,
              endpoint: '/auth/login',
            )).thenAnswer((_) async {
          print('Mock postAuth called with model: $loginModel');
          return Response(jsonEncode(loginResponse), 200);
        });

        when(() => mockSecureStorageRepository.write(
              key: any(named: 'key'),
              value: any(named: 'value'),
            )).thenAnswer((_) async {
          print('Mock secureStorageRepository.write called');
          return;
        });

        // Act
        print('Calling expenseApiRepository.login');
        final result = await expenseApiRepository.login(loginModel: loginModel);

        // Debug print
        print('Login result: $result');

        // Assert
        expect(result, isA<Either<Failure, Success>>());
        result.fold(
          (failure) {
            print('Failure details: $failure');
            fail('Expected Right<Failure, Success>, but got Left($failure)');
          },
          (success) {
            expect(success, isA<Success>());
            verify(() => mockExpenseApiClient.postAuth(
                  model: loginModel,
                  endpoint: '/auth/login',
                )).called(1);
            verify(() => mockSecureStorageRepository.write(
                  key: SecureStorageConstants.accessToken,
                  value: 'access_token',
                )).called(1);
            verify(() => mockSecureStorageRepository.write(
                  key: SecureStorageConstants.user,
                  value: jsonEncode(userPayload),
                )).called(1);
          },
        );
      });

      test('returns ServerFailure when login fails', () async {
        // Arrange
        when(() => mockExpenseApiClient.postAuth(
                  model: loginModel,
                  endpoint: '/auth/login',
                ))
            .thenThrow(
                ServerException(errorMessage: 'An unexpected error occurred'));

        // Act
        final result = await expenseApiRepository.login(loginModel: loginModel);

        // Assert
        expect(result, isA<Left<Failure, Success>>());
        expect(result, isA<Left<Failure, Success>>());
        expect((result as Left).value, isA<ServerFailure>());
        // result.fold(
        //   (failure) {
        //     expect(failure, isA<ServerFailure>());
        //     expect((failure as ServerFailure).errorMessage,
        //         'An unexpected error occurred');
        //   },
        //   (success) {
        //     fail('Expected Left<Failure, Success>, but got Right($success)');
        //   },
        // );
      });
    });

    group('signup', () {
      final signupModel = SignupModel(
        email: 'test@example.com',
        password: 'password',
        name: 'Test User',
      );
      test('returns Success when signup is successful', () async {
        // Arrange
        when(() => mockExpenseApiClient.postAuth(
              model: signupModel,
              endpoint: '/auth/signup',
            )).thenAnswer((_) async => Response('Success', 200));

        // Act
        final result =
            await expenseApiRepository.signup(signupModel: signupModel);

        // Assert
        expect(result, equals(right(Success.instance)));
        verify(() => mockExpenseApiClient.postAuth(
              model: signupModel,
              endpoint: '/auth/signup',
            )).called(1);
      });

      test('returns ServerFailure when ServerException is thrown', () async {
        // Arrange
        when(() => mockExpenseApiClient.postAuth(
              model: signupModel,
              endpoint: '/auth/signup',
            )).thenThrow(ServerException(errorMessage: 'Server error'));

        // Act
        final result =
            await expenseApiRepository.signup(signupModel: signupModel);

        // Assert
        expect(result, isA<Left<Failure, Success>>());
        expect((result as Left).value, isA<ServerFailure>());
      });
    });

    group('addExpense', () {
      final expense = Expense(
        id: '1',
        estimatedAmount: 100,
        nameOfItem: 'Test expense',
        category: 'Test category',
      );
      test('returns Success when addExpense is successful', () async {
        // Arrange
        when(() => mockExpenseApiClient.post(
              model: expense,
              endpoint: '/user/expenditure',
            )).thenAnswer((_) async => Response('Success', 200));

        // Act
        final result = await expenseApiRepository.addExpense(expense: expense);

        // Assert
        expect(result, equals(right(Success.instance)));
        verify(() => mockExpenseApiClient.post(
              model: expense,
              endpoint: '/user/expenditure',
            )).called(1);
      });

      test('returns ServerFailure when ServerException is thrown', () async {
        // Arrange
        when(() => mockExpenseApiClient.post(
              model: expense,
              endpoint: '/user/expenditure',
            )).thenThrow(ServerException(errorMessage: 'Server error'));

        // Act
        final result = await expenseApiRepository.addExpense(expense: expense);

        // Assert
        expect(result, isA<Left<Failure, Success>>());
        expect((result as Left).value, isA<ServerFailure>());
        // expect((result.value as ServerFailure).errorMessage, 'Server error');
      });
    });

    group('addIncome', () {
      final income = Income(amount: 100, nameOfRevenue: 'Test income');
      test('returns Success when addIncome is successful', () async {
        // Arrange
        when(() => mockExpenseApiClient.post(
              model: income,
              endpoint: '/user/income',
            )).thenAnswer((_) async => Response('Success', 200));

        // Act
        final result = await expenseApiRepository.addIncome(income: income);

        // Assert
        expect(result, equals(right(Success.instance)));
        verify(() => mockExpenseApiClient.post(
              model: income,
              endpoint: '/user/income',
            )).called(1);
      });

      test('returns ServerFailure when ServerException is thrown', () async {
        // Arrange
        when(() => mockExpenseApiClient.post(
              model: income,
              endpoint: '/user/income',
            )).thenThrow(ServerException(errorMessage: 'Server error'));

        // Act
        final result = await expenseApiRepository.addIncome(income: income);

        // Assert
        expect(result, isA<Left<Failure, Success>>());
        expect((result as Left).value, isA<ServerFailure>());
        //  expect((result.value as ServerFailure).errorMessage, 'Server error');
      });
    });

    group('deleteExpense', () {
      final expenseId = '1';
      test('returns Success when deleteExpense is successful', () async {
        // Arrange
        when(() => mockExpenseApiClient.delete(
              endpoint: '/user/expenditure/$expenseId',
            )).thenAnswer((_) async => true);

        // Act
        final result =
            await expenseApiRepository.deleteExpense(expenseId: expenseId);

        // Assert
        expect(result, equals(right(Success.instance)));
        verify(() => mockExpenseApiClient.delete(
              endpoint: '/user/expenditure/$expenseId',
            )).called(1);
      });

      test('returns ServerFailure when ServerException is thrown', () async {
        // Arrange
        when(() => mockExpenseApiClient.delete(
              endpoint: '/user/expenditure/$expenseId',
            )).thenThrow(ServerException(errorMessage: 'Server error'));

        // Act
        final result =
            await expenseApiRepository.deleteExpense(expenseId: expenseId);

        // Assert
        expect(result, isA<Left<Failure, Success>>());
        expect((result as Left).value, isA<ServerFailure>());
        // expect((result.value as ServerFailure).errorMessage, 'Server error');
      });
    });

    group('deleteIncome', () {
      final incomeId = '1';
      test('returns Success when deleteIncome is successful', () async {
        // Arrange
        when(() => mockExpenseApiClient.delete(
              endpoint: '/user/income/$incomeId',
            )).thenAnswer((_) async => true);

        // Act
        final result =
            await expenseApiRepository.deleteIncome(incomeId: incomeId);

        // Assert
        expect(result, equals(right(Success.instance)));
        verify(() => mockExpenseApiClient.delete(
              endpoint: '/user/income/$incomeId',
            )).called(1);
      });

      test('returns ServerFailure when ServerException is thrown', () async {
        // Arrange
        when(() => mockExpenseApiClient.delete(
              endpoint: '/user/income/$incomeId',
            )).thenThrow(ServerException(errorMessage: 'Server error'));

        // Act
        final result =
            await expenseApiRepository.deleteIncome(incomeId: incomeId);

        // Assert
        expect(result, isA<Left<Failure, Success>>());
        expect((result as Left).value, isA<ServerFailure>());
        // expect((result.value as ServerFailure).errorMessage, 'Server error');
      });
    });

    group('getExpenses', () {
      final expensesResponse = {
        'data': [
          {
            'id': '1',
            'estimatedAmount': 100,
            'nameOfItem': 'Test expense',
            'category': 'Test category'
          }
        ]
      };
      final expenses = [
        Expense(
          id: '1',
          estimatedAmount: 100,
          nameOfItem: 'Test expense',
          category: 'Test category',
        )
      ];

      test('returns List<Expense> when getExpenses is successful', () async {
        // Arrange
        when(() => mockExpenseApiClient.get(endpoint: '/user/expenditure'))
            .thenAnswer((_) async => Response('Success', 200));

        // Act
        final result = await expenseApiRepository.getExpenses();

        // Assert
        result.fold(
          (failure) {
            fail('Expected Right, but got Left($failure)');
          },
          (resultExpenses) {
            expect(resultExpenses, isA<List<Expense>>());
            expect(resultExpenses.length, equals(expenses.length));
            for (int i = 0; i < resultExpenses.length; i++) {
              expect(resultExpenses[i].id, equals(expenses[i].id));
              expect(resultExpenses[i].estimatedAmount,
                  equals(expenses[i].estimatedAmount));
              expect(
                  resultExpenses[i].nameOfItem, equals(expenses[i].nameOfItem));
              expect(resultExpenses[i].category, equals(expenses[i].category));
            }
          },
        );
        verify(() => mockExpenseApiClient.get(endpoint: '/user/expenditure'))
            .called(1);
      });

      test('returns ServerFailure when ServerException is thrown', () async {
        // Arrange
        when(() => mockExpenseApiClient.get(endpoint: '/user/expenditure'))
            .thenThrow(ServerException(errorMessage: 'Server error'));

        // Act
        final result = await expenseApiRepository.getExpenses();

        // Assert
        expect(result, isA<Left<Failure, List<Expense>>>());
        expect((result as Left).value, isA<ServerFailure>());
        // expect((result.value as ServerFailure).errorMessage, 'Server error');
      });
    });

    group('getIncome', () {
      final incomeResponse = {
        'data': [
          {'id': '1', 'amount': 100, 'nameOfRevenue': 'Test income'}
        ]
      };
      final incomes = [
        Income(
          id: '1',
          amount: 100,
          nameOfRevenue: 'Test income',
        )
      ];

      test('returns List<Income> when getIncome is successful', () async {
        // Arrange
        when(() => mockExpenseApiClient.get(endpoint: '/user/income'))
            .thenAnswer((_) async => Response('Success', 200));

        // Act
        final result = await expenseApiRepository.getIncome();

        // Assert
        result.fold(
          (failure) {
            fail('Expected Right, but got Left($failure)');
          },
          (resultIncomes) {
            expect(resultIncomes, isA<List<Income>>());
            expect(resultIncomes.length, equals(incomes.length));
            for (int i = 0; i < resultIncomes.length; i++) {
              expect(resultIncomes[i].id, equals(incomes[i].id));
              expect(resultIncomes[i].amount, equals(incomes[i].amount));
              expect(resultIncomes[i].nameOfRevenue,
                  equals(incomes[i].nameOfRevenue));
            }
          },
        );
        verify(() => mockExpenseApiClient.get(endpoint: '/user/income'))
            .called(1);
      });

      test('returns ServerFailure when ServerException is thrown', () async {
        // Arrange
        when(() => mockExpenseApiClient.get(endpoint: '/user/income'))
            .thenThrow(ServerException(errorMessage: 'Server error'));

        // Act
        final result = await expenseApiRepository.getIncome();

        // Assert
        expect(result, isA<Left<Failure, List<Income>>>());
        expect((result as Left).value, isA<ServerFailure>());
        // expect((result.value as ServerFailure).errorMessage, 'Server error');
      });
    });

    group('getUser', () {
      final userId = '1';
      final userResponse = {'id': '1', 'email': 'test@example.com'};
      final user = User(id: '1', email: 'test@example.com');

      test('returns User when getUser is successful', () async {
        // Arrange
        when(() => mockExpenseApiClient.get(
                endpoint: '/auth/user/$userId/profile'))
            .thenAnswer((_) async => Response('Success', 200));

        // Act
        final result = await expenseApiRepository.getUser(userId: userId);

        // Assert
        expect(result, equals(right(user)));
        verify(() => mockExpenseApiClient.get(
            endpoint: '/auth/user/$userId/profile')).called(1);
      });

      test('returns ServerFailure when ServerException is thrown', () async {
        // Arrange
        when(() => mockExpenseApiClient.get(
                endpoint: '/auth/user/$userId/profile'))
            .thenThrow(ServerException(errorMessage: 'Server error'));

        // Act
        final result = await expenseApiRepository.getUser(userId: userId);

        // Assert
        expect(result, isA<Left<Failure, User>>());
        expect((result as Left).value, isA<ServerFailure>());
        // expect((result.value as ServerFailure).errorMessage, 'Server error');
      });
    });

    group('getExpenseById', () {
      final expenseId = '1';
      final expenseResponse = {
        'id': '1',
        'estimatedAmount': 100,
        'nameOfItem': 'Test expense',
        'category': 'Test category',
      };
      final expense = Expense(
        id: '1',
        estimatedAmount: 100,
        nameOfItem: 'Test expense',
        category: 'Test category',
      );

      test('returns Expense when getExpenseById is successful', () async {
        // Arrange
        when(() => mockExpenseApiClient.get(
                endpoint: '/user/expenditure/$expenseId'))
            .thenAnswer((_) async => Response('Success', 200));

        // Act
        final result =
            await expenseApiRepository.getExpenseById(expenseId: expenseId);

        // Assert
        result.fold(
          (failure) {
            print('Unexpected failure: $failure');
            fail('Expected Right(Expense), but got Left($failure)');
          },
          (resultExpense) {
            expect(resultExpense, isA<Expense>());
            expect(resultExpense.id, equals(expense.id));
            expect(
                resultExpense.estimatedAmount, equals(expense.estimatedAmount));
            expect(resultExpense.nameOfItem, equals(expense.nameOfItem));
            expect(resultExpense.category, equals(expense.category));
          },
        );
        verify(() => mockExpenseApiClient.get(
            endpoint: '/user/expenditure/$expenseId')).called(1);
      });

      test('returns ServerFailure when ServerException is thrown', () async {
        // Arrange
        when(() => mockExpenseApiClient.get(
                endpoint: '/user/expenditure/$expenseId'))
            .thenThrow(ServerException(errorMessage: 'Server error'));

        // Act
        final result =
            await expenseApiRepository.getExpenseById(expenseId: expenseId);

        // Assert
        expect(result, isA<Left<Failure, Expense>>());
        expect((result as Left).value, isA<ServerFailure>());
        // expect((result.value as ServerFailure).errorMessage, 'Server error');
      });
    });

    group('getIncomeById', () {
      final incomeId = '1';
      final incomeResponse = {
        'id': '1',
        'amount': 100,
        'nameOfRevenue':
            'Test income' // Changed from 'description' to 'nameOfRevenue'
      };
      final income = Income(
        id: '1',
        amount: 100,
        nameOfRevenue: 'Test income',
      );

      test('returns Income when getIncomeById is successful', () async {
        // Arrange
        when(() => mockExpenseApiClient.get(endpoint: '/user/income/$incomeId'))
            .thenAnswer((_) async => Response('Success', 200));

        // Act
        final result =
            await expenseApiRepository.getIncomeById(incomeId: incomeId);

        // Assert
        expect(result, equals(right(income)));
        verify(() =>
                mockExpenseApiClient.get(endpoint: '/user/income/$incomeId'))
            .called(1);
      });

      test('returns ServerFailure when ServerException is thrown', () async {
        // Arrange
        when(() => mockExpenseApiClient.get(endpoint: '/user/income/$incomeId'))
            .thenThrow(ServerException(errorMessage: 'Server error'));

        // Act
        final result =
            await expenseApiRepository.getIncomeById(incomeId: incomeId);

        // Assert
        expect(result, isA<Left<Failure, Income>>());
        expect((result as Left).value, isA<ServerFailure>());
        // expect((result.value as ServerFailure).errorMessage, 'Server error');
      });
    });
  });
}
