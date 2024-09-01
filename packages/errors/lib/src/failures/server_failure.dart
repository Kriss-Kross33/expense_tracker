import 'failures.dart';

/// {@template server_failure}
/// A failure that occurs when there is an error in the server.
/// {@endtemplate}
class ServerFailure extends Failure {
  ServerFailure({required this.errorMessage})
      : super(errorMessage: errorMessage);
  final String errorMessage;
}
