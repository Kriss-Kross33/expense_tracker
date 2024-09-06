import 'dart:async';
import 'dart:convert';

import 'package:errors/errors.dart';
import 'package:expense_api_client/expense_api_client.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements Client {}

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

void main() {
  late MockClient mockClient;
  late MockSecureStorageRepository mockSecureStorageRepository;
  late ExpenseApiClient expenseApiClient;

  setUp(() {
    registerFallbackValue(Uri());
    mockClient = MockClient();
    mockSecureStorageRepository = MockSecureStorageRepository();
    expenseApiClient = ExpenseApiClient(
      client: mockClient,
      secureStorageRepository: mockSecureStorageRepository,
    );
  });

  group('ExpenseApiClient', () {
    test('get returns data on successful request', () async {
      final headers = {
        'Authorization': 'Bearer token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      final response = Response('{"data": "test"}', 200);

      when(() => mockSecureStorageRepository.read(key: any(named: 'key')))
          .thenAnswer((_) async => 'token');
      when(() => mockClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final result = await expenseApiClient.get(endpoint: '/test');

      expect(result.body, equals('{"data": "test"}', 200));
    });

    test('postAuth returns data on successful request', () async {
      final response = Response('{"data": "test"}', 200);
      final model = MockModel();

      when(() => mockClient.post(any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'))).thenAnswer((_) async => response);

      final result =
          await expenseApiClient.postAuth(endpoint: '/test', model: model);

      expect(jsonDecode(result.body), equals({'data': 'test'}));
    });

    test('post throws ServerException on failed request', () async {
      final response = Response('', 400);
      final model = MockModel();

      when(() => mockSecureStorageRepository.read(key: any(named: 'key')))
          .thenAnswer((_) async => 'token');
      when(() => mockClient.post(any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'))).thenAnswer((_) async => response);

      expect(() => expenseApiClient.post(endpoint: '/test', model: model),
          throwsA(isA<ServerException>()));
    });

    test('delete returns true on successful request', () async {
      final response = Response('', 200);

      when(() => mockSecureStorageRepository.read(key: any(named: 'key')))
          .thenAnswer((_) async => 'token');
      when(() => mockClient.delete(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final result = await expenseApiClient.delete(endpoint: '/test');

      expect(result, isTrue);
    });

    test('delete throws ServerException on failed request', () async {
      final headers = {
        'Authorization': 'Bearer token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      final response = Response('', 400);

      when(() => mockSecureStorageRepository.read(key: any(named: 'key')))
          .thenAnswer((_) async => 'token');
      when(() => mockClient.delete(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      expect(() => expenseApiClient.delete(endpoint: '/test'),
          throwsA(isA<ServerException>()));
    });

    test('post throws ServerException on unauthorized request', () async {
      final response = Response('{"error": "Unauthorized"}', 401);
      final model = MockModel();

      when(() => mockSecureStorageRepository.read(key: any(named: 'key')))
          .thenAnswer((_) async => 'token');
      when(() => mockClient.post(any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'))).thenAnswer((_) async => response);

      expect(
        () => expenseApiClient.post(endpoint: '/test', model: model),
        throwsA(isA<ServerException>()),
      );
    });
  });
}

class MockModel extends Mock {
  Future<Map<String, dynamic>> toJson() async {
    return {};
  }
}
