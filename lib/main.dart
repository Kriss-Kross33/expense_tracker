import 'package:expense_api_client/expense_api_client.dart';
import 'package:expense_api_repository/expense_api_repository.dart';
import 'package:expense_track/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  final client = http.Client();
  final secureStorageRepository = SecureStorageRepository(
    secureStorage: const FlutterSecureStorage(),
  );
  final expenseApiClient = ExpenseApiClient(
    client: client,
    secureStorageRepository: secureStorageRepository,
  );
  final expenseApiRepository = ExpenseApiRepository(
    expenseApiClient: expenseApiClient,
    secureStorageRepository: secureStorageRepository,
  );
  runApp(App(
    expenseApiRepository: expenseApiRepository,
  ));
}
