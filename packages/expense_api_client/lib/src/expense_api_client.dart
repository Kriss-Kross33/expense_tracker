import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:errors/errors.dart';
import 'package:http/http.dart';
import 'package:secure_storage_repository/storage_repository.dart';

/// {@template expense_api_client}
/// Expense API client.
/// {@endtemplate}
class ExpenseApiClient {
  final Client _client;
  final SecureStorageRepository _secureStorageRepository;

  /// {@macro expense_api_client}
  ExpenseApiClient(
      {required Client client,
      required SecureStorageRepository secureStorageRepository})
      : _client = client,
        _secureStorageRepository = secureStorageRepository;

  static const String baseUrl =
      'https://personal-expense-tracker.myladder.africa';

  Map<String, String> _getHeaders() {
    return {};
  }

  Future<Map<String, String>> _getHeadersWithToken() async {
    final accessToken = await _secureStorageRepository.read(
      key: SecureStorageConstants.accessToken,
    );
    return {
      'Authorization': 'Bearer $accessToken',
    };
  }

  /// Get a resource from the API.
  ///
  /// endpoint: The endpoint to get the resource from.
  /// path: The path to get the resource from.
  ///
  /// Returns the response from the API.
  Future<Map<String, dynamic>> get({
    required String endpoint,
    String path = '',
  }) async {
    return _sendRequest(() async {
      final Map<String, dynamic> headers = await _getHeadersWithToken();
      final uri = Uri.parse('$baseUrl$endpoint$path');
      print('$baseUrl$endpoint');
      final response =
          await _client.get(uri, headers: headers as Map<String, String>?);

      return response;
    });
  }

  /// Post a resource to the API.
  ///
  /// endpoint: The endpoint to post the resource to.
  /// model: The model to post to the API.
  ///
  /// Returns the response from the API.
  Future<Map<String, dynamic>> postAuth({
    required String endpoint,
    required dynamic model,
  }) async {
    return _sendRequest(() async {
      final headers = await _getHeaders();
      final uri = Uri.parse('$baseUrl$endpoint');
      print('$baseUrl$endpoint');
      print(await model.toJson());
      final toJson = await model.toJson();
      print(json.encode(toJson));

      final response = await _client
          .post(
            uri,
            headers: headers,
            body: json.encode(
              await model.toJson(),
            ),
          )
          .timeout(const Duration(seconds: 45));
      return response;
    });
  }

  /// Post a resource to the API.
  ///
  /// endpoint: The endpoint to post the resource to.
  /// model: The model to post to the API.
  ///
  /// Returns the response from the API.
  Future<Map<String, dynamic>> post({
    required String endpoint,
    required dynamic model,
  }) async {
    return _sendRequest(() async {
      final headers = await _getHeadersWithToken();
      final uri = Uri.parse('$baseUrl$endpoint');
      print('$baseUrl$endpoint');
      print(await model.toJson());
      final toJson = await model.toJson();
      print(json.encode(toJson));

      final response = await _client
          .post(
            uri,
            headers: headers,
            body: json.encode(
              await model.toJson(),
            ),
          )
          .timeout(const Duration(seconds: 45));
      return response;
    });
  }

  /// Delete a resource from the API.
  ///
  /// endpoint: The endpoint to delete the resource from.
  /// Returns true if the resource was deleted, false otherwise.
  Future<bool> delete({
    required String endpoint,
  }) async {
    final headers = await _getHeadersWithToken();
    final url = Uri.parse(
      '$baseUrl/$endpoint',
    );
    final response = await _client.delete(url, headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException(errorMessage: 'Deletion failed');
    }
  }

  /// Send a request to the API.
  ///
  /// callServer: The function to call to send the request.
  ///
  /// Returns the response from the API.
  Future<Map<String, dynamic>> _sendRequest(
    Future<Response> Function() callServer,
  ) async {
    try {
      final response = await callServer();
      print(response.body);
      final responseBody = json.decode(response.body) as Map<String, dynamic>?;
      // wayaLog.w(responseBody);
      if (responseBody == null) {
        throw const ServerException(errorMessage: 'Contact Customer Service');
      }
      print('StatusCode: ${response.statusCode}');
      if (response.statusCode != 200 && response.statusCode != 201) {
        print('Heeeeeeeeeeeey');
        final errorMessage = responseBody['message'] as String;
        print('ERROR=> $errorMessage');
        throw ServerException(
          errorMessage: errorMessage,
        );
        //  }
      }
      print(responseBody);
      return responseBody;
    } on TimeoutException {
      throw TimeoutException('Timeout');
    } on SocketException {
      throw const ServerException(errorMessage: 'No internet');
    } on ServerException catch (e) {
      print(e);
      rethrow;
    } catch (e) {
      // await FirebaseCrashlytics.instance
      //     .recordError(e, null, reason: 'a non-fatal error');
      print(e);
      throw const ServerException(errorMessage: 'Unknown Error');
    }
  }
}
