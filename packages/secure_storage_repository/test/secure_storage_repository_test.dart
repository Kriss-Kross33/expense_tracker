import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:secure_storage_repository/storage_repository.dart';
import 'package:test/test.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('SecureStorageRepository', () {
    late MockFlutterSecureStorage mockSecureStorage;
    late SecureStorageRepository repository;

    setUp(() {
      mockSecureStorage = MockFlutterSecureStorage();
      repository = SecureStorageRepository(secureStorage: mockSecureStorage);
    });

    test('write should call secureStorage.write with correct parameters',
        () async {
      const key = 'testKey';
      const value = 'testValue';
      when(() => mockSecureStorage.write(key: key, value: value))
          .thenAnswer((_) async {});

      await repository.write(key: key, value: value);

      verify(() => mockSecureStorage.write(key: key, value: value)).called(1);
    });

    test('read should return value from secureStorage.read', () async {
      const key = 'testKey';
      const value = 'testValue';
      when(() => mockSecureStorage.read(key: key))
          .thenAnswer((_) async => value);

      final result = await repository.read(key: key);

      expect(result, equals(value));
      verify(() => mockSecureStorage.read(key: key)).called(1);
    });

    test('delete should call secureStorage.delete with correct key', () async {
      const key = 'testKey';
      when(() => mockSecureStorage.delete(key: key)).thenAnswer((_) async {});

      await repository.delete(key: key);

      verify(() => mockSecureStorage.delete(key: key)).called(1);
    });

    test('deleteAll should call secureStorage.deleteAll', () async {
      when(() => mockSecureStorage.deleteAll()).thenAnswer((_) async {});

      await repository.deleteAll();

      verify(() => mockSecureStorage.deleteAll()).called(1);
    });
  });
}
